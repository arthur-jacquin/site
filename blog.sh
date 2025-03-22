#!/bin/sh
# See LICENSE file for copyright and license details.

# blog.sh is a small POSIX shell script to help publishing content on both
# https and gemini protocol. Given the content of the content/ directory, it
# generates both ${GENERATED}/gmi and ${GENERATED}/html. While non-gemtext files
# are simply mirrored, gemtext files are processed in various ways:
# * converted to html for the html target
# * a few substitution (for example, {{AUTHOR_NAME}} will be replaced by the
#    value specified in config.sh)
# * raw, target-specific content can still be specified by starting a line with
#    @g or @h
# Additionnally, gemtext files can be given a date (filename must ends with
# .YYYY-MM-DD.gmi) so they appear in automatically generated atom feeds and are
# listed by the special {{POSTS}} variable.

log() echo $1

source config.sh

cd $(dirname $0)
mkdir -p ${GENERATED} ${GENERATED}/gmi ${GENERATED}/html

# list *.YYYY-MM-DD.gmi files
find -L content -type f -name "*.gmi" | \
    sed -n -e "s/content\/\(.*\)\.\(....-..-..\)\.gmi/\1|\2/p" | \
    sort -t \| -k 2 | \
    awk -F \| '{
        printf $0"|";
        system("sed -n -e \"/^# /{s/^# //;p;q}\" content/"$1"."$2".gmi | tr -d \"\n\"");
        printf "\n";
    }' > ${GENERATED}/index
sort -t \| -k 2 -r ${GENERATED}/index | \
    awk -F \| '{
        print "=> {{PROTOCOL}}://'${URL_BASE}'/"$1".{{EXTENSION}} "$2" "$3;
    }' > ${GENERATED}/posts.gmi

# create atom feeds
log "Creating: atom feeds"
tail -n ${FEED_MAX_ENTRIES} ${GENERATED}/index | \
    awk -F \| '{ \
        printf "<entry>\n"; \
        printf "    <title>"$3"</title>\n"; \
        printf "    <updated>"$2"T00:00:00Z</updated>\n"; \
        printf "    <id>{{PROTOCOL}}://${URL_BASE}/"$1".{{EXTENSION}}</id>\n"; \
        printf "    <link rel=\"alternate\" href=\"{{PROTOCOL}}://'${URL_BASE}'/"$1".{{EXTENSION}}\"/>\n"; \
        printf "</entry>\n"; \
    }' > ${GENERATED}/feed_entries.atom
sed \
    -e "s/{{AUTHOR_EMAIL}}/${AUTHOR_EMAIL}/g" \
    -e "s/{{AUTHOR_NAME}}/${AUTHOR_NAME}/g" \
    -e "s/{{FEED_TITLE}}/${FEED_TITLE}/g" \
    -e "s/{{URL_BASE}}/${URL_BASE}/g" \
    -e "s/{{URL_FEED_PATH}}/{{EXTENSION}}_feed.atom/g" \
    -e "s/{{CURRENT_DATE}}/`date -u +"%Y-%m-%d"`/g" \
    -e "/{{FEED_ENTRIES}}/r ${GENERATED}/feed_entries.atom" \
    -e "/{{FEED_ENTRIES}}/d" \
    template.atom > ${GENERATED}/feed.atom
sed -e "s/{{PROTOCOL}}/gemini/g;s/{{EXTENSION}}/gmi/g" ${GENERATED}/feed.atom \
    > ${GENERATED}/gmi/gmi_feed.atom
sed -e "s/{{PROTOCOL}}/https/g;s/{{EXTENSION}}/html/g" ${GENERATED}/feed.atom \
    > ${GENERATED}/gmi/html_feed.atom
cp ${GENERATED}/gmi/gmi_feed.atom ${GENERATED}/gmi/html_feed.atom \
    ${GENERATED}/html
rm -f ${GENERATED}/feed_entries.atom ${GENERATED}/feed.atom

# list .gmi files without date
find -L content -type f -name "*\.gmi" ! -name "*.????-??-??.gmi" | \
    sed -n -e "s/content\/\(.*\)\.gmi/\1|/p" | \
    awk -F \| '{
        printf $0"|";
        system("sed -n -e \"/^# /{s/^# //;p;q}\" content/"$1".gmi | tr -d \"\n\"");
        printf "\n";
    }' >> ${GENERATED}/index

# generate *.gmi and *.html files
IFS="|";
while read path date title; do
    log "Processing: ${path}"
    if [ ${#date} -gt 0 ]; then path_date=${path}.${date}; else path_date=${path}; fi
    dir=$(cd content/ && dirname ${path_date}.gmi)
    mkdir -p ${GENERATED}/gmi/${dir} ${GENERATED}/html/${dir}

    # target-agnostic subsitutions
    sed \
        -e "s/{{DATE}}/${date:-Unknown}/g" \
        -e "s/{{AUTHOR_EMAIL}}/${AUTHOR_EMAIL}/g" \
        -e "s/{{AUTHOR_NAME}}/${AUTHOR_NAME}/g" \
        -e "s/{{URL_BASE}}/${URL_BASE}/g" \
        -e "/{{POSTS}}/r ${GENERATED}/posts.gmi" \
        -e "/{{POSTS}}/d" \
        content/${path_date}.gmi > ${GENERATED}/tmp.gmi

    # selection-translation to targets, target-dependant substitutions
    awk -f select_gmi.awk -f gmi2gmi.awk ${GENERATED}/tmp.gmi | sed \
        -e "s/{{PROTOCOL}}/gemini/g;s/{{EXTENSION}}/gmi/g" \
        > ${GENERATED}/gmi/${path}.gmi
    awk -f select_html.awk -f gmi2html.awk ${GENERATED}/tmp.gmi \
        > ${GENERATED}/tmp.html
    sed \
        -e "s/{{TITLE}}/${title}/g" \
        -e "/{{HTML_CONTENT}}/r ${GENERATED}/tmp.html" \
        -e "/{{HTML_CONTENT}}/d" \
        template.html | sed \
        -e "s/{{PROTOCOL}}/https/g;s/{{EXTENSION}}/html/g" \
        > ${GENERATED}/html/${path}.html
done < ${GENERATED}/index
rm -f ${GENERATED}/tmp.gmi ${GENERATED}/tmp.html
rm -f ${GENERATED}/index ${GENERATED}/posts.gmi

# copy non .gmi files
find -L content -type f ! -name "*\.gmi" | \
    sed -e "s/^content\///" | \
    while read path; do
        log "Copying: ${path}"
        dir=$(cd content/ && dirname ${path}.gmi)
        mkdir -p ${GENERATED}/gmi/${dir} ${GENERATED}/html/${dir}
        cp content/${path} ${GENERATED}/gmi/${path}
        cp content/${path} ${GENERATED}/html/${path}
    done

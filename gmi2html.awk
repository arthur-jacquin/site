# Licensed under GPLv3 (https://www.gnu.org/licenses/gpl-3.0.en.html)
# Copyright 2025 Arthur Jacquin <arthur@jacquin.xyz>

function p(prefix, opening, closing) {
    sub("^" prefix, "");
    print opening sanitize($0) closing;
    next;
}

function l(prefix, opening, closing) {
    sub("^" prefix, "");
    url = $1; $1 = ""; sub(" *", "");
    if (match(url, ".jpg$") || match(url, ".png$")) {
        print "<p><img src=\"" url "\" alt=\"" sanitize(NF == 0 ? url : $0) "\"></p>";
        next;
    }
    print opening "<a href=\"" url "\">" sanitize(NF == 0 ? url : $0) "</a>" closing;
    next;
}

function sanitize(str) {
    gsub("\\&", "\\&amp;", str);
    gsub("<", "\\&lt;", str);
    gsub(">", "\\&gt;", str);
    gsub("\"", "\\&quot;", str);
    gsub("'", "\\&#39;", str);
    return str;
}


BEGIN       { pre = 0; }
/^```/      { pre = 1 - pre; print pre ? "<pre>" : "</pre>"; next; }
            { if (pre) { print sanitize($0); next; } }       # preformatted
/^$/        { p("",     "<br>",         ""              ); } # empty line
/^\# /      { p("# ",   "<h1>",         "</h1>"         ); } # level 1 heading
/^\#\# /    { p("## ",  "<h2>",         "</h2>"         ); } # level 2 heading
/^\#\#\# /  { p("### ", "<h3>",         "</h3>"         ); } # level 3 heading
/^\* /      { p("\\* ", "<ul><li>",     "</li></ul>"    ); } # list item
/^>/        { p("> ?",  "<blockquote>", "</blockquote>" ); } # blockquote
/^=>/       { l("=>",   "<p>",          "</p>"          ); } # link
            { p("",     "<p>",          "</p>"          ); } # basic text

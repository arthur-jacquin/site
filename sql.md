# Structured Query Language

#### Links

- [Reference](https://sqlite.org/lang.html)
- [Tutorial](https://www.w3schools.com/sql/sql_intro.asp)

#### Notations

```
SQL_STATEMENT
.sqlite_dot_statement
variable_name
[optionnal_element]
choiceA|choiceB|choiceC...
```

## Management

#### Entering the SQL shell

```bash
alias sql="sqlite3 -header -box"
sql [database_file]
```

#### Quitting the shell

```sqlite
.quit
```

#### Managing databases

```sqlite
.open database_name
.save database_name
.clone new_database_name
```

#### Formatting output

```sqlite
.headers on|off
.mode list|column|html
.separator separator
.width [first_column_width [, ...]]
```

#### Database information

```sqlite
.tables
.schema [table_name|regex_expression]
.dump [table_name|regex_expression]
```

## SQL Queries

#### Retrieve records

```sqlite
SELECT [DISTINCT] [MIN|AVG|MAX|COUNT|SUM(]oid|*|column_name[)] [AS temp_name] [, ...]
FROM table_name [AS temp_name]
[JOIN table_name [AS temp_name] ON condition]*
[WHERE condition]
[ORDER BY column_name [ASC|DESC] [, ...]]
[LIMIT number_of_row];
```

#### Managing tables

```sqlite
CREATE TABLE [IF NOT EXISTS] table_name
  (column_def [, ...]);
| AS (sql_statement);
```

```sqlite
ALTER TABLE [schema_name .] table_name
  RENAME TO new_table_name;
| RENAME [COLUMN] column_name TO new_column_name;
| ADD [COLUMN] column_def;
```

```sqlite
DROP TABLE [IF EXISTS] table_name;
```

```sqlite
VACUUM;
```

> Undocumented yet : virtual tables, views, triggers, database attachments, index management

#### Managing records

```sqlite
INSERT INTO table_name (column_name [, ...])
VALUES (value [, ...]);
```

```sqlite
UPDATE table_name
SET column_name = value [, ...]
[WHERE condition];
```

```sqlite
DELETE FROM table_name
[WHERE condition];
```

## Reference

#### Conditions

```sqlite
AND|OR|NOT
```

```sqlite
column_name ==|!=|<[=]|>[=] value
column_name [NOT] IN (sql_statement)|(value [, ...])
column_name [NOT] BETWEEN min_value AND max_value
column_name IS [NOT] NULL
```

#### Column definition

```sqlite
column_name [NULL|INTEGER|REAL|TEXT|BLOB] [PRIMARY KEY [AUTOINCREMENT]] [UNIQUE] [NOT NULL] [CHECK (condition)]
```

#### Scalar functions

```sqlite
abs(X)
char(X1,X2,...,XN)
coalesce(X,Y,...)
length(X)
lower|upper(X)
min|max(X,Y,...)
replace(X,Y,Z)
round(X[,Y])
sign(X)
substring(X,Y,Z)
[r|l]trim(X[,Y])
typeof(X)
```

#### Math functions

```sqlite
[a](cos|sin|tan)[h](X)
floor|ceil|trunc(X)
radians|degrees(X)
exp(X)
ln|log[10|2](X)
log(B,X)
mod(X,Y)
pi()
pow(X,Y)
sqrt(X)
```
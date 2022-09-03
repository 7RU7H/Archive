# SQLInjection

An ode to SQLI:
```poem
sqlin' da morning 
sqlin' your evening
admin or one plus one equals two
single quote for strings
enum db char-by-char for those correct
tingles as the database query dumps things
comments breaking stuff on internet
admin password from table * select
database asleep pleasing
SELECT star FROM passwords stealing
by 7ru7h
```
## Useful resources
[[Introduction-to-SQL]]
[[SQLmap-CheatSheet]]

https://github.com/payloadbox/sql-injection-payload-list
https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/SQL%20Injection

## Sleepy-Questions-LanguageIdea 'behind attack=attack -- - Methodology
Indication of vulnerablity: variations with use of  `'` which used a string delimiter. Databases require instructional commands to store, organise and interact with data. Firstly the requirement is to inject maliformed SQL queries to break the query syntax through a logical mechanism and the sql parser's interpretation of characters external usage in token classification. The `-` comment  character is recognised as a break from a functionality to interact with database. Or `'` to indicate the opening of string declaration. The paring functions to consider the following set of character as string continously until otherwise stated. In break the query access to debug messages or likewise indicated through commanding the server to delay its subsequent response demonstrating control of the server. If it will `sleep` because a malicious query states such for speficied time the query may be transformed to the fix its breakage of syntax to then query actual information on the database. Or use the system hosting the database to use the database as storage for further movement with commands to to remote code excution. 

## Use cases for SQLi 

1. Authentication Bypass
1. Enumerating a Database `SELECT <field>, <field> FROM <table> WHERE <field>=`
	1. Column Number Enumeration - With column names or the column indexes instruct database to sort by either, to figure out the width:
		`http://url/bad.ext?<field>=1 order by 1`
	1. Detirmine Output layout - Union statement to control display, for meanful Data extraction
		`union all select 1, 2, <nth, column, width, delimitered, with , comma>`
1. Data Extraction
1. SQLi to Code Execution


#### Characters, Command and Considerations toolset
Always consider the syntax!

Comments
```sql
'
-- -
/*
```
Close-previous parentheses
```sql
)
```

MariaDB specific for extensive information for see [[MariaDB-Hacking]]
```sql
;#	-- Ends querys
LIMIT 1	-- Limit number of records returned
```

MSSQL specific for extensive information for see [[MSSQL-Hacking]]
```mssql

```

MySQL specific for extensive information for see [[MySQL-Cheatsheet]]
```sql

```


## Consider SQL filtering

Blind SQLi
Cause SQL error -> Fix it -> add SQL queries
Use sleep(5) if reponse is instant SQL query, then there is no SQLi

Union SQLi:
Find number of columns -> Check suitable columns -> Attack

## Database type enumeration
```sql
MySQL and MSSQL
',INPUT=@@version,INPUT='
# Oracle
',INPUT=(SELECT banner FROM v$version),email='
# For SQLite
',INPUT=sqlite_version(),INPUT='
```

## Defense and Migitation
[Prepared Statements prevent 'illegal' queries](https://en.wikipedia.org/wiki/Prepared_statement)



## References
[Prepared Statements Wiki](https://en.wikipedia.org/wiki/Prepared_statement)
[TryHackMe SLQinjections Labs room](https://tryhackme.com/room/sqlilab)
[Computerphile Video](https://www.youtube.com/watch?v=ciNHn38EyRc)

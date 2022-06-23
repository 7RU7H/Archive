# SQLinjection

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
https://github.com/payloadbox/sql-injection-payload-list
https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/SQL%20Injection

## 
Database require instructional commands to store, organise and interact with data. To inject maliformed SQL queries to break the query syntax through logical mechanism and the sql parser's interpretation of characters external usage in token classification. The `-` comment  character is recognised as a break from a functionality to interact with database. Or `'` to indicate the opening of string declaration. The paring functions to consider the following set of character as string continously until otherwise stated. In break the query access to debug messages or likewise indicated through commanding the server to delay its subsequent response demonstrating control of the server. If it will `sleep` because a malicious query states such for speficied time the query may be transformed to the fix its breakage of syntax to then query actual information on the database. Or use the system hosting the database to 


use the database as storage for further movement with commands to to reomate code excution

## Methodology



#### Character and Command toolset
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



## References

[TryHackMe SLQinjections Labs room](https://tryhackme.com/room/sqlilab)
[Computerphile Video](https://www.youtube.com/watch?v=ciNHn38EyRc)

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


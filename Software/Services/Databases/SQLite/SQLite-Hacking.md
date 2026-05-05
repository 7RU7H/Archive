# SQLite Hacking

SQLite while on a box does not require credentials!
```bash
sqlite3 databasename.db
```

Useful 
```sql

.quit -- to quit
.help
-- enumeration
.tables
.database
.schema

.headers on -- Show column headers
select * from $tablenamedsomething;
```


https://www.sqlite.org/docs.html
https://vhernando.github.io/sqlite3-cheat-sheet
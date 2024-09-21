# Osquery

[Osquery](https://osquery.io/) is an [open-source](https://github.com/osquery/osquery) agent created by [Facebook](https://engineering.fb.com/2014/10/29/security/introducing-osquery/) in 2014 and is a SQL (a super-set of SQLite) powered operating system instrumentation, monitoring, and analytics framework, which is available for Linux, macOS, and Windows.

Beware versioning - always check the drop downs [Schema Documentation](https://osquery.io/schema/)
- Osquery Version
- Show only Tables compatible with: ...OS

```sql
-- CLI interactive mode
osqueryi
-- All meta command are prefixed with a ` . ` 
.help

.all [TABLE]    -- Select all from a table
.bail ON|OFF    -- Stop after hitting an error
.connect PATH   -- Connect to an osquery extension socket
.disconnect     -- Disconnect from a connected extension socket
.echo ON|OFF    -- Turn command echo on or off
.exit           -- Exit this program
.features       -- List osquery's features and their statuses
.headers ON|OFF -- Turn display of headers on or off
.help           -- Show this message
.mode MODE      -- Set output mode where MODE is one of:
--                   csv      Comma-separated values
--                   column   Left-aligned columns see .width
--                   line     One value per line
--                   list     Values delimited by .separator string
--                   pretty   Pretty printed SQL results (default)
.nullvalue STR  -- Use STRING in place of NULL values
.print STR...   -- Print literal STRING
.quit           -- Exit this program
.schema [TABLE] -- Show the CREATE statements
.separator STR  -- Change separator used by output mode
.socket         -- Show the local osquery extensions socket path
.show           -- Show the current values for various settings
.summary        -- Alias for the show meta command
.tables [TABLE] -- List names of tables
.types [SQL]    -- Show result of getQueryColumns for the given query
.width [NUM1]+  -- Set column widths for "column" mode
.timer ON|OFF   -- Turn the CPU timer measurement on or off
```

Workflow 
- `.schema | .tables` a table to get columns
- `sqlite query` 

#### Syntax

Functions
```sql
select count(*) from currentTable;
select name from currentTable where name like '%matchthis%'

```

Where
```sql
WHERE 
-- `=` [equal]
-- `<>`  [not equal]
-- `>`, `>=` [greater than, greater than, or equal to]
-- `<`, `<=` [less than or less than or equal to] 
-- `BETWEEN` [between a range]
-- `LIKE` [pattern wildcard searches]
-- `%` [wildcard, multiple characters]
-- `_` [wildcard, one character]
```

Wildcard rules
```sql
-- `%`: Match all files and folders for one level.
-- `%%`: Match all files and folders recursively.
-- `%abc`: Match all within-level ending in "abc".
-- `abc%`: Match all within-level starting with "abc".
```

Join
```sql
select a.column a.column a.column from aTableVardeclared a JOIN b.column b.column b.column from bTableVardeclared b LIMIT 10;
```

#### Useful Queries


```sql
-- Display network information about a process using its PID
SELECT pid, fd, socket, local_address, remote_address FROM process_open_sockets WHERE pid = 1337;
```



## References

[THM Linux Incident Surface](https://tryhackme.com/r/room/linuxincidentsurface)
[Osquery Schema Documentation](https://osquery.io/schema/)
[THM OSquery room](https://tryhackme.com/room/osqueryf8)
[Github OSquery](https://github.com/osquery/osquery)
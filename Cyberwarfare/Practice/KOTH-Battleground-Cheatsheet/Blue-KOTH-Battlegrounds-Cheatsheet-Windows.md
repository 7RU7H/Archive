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


## References

[ired.team](https://www.ired.team/offensive-security/persistence/t1053-schtask)
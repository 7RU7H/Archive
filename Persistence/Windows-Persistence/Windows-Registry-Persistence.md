# Windows-Registry-Persistence



Run keys are specific keys within the Registry that contain a path that runs every time a user logs on, and they are listed below:
```powershell
# Run path when the current user logs in
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run
# Run path when any user logs in
HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run 
# Run path when the current user logs in, then delete  
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce 
# Run path when any user logs in, then delete
HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce 
```


AutoRun Modules:
```powershell
Get-Command -Module AutoRuns
# Help?
Get-Help Get-PSAutorun -detailed
# Get all AutoRuns
Get-PSAutorun
# Filter in table view
Get-PSAutorun | Out-GridView

# Baseline will by default be in th Documents Directory
Get-PSAutorun -VerifyDigitalSignature | Where { -not($_.isOSbinary)} | New-AutoRunsBaseLine -Verbose
# Compare
Compare-AutoRunsBaseLine -Verbose | Out-GridView
```


## References

[THM Room Registry Persistence Detection](https://tryhackme.com/r/room/registrypersistencedetection)
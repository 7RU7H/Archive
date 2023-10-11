

Anything doing anything with/from `SysWow64` - [WWHF 2020: Hunting Sofware Vulnerabilities Without Reversing](https://www.youtube.com/watch?v=JPhrKJzNJyw)


## Registry Persistence Detection

[Malware Behaviour Catalogue](https://github.com/MBCProject/mbc-markdown/blob/main/persistence/README.md) defines Malware Persistence as *"Behaviours that enable malware to remain on a system regardless of system events, such as reboots."*

- Windows Registry Run keys - [[Windows-Registry]] - Use `regedit` or `reg query $PATH`
	- Run Keys contain a path that executes every logon event.
	- `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run` - Run path when the current user logs in
	- `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run` - Run path when **any** user logs in
	- `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce` - Run path when the current user logs in, then delete  
	- `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce` - Run path when _any_ user logs in, then delete

- [[Sysinternals]] - [AutoRuns](https://learn.microsoft.com/en-us/sysinternals/downloads/autoruns) checks all possible locations where a program can automatically run on start-up or when a user logs in. 
There is also the [AutoRuns PowerShell module](https://github.com/p0w3rsh3ll/AutoRuns):

```powershell
Get-Command -Module AutoRuns
# Get and Display Autoruns !! Pipe to a File or your mousewheel will die
Get-PSAutorun 
# Output to a grid
Get-PSAutorun | Out-GridView
# Parameters are mostly filter for specific AutoRuns 
-All # Artifacts from all categories.
-BootExecute # Artifacts from the Boot Execute category.
-AppinitDLLs # Artifacts from the Appinit category.
-ExplorerAddons # Artifacts from the Explorer category.
-ImageHijacks # Artifacts from the Image Hijacks category.
-InternetExplorerAddons # Artifacts from the Intenet Explorer category.
-KnownDLLs # Artifacts from the KnownDLLs category.
-Logon # Artifacts from the Logon category.
-Winsock # Artifacts from the Winsock and network providers category.
-Codecs # Artifacts from the Codecs category.
-OfficeAddins # Artifacts from Office Addins
-PrintMonitorDLLs # Artifacts from the Print Monitors category.
-LSAsecurityProviders # Artifacts from the LSA Providers category.
-ServicesAndDrivers # Artifacts from the Services and Drivers categories.
-ScheduledTasks # Artifacts from the Scheduled tasks category.
-Winlogon # Artifacts from the Winlogon category.
-WMI # Artifacts from the WMI category.
-PSProfiles # Artifacts from the PowerShell profiles category.
-Raw 
-ShowFileHash # Enable and display MD5, SHA1 and SHA2 file hashes.
-VerifyDigitalSignature #Report if a file is digitally signed with the built-in Get-AuthenticodeSignature cmdlet.
# Find all unsigned AutoRuns
Get-PSAutorun -VerifyDigitalSignature | Where-object {$_.Signed -eq $false}
# Find all non System32 protected AutoRuns Logon
get-psautorun -logon | Where-object {$_.ImagePath -notlike '*System32*' }


# Create a baseline file from Autorun artifacts
New-AutoRunsBaseLine
# THM example of newbaseline for non-Windows Binaries
# Wait takes time!
Get-PSAutorun -VerifyDigitalSignature | Where { -not($_.isOSbinary)} |  New-AutoRunsBaseLine -Verbose

# Compare between two baseline files
Compare-AutoRunsBaseLine
Compare-AutoRunsBaseLine -Verbose | Out-GridView
```



## References

[WWHF 2020: Hunting Sofware Vulnerabilities Without Reversing](https://www.youtube.com/watch?v=JPhrKJzNJyw)
[THM Registry Persistence Detection Room](https://tryhackme.com/room/registrypersistencedetection)
[AutoRuns](https://learn.microsoft.com/en-us/sysinternals/downloads/autoruns) 
[Malware Behaviour Catalogue](https://github.com/MBCProject/mbc-markdown/blob/main/persistence/README.md) 
[AutoRuns PowerShell module](https://github.com/p0w3rsh3ll/AutoRuns)

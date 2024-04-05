# Windows Applications Forensics

## Introduction


For this page I will try to only have the PowerShell and other method mentioned to their respective linked pages. 
#### Logging

[[ETW]] is the underlying system of logging in Windows 

[[Windows-Logging]] 

[[Windows-Events-To-Monitor]]

[[Event-Viewer]] - `eventvwr.msc` is the  very clunky Windows GUI utility to view logs, try using [[Sysinterals-Sysmon]] with its [[Sysmon-Events]] for some [[Sysmon-Basic-Hunting]]. There is also:
- CLI utility `wevutil.exe`
- PowerShell's `Get-WinEvent / Get-EventLog`. [[PowerShell-Event-Logging.md]]


#### Scheduled Tasks and Services

- Event ID `4698` - A scheduled task was created.
- Event ID `4702` - A scheduled task was updated.

List Service creation events:
```powershell
Get-WinEvent -FilterHashTable @{LogName='System';ID='7045'} | fl
Get-WinEvent -FilterHashTable @{LogName='Security';ID='4697'} | fl

# Disabled?
schtasks.exe /query /fo CSV | findstr /V Disabled
Get-ScheduledTask | Where-Object {$_.State —ne "Disabled"}

# List of all scheduled tasks, sorted by their creation date
Get-ScheduledTask | Where-Object {$_.Date —ne $null —and $_.State —ne "Disabled"} | Sort-Object Date | select Date,TaskName,Author,State,TaskPath | ft


# AhmedZia's Timelining Events in PowerShell
$startdate = (Get-Date -Year 2024 -Month 1 -Day 28).Date
$enddate = (Get-Date -Year 2024 -Month 1 -Day 28).Date
Get-WinEvent -FilterHashtable @{LogName='System'; ID=7045; StartTime=$startDate; EndTime=$endDate} | Select-Object TimeCreated, ID, ProviderName, LevelDisplayName, Message | Format-Table -AutoSize

# AhmedZia's find suspicious command execution
Get-WinEvent -FilterHashtable @{ LogName='Microsoft-Windows-PowerShell/Operational'; Id='4104';} | Where-object -Property Message -Match "[A-Za-z0-9+/=]{150}" | Format-List -Property Message


(Get-ScheduledTask -TaskName $REPLACE_WITH_ACTUAL_TASKNAME).Actions
(Get-ScheduledTask -TaskName $REPLACE_WITH_ACTUAL_TASKNAME).Triggers
(Get-ScheduledTask -TaskName $REPLACE_WITH_ACTUAL_TASKNAME).Principal

```

Credential Dumping Attack Hunting
```
Get-WinEvent -FilterHashtable @{Path='C:\path\to\Logfile.evtx'; ID=10} | Where-Object {$_.Properties[8].Value -like "lsass.exe"} | Select-Object -Property *
```

Hunting for Unsigned DLLs by Analyzing Event Logs
```powershell
# AhmedZia's Hunting for Unsigned DLLs by Analyzing Event Logs:
Get-WinEvent -FilterHashtable @{Path='C:\path\to\logfile.evtx'; ID=7} | Where-Object {$_.Properties[12].Value -eq "false"} | Select-Object -Property *
```
## References

[THM Windows Applications Room](https://tryhackme.com/r/room/windowsapplications)
[medium.com/@AhmedZia01/analyzing-windows-event-logs-with-powershell-get-winevent](https://medium.com/@AhmedZia01/analyzing-windows-event-logs-with-powershell-get-winevent-b08163e78221)
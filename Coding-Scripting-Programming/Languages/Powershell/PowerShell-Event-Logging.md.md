# Event Logging with PowerShell

```powershell
# General
# Get service infomation either:
Get-CimInstance win32_service -Filter "Description = 'System Monitor service'" # OR
Get-Service | where-object {$_.DisplayName -like "*sysm*"}
# Registry Query with a path to hivekey-..\child\items\
reg query HK..\\
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Sysmon/Operational # sysmon key
# Find what the admins are monitoring:
findstr /si '<ProcessCreate onmatch="exclude">' C:\tools\*

## WinEvents
# These are themed by find if and what admins are using sysmon to monitor
Get-WinEvent                                           # get the events!
Get-WinEvent -LogName Application | Where-Object { $_.ProviderName -Match 'WLMS' } # Filter event logs..generally
Get-WinEvent -Path .\file.evtx -FilterXPath '*/System/EventID=1' | Sort-Object TimeCreated | Where-Object {$_.Message -like "*kw*"} | fl # Find EventID 
Get-WinEvent -Path .\sysmonlog.evtx -FilterXPath '*/System/*' | Where-Object { $_.TimeCreated -ge $start -and $_.TimeCreated -le $end } | Sort-Object TimeCreated# Find Event between $start -and $end
Get-WinEvent -LogName Application -FilterXPath '*/XML pathing/EVENTID=...'   # Eventid
Get-WinEvent -LogName Application -FilterXPath '*/XML pathing/Provider=[@Name=""]'       # Provider name query
# This instruction can also be done in wevtutil as well:
wevtutil.exe qe Application /q:*/System[EventId= ] /f:text /c:1
Get-WinEvent -LogName Application -FilterXPath '*/System/EventID=101 and */System/Provider[@Name="WLMS"]'
Get-WinEvent -LogName Application -FilterXPath '*/System/Provider[@Name="WLMS"]'
# Detect powershell downgrade
Get-WinEvent -LogName "Windows PowerShell" |
    Where-Object Id -eq 400 |
    Foreach-Object {
        $version = [Version] (
            $_.Message -replace '(?s).*EngineVersion=([\d\.]+)*.*','$1')
        if($version -lt ([Version] "5.0")) { $_ }
}

# NOTE FOR efficiency: use FilterHashTable over Where-Object 
Get-WinEvent -FilterHashtable @{
        LogName=''
        ProviderName=''
        ID=someint
}
#
## EventLogs
#
Get-EventLog                                           #  gets replace by the get-winevent
Get-EventLog -list 

# 
## Processes 
#
Get-Process | Where-Object { $_.ProcessName -eq "Sysmon" } # Get information of a process by name
Get-Process -ID $PID -IncludeUserName # Owner of proccess
Get-Process -ID $PID | Format-Table * # All data on a PID
```
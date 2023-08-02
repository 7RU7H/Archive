# Endpoint Security


## Introduction

Endpoints are the leaves to the branches of a network, a workstation, database or another production machine from where monitoring and logging of various activity can occur, be collected and processed in a more centralised location within a network.

For Windows, Sysinternals is the suite of tools gain a deep insight on what is going on - the [[Sysinternals-Hub]] page will contain various tools of that suite used be *any* cyber security professional to perform investigation and analysis. Although every organisation is different there are less modular suites like: [[Osquery]] that centralise the data collection phase.  

## Endpoint Logging and Monitoring

Windows [[ETW]] creates raw data can be translated into XML using the Windows API to store data in log files with .evt or .evtx extension. These can be viewed with:
- [[Event-Viewer]] 
- [[Sysinterals-Sysmon]] 
- [[Osquery]]
- [[Wazuh]]
Or with CLI, consider [[WMI-Commands]] for - [Windows Management Instrumentation](https://learn.microsoft.com/en-us/windows/win32/wmisdk/wmi-start-page)
```powershell
Wevtutil.exe # Dos application
Get-WinEvent
```

Typically logs.etv(x) are stored:
- `C:\Windows\System32\winevt\Logs`

Articles locally:
- [[Windows-Logging]]
- [[Windows-Events-To-Monitor]]
- [[PowerShell-Event-Logging.md]]
- Beware more sophisticated attackers will try [[Logging-And-Monitoring-Evasion]] techniques.


## Endpoint Log Analysis

Event correlation - correlate clues to build analysis on connection of patterns and not one data point - multiple clues:
- Source and Destination IP
- Source and Destination Port
- Action Taken
- Protocol
- Process name
- User Account
- Machine Name

Base Lining is process of knowing what is expected to be normal. 


- Is it spelled correctly?
- Is it being ran from the excepted path?
- Is it communicating to weird IPs?
- Check the digital signature?
- Is it being ran from the expected SID?
- Is the expected parent process that actual parent processes?
- Are the child processes the expected child processes?
- Was it tried to interact with (like write to an)other process?

## References

[THM Intro to Endpoint Security Room](https://tryhackme.com/room/introtoendpointsecurity)
[Windows Management Instrumentation](https://learn.microsoft.com/en-us/windows/win32/wmisdk/wmi-start-page)
[Hacktricks Window Processes](https://book.hacktricks.xyz/generic-methodologies-and-resources/basic-forensic-methodology/windows-forensics/windows-processes)
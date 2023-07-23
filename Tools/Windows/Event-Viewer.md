# Event Viewer

Event Viewer uses [[Event-Tracing-for-Windows]]

Alternatives to Event Viewer being either Wevtutil.exe or [[PowerShell-Event-Logging.md]]



Application - log events associated with system components 
Security - can be modified to improved Audited
Setup
System - Windows Logs system-related events
Forwarded Events 

Microsoft/Windows/

Logs file with the extension `.evtx` typically located in `C:\Windows\System32\winevt\Logs` directory. 

Can view `.etl` event trace log files from [[Event-Tracing-for-Windows]]

[Event Types](https://learn.microsoft.com/en-us/windows/win32/eventlog/event-types)
![](eventviewereventtypes.png)

Event IDs  

## Workflows

Generally the amount of information is enormous so the workflow is centered around specify a set of Logs that will provide logged information about a set of behaviours that you looking for. 
`Create -> Custom View ->`
- Considerations:
	- Know what you are looking for
		- Event IDs that correspond with behaviour
		- Logs 
	- Do you have enough compute?
		- Event Viewer is not hungry the amount of data    
	- Not too broad a scope of logs

Remote Event logging 
`Event Viewer (Local) > Connect to Another Computer...`

## References

[THM Windows Event Logs Room](https://tryhackme.com/room/windowseventlogs)
[Learn Microsoft Event-View Inside show](https://learn.microsoft.com/en-us/shows/inside/event-viewer)
[Event Types](https://learn.microsoft.com/en-us/windows/win32/eventlog/event-types)
[THM Room Aurora](https://tryhackme.com/room/auroraedr)
# Windows Logging


[[Windows-Events-To-Monitor]] and or with [[PowerShell-Event-Logging.md]] and [[Windows-Hardening]] for more comprehensive Security Posture to include logging.

Logs found:
- `%SystemRoot%\System32\Logfiles`
- Log Levels:
	- Debug, Information, Warning, Error, Critical 
- [[Event-Viewer]] is native, but there are better ways
	- Using [[Sysmon-Events]] and [[Sysinterals-Sysmon]] and many others
- Uses [[ETW]] 


Windows Types:
- **System Logs**: This records activity associated with the system components, such as driver failure, resource conflict, and hardware issues. For IT professionals, they serve as sources of critical diagnostics information.
- **Application Logs**: This type concerns individual software living upon the system. When issues manifest around a specific application, such as failing to connect to a database or process-related bottlenecks, these logs come in handy to determine why the failure occurred.
- **Security Logs**: Specialised logs designed to track security events. They touch on events such as logon and logoff actions, user rights assignments, policy changes, and security-related aberrations. For security professionals, this often represents their first check when investigating a security incident.
- **Forwarded Events Logs**: These logs receive collected from other tertiary-tertiary computing environments. They act as collated reports, pulling from multiple sources into a centralised file. They are ideal for monitoring tasks and analysis in a networked environment, where you may need to assemble data from various places into a cohesive analysis.

Audit Types:
- Account logon events
- Account management
- Privilege use
- Directory service access
- Policy change
- System events

## References

[THM Auditing and Monitoring Room](https://tryhackme.com/room/auditingandmonitoringse)
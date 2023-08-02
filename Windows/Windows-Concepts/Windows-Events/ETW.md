# Event Tracing for Windows

[Event tracing](https://learn.microsoft.com/en-us/windows/win32/etw/about-event-tracing) is *"Event Tracing for Windows (ETW) is an efficient kernel-level tracing facility that lets you log kernel or application-defined events to a log file. You can consume the events in real time or from a log file and use them to debug an application or to determine where performance issues are occurring in the application."* 

Event Tracing for Windows (ETW) is not exclusively Event Logging or Event Tracing as these are extensions of ETW. The components of ETW and the purpose for each is tabled below:

|**Component**|**Purpose**|
|---|---|
|Controllers|Build and configure sessions|
|Providers|Generate events|
|Consumers|Interpret events|

Event ID are a core feature of [[Windows-Logging]] as events are defined, implemented and formatted in [[XML]]. See [[Windows-Events-To-Monitor]] for examples of what should be monitored and how.

![](msetwdiagram.png)

Components on Windows that are part of ETW 
- Controllers - application used to configure event tracing sessions
- Providers - applications that produce event logs
- Consumers - applications subscribe and listen to events in real-time or from a file - like [[Event-Viewer]]

The event information is categorised under these types of levels:
- **Information:** Describes the successful operation of a driver, application or service. 
- **Warning:** Describes an event that may not be a present issue but can cause problems in the future.
- **Error:** Describes a significant problem with a service or application.
- **Success Audit:** Outlines that an audited security access operation was successful.
- **Failure Audit:** Outlines that an audited security access operation failed. 

## Tracing Implementation

#### Controllers

[Microsoft documentation](https://docs.microsoft.com/en-us/windows/win32/etw/about-event-tracing#controllers), *“Controllers are applications that define the size and location of the log file, start and stop event tracing sessions, enable providers so they can log events to the session, manage the size of the buffer pool, and obtain execution statistics for sessions.”*

#### Providers

[MOF (classic) providers](https://learn.microsoft.com/en-us/windows/win32/etw/about-event-tracing#mof-classic-providers):
- Use the [RegisterTraceGuids](https://learn.microsoft.com/en-us/windows/win32/api/evntrace/nf-evntrace-registertraceguidsa) and [TraceEvent](https://learn.microsoft.com/en-us/windows/win32/api/evntrace/nf-evntrace-traceevent) functions to register and write events.
- Use MOF classes to define events so that consumers know how to consume them.
- Can be enabled by only one trace session at a time.

[WPP providers](https://learn.microsoft.com/en-us/windows/win32/etw/about-event-tracing#wpp-providers) :
- Use the [RegisterTraceGuids](https://learn.microsoft.com/en-us/windows/win32/api/evntrace/nf-evntrace-registertraceguidsa) and [TraceEvent](https://learn.microsoft.com/en-us/windows/win32/api/evntrace/nf-evntrace-traceevent) functions to register and write events.
- Have associated TMF files (compiled into a binary's .pdb) containing decoding information inferred from the preprocessor's scan of WPP instrumentation in source code.
- Can be enabled by only one trace session at a time.

[Manifest-based providers](https://learn.microsoft.com/en-us/windows/win32/etw/about-event-tracing#manifest-based-providers): 
- Use [EventRegister](https://learn.microsoft.com/en-us/windows/desktop/api/Evntprov/nf-evntprov-eventregister) and [EventWrite](https://learn.microsoft.com/en-us/windows/desktop/api/Evntprov/nf-evntprov-eventwrite) to register and write events.
- Use a manifest to define events so that consumers know how to consume them.
- Can be enabled by up to eight trace sessions simultaneously.

[TraceLogging](https://learn.microsoft.com/en-us/windows/desktop/tracelogging/trace-logging-about) [providers](https://learn.microsoft.com/en-us/windows/win32/etw/about-event-tracing#tracelogging-providers):
- Use [TraceLoggingRegister](https://learn.microsoft.com/en-us/windows/desktop/api/traceloggingprovider/nf-traceloggingprovider-traceloggingregister) and [TraceLoggingWrite](https://learn.microsoft.com/en-us/windows/desktop/api/traceloggingprovider/nf-traceloggingprovider-traceloggingwrite) to register and write events.
- Use self-describing events so that the events themselves contain all required information for consuming them.
- Can be enabled by up to eight trace sessions simultaneously.

#### Consumers

Consumers [Consume Events](https://learn.microsoft.com/en-us/windows/win32/etw/consuming-events) ... [Microsoft documentation](https://docs.microsoft.com/en-us/windows/win32/etw/about-event-tracing#controllers), *"Consumers are applications that select one or more event tracing sessions as a source of events. A consumer can request events from multiple event tracing sessions simultaneously; the system delivers the events in chronological order. Consumers can receive events stored in log files, or from sessions that deliver events in real time. When processing events, a consumer can specify start and end times, and only events that occur in the specified time frame will be delivered."*

#### Deep Dive

[Event tracing for Windows](https://learn.microsoft.com/en-us/previous-versions/windows/desktop/xperf/event-tracing-for-windows) released with Windows 2000:
- Sessions stored to disk 
- ETL file extension - similiar to EVT/EVTX files
- Found - Common listed below: 
	- `C:\Windows\System32\WDI\LogFiles` - only the last Shutdown and log(on/off)
		- `BootCKCL.etl` - [[Windows-Persistence]] may be indicated here! 
			- `C:\Windows\System32\WDI\LogFiles\BootCKCL.etl`
			- Overwritten each system boot
			- Kernel Events captured during the boot process
				- Processes 
					- Command run
					- Malicious tools
					- Scheduled tasks at boot or logon
				- Threads
				- DiskIO
					- File handling across drives
				- FileIO
				- Image Loading (DLLs, EXEs)
		- `ShutdownCKCL.etl`
			-  `C:\Windows\System32\WDI\LogFiles\ShutdownCKCL.etl`
				- Overwritten each system shitdown
				- Kernel Events captured during the shutdown process
					- Running processes
						- Command run
						- Malicious tools
						- DLLs loaded by a process
					- Running threads
					- Images loaded (DLL, EXEs)
		- `SecondaryLogOn.etl`
		- `WdiContext.etl<###>`
			- Information related to user logon
				- Explorer Startup Executing from Run key
					- `Explorer_ExecutingFromRunKey/Start`
						- Shellbags - folders visited not need to Shellbag explorer
				- Executing from Startup key
	- `C:\Windows\System32\WDI\<GUID>\<GUID>`
		- `snapshot.etl`
	- `C:\Windows\System32\LogFiles\WMI`
		- `Wifi.etl`
			- Not fully parsable (2018)
				- WPP events Requiring PDBs and DLLs
			- WiFi network related events
				- WiFi Configuration
					- Network Service Set IDentifiers (SSIDs)
					- MAC addresses
				- AutoConfig information
		- `LwNetLog.etl` 
	- `C:\Windows\System32\SleepStudy`
		- `UserNotPresentSession.etl`
		- `abnormal-shutdown-<data>.elt`
		- `user-not-present-trace-<data>.elt
		- `ScreenOnPowerStudyTraceSession-<data>.elt*`
	- `C:\ProgramData\Microsoft\Windows\Power Efficiency Diagnostics\`
		- `energy-ntkl.etl`
			- Power diagnostics
				- System configuration
				- Logical drives
				- Physical drives - internal and external
				- NIC
				- Process and Thread
				- Services
- Not all ETL are present on all systems
- Create when..:
	- Windows performance, debugging, troubleshooting
	- Developer debugging
		- Tracing can be enabled at any point for any reason during application runtime
		- Stacks and calls
	- Administrative tasks
		- Manually execute event traces for the system and stored to disk for review
			- Network traffic
- Contains
	- ALOT - [Nicole Ibrahim suggests Microsoft Telemetry data, which is encrypted](https://www.youtube.com/watch?v=TUR-L9AtzQE)
		- Header Data
			- Session information
		- Event Data
			- Timestamps
			- Provider and event names
			- Processs and thread ID
			- Level and Task
			- Payload
- ETW Technologies
	- Managed Object Format (MOF)
		- Kernel events 
		- CIM repository
	- Trace Message Format (TMF)
		- Uses PDBs and PE files
	-  Manifest based
		- Uses files formatted as XML 
		- Requires 
			- registration on system
			- resourceFileName and messageFileName from the manifest to prpoperly decode data (Full absolute path)
	- Tracelogging (TL) - introduced in Windows 10
		- Necessary decoding information is embedded into ETL
- Tools - there are limitation decoding/parsing ETLs from other system
	- [[Event-Viewer]] - basic event data
	- Microsoft Message Analyzer
	- Winddow SDK tools
	- ETL Viewer C\# tool written by G-C Partners
	- TraceLogging ETLs not understood pre-Windows 10

Further reading...

[DNS Logging](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn800669(v=ws.11))
[Secrets from the Deep – The DNS Analytical Log](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/secrets-from-the-deep-the-dns-analytical-log-part-1/ba-p/1875094) uses a CustomDNSAnalyticsTrace.etl
[ired.team](https://www.ired.team/miscellaneous-reversing-forensics/windows-kernel-internals/etw-event-tracing-for-windows-101) suggests [ETWExplorer](https://github.com/zodiacon/EtwExplorer)
## References

[THM Evading Logging and Monitor ](https://tryhackme.com/room/monitoringevasion)
[Microsoft documentation ETW](https://docs.microsoft.com/en-us/windows/win32/etw/about-event-tracing#controllers)
[MOF (classic) providers](https://learn.microsoft.com/en-us/windows/win32/etw/about-event-tracing#mof-classic-providers)
[RegisterTraceGuids](https://learn.microsoft.com/en-us/windows/win32/api/evntrace/nf-evntrace-registertraceguidsa)
[TraceEvent](https://learn.microsoft.com/en-us/windows/win32/api/evntrace/nf-evntrace-traceevent) 
[WPP providers](https://learn.microsoft.com/en-us/windows/win32/etw/about-event-tracing#wpp-providers)
[RegisterTraceGuids](https://learn.microsoft.com/en-us/windows/win32/api/evntrace/nf-evntrace-registertraceguidsa)
[TraceEvent](https://learn.microsoft.com/en-us/windows/win32/api/evntrace/nf-evntrace-traceevent) 
[Manifest-based providers](https://learn.microsoft.com/en-us/windows/win32/etw/about-event-tracing#manifest-based-providers)
[EventRegister](https://learn.microsoft.com/en-us/windows/desktop/api/Evntprov/nf-evntprov-eventregister) 
[EventWrite](https://learn.microsoft.com/en-us/windows/desktop/api/Evntprov/nf-evntprov-eventwrite) 
[TraceLogging](https://learn.microsoft.com/en-us/windows/desktop/tracelogging/trace-logging-about)
[Trace Logging providers](https://learn.microsoft.com/en-us/windows/win32/etw/about-event-tracing#tracelogging-providers)
[TraceLoggingRegister](https://learn.microsoft.com/en-us/windows/desktop/api/traceloggingprovider/nf-traceloggingprovider-traceloggingregister)
[TraceLoggingWrite](https://learn.microsoft.com/en-us/windows/desktop/api/traceloggingprovider/nf-traceloggingprovider-traceloggingwrite) 
[Consuming Events](https://learn.microsoft.com/en-us/windows/win32/etw/consuming-events)
[Event tracing](https://learn.microsoft.com/en-us/windows/win32/etw/about-event-tracing)
[Event tracing for Windows](https://learn.microsoft.com/en-us/previous-versions/windows/desktop/xperf/event-tracing-for-windows)
[Nicole Ibrahim SANS DFIR talk: Windows Forensics: Event Trace Logs - SANS DFIR Summit 2018 ](https://www.youtube.com/watch?v=TUR-L9AtzQE)
[ired.team](https://www.ired.team/miscellaneous-reversing-forensics/windows-kernel-internals/etw-event-tracing-for-windows-101) 
[THM Room Aurora EDR](https://tryhackme.com/room/auroraedr)
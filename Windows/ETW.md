# Event Tracing for Windows

## Introduction

Event Tracing for Windows (ETW) is not exclusively Event Logging or Event Tracing as these are extensions of ETW. The components of ETW and the purpose for each is tabled below:

|**Component**|**Purpose**|
|---|---|
|Controllers|Build and configure sessions|
|Providers|Generate events|
|Consumers|Interpret events|

Event ID are a core feature of [[Windows-Event-Logs]] as events are defined, implemented and formatted in [[XML]]. See [[Windows-Events-To-Monitor]] for examples of what should be monitored and how.

![](msetwdiagram.png)

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
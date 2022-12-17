# Procmon

[Procmon](https://learn.microsoft.com/en-us/sysinternals/downloads/procmon): *"is an advanced monitoring tool for Windows that shows real-time file system, Registry and process/thread activity. It combines the features of two legacy Sysinternals utilities, Filemon and Regmon, and adds an extensive list of enhancements including rich and non-destructive filtering, comprehensive event properties such as session IDs and user names, reliable process information, full thread stacks with integrated symbol support for each operation, simultaneous logging to a file, and much more. Its uniquely powerful features will make Process Monitor a core utility in your system troubleshooting and malware hunting toolkit."*

```powershell
.\procmon.exe /Minimized
.\procmon.exe /AcceptEula
.\procmon.exe /Run32
```

[From adamtheautomator](https://adamtheautomator.com/procmon/) - consider this article provides gifs and images to explain, here I generally only want the raw workflow that is important.  

Enabling and Disabling Captures `[magnifying glass icon]` if red x is displayed over the top of it is is disabled

To export procmon filters:

1.  Go to the **Organize Filters** box.
2.  Click on the filter you’ve already saved and would like to export.
3.  Click on the **Export** button.
4.  Provide a name, choose a path and click **OK**. You’ll see that all procmon filters are saved with a PMF extension.

To import procmon filters:

1.  Go to the **Organize Filters** box.
2.  Click on the **Import** button.
3.  Find the filter you’d like to import and click **OK**.

Highlighting 
- `Right Click [Event you want to highlight]`
- `Options -> Highlight`
- `Filter -> Highlight`

## Event Filtering

Check out some [[Windows-Events-To-Monitor]] to monitor

Apply a filter
`Filter -> Filter...` or `[CTRL] + L` 

List of Possible Filters:
```powershell
Architecture
AuthenicationID
Category
Command Line
Company
Completion Time
Date & Time
Description
Detail
Duration
Event Class
Image PAth
Integrity 
Operation 
Parent PID
PAth
PID
Process Nmae
Relative Time
Result
Sequence
Session 
TID
Time of DAu
User
Version
Virtualized
```

Conditions
```powershell
is
is not
less than
more than
begins with
ends with
contains
excludes
```

with either `Include` or `Exclude` options to the provided value field to filter for.


## References 

[Procmon Microsoft Doumenetation](https://learn.microsoft.com/en-us/sysinternals/downloads/procmon#overview-of-process-monitor-capabilities)
[UTilmate Guide to Procmon](https://adamtheautomator.com/procmon/)
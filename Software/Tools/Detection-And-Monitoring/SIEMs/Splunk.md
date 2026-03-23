# Splunk


Splunk is one of the leading [[SIEM-Solutions]] that provides the ability to collect, analyze and correlate the network and machine logs in real-time. Splunk is compromised of three main components, list here in linear workflow order:
- Forwarder
	- Agent installed on endpoint intended to be monitored, collects data and sends to Splunk instance - lightweight processes, requires minimal resources; data sources
		- Logs
		- Database communications
		- Web traffic
- Indexer - Processes data from Forwarders
	- Normalise data into field-value pairs, datatype determination and stores data as events
- Search Head
	- Search & Reporting Application for users to search indexed logs - uses Splunk Search Processing Language
	- Generate graph visualisations  

As a set of statements about Splunk workflow:
- (Objective|Question)-based searching 
- Efficient searches for you and Splunk..
- With SPL an Operator is trying to narrow the information to most relevant and presentable  

## GUI Navigation 

- Splunk Bar, top panel for:
	- Messages
	- Settings
	- Activity - job progress
	- Help
	- Find - Search Features

- Apps Panel - App usage and Configuration
	- Notably the `Search & Reporting` is accessed here

- Explore Splunk - quick links 
	- Add Data
	- Splunk Apps
	- Splunk Docs

- Splunk Dashboard - Dashboard are GUI scoping of Concepts monitored in Splunk -by default no dash is displayed

## Adding Data

By Upload:
1.  **Select Source** -> Pick a file
2.  **Select Source Type** -> Displays how the Splunk platform sees your data before indexing, allowing for user to select type for remove extraneous data 
3.  **Input Settings** -> 
	1. Select the index where these logs will be dumped 
	2. `host` value to be associated with the logs, should be name of the machine events originate.  
	- *"a "sandbox" index as a destination if you have problems determining a source type for your data. A sandbox index lets you troubleshoot your configuration without impacting production indexes. You can always change this setting later."* 
5.  **Review** -> Review configuration 

## Log Sources

wineventlog - Windows Event logs
winRegistry - the logs related to registry creation / modification / deletion etc.
XmlWinEventLog - the sysmon event logs.
fortigate_utm - Fortinet Firewall logs
iis -  IIS web server logs
Nessus:scan - Nessus vulnerability scanner results.
Suricata -  alerts from the Suricata IDS.
stream:http -  the network flow related to http traffic.
stream: DNS -  the network flow related to DNS traffic.
stream:icmp -  the network flow related to icmp traffic


## Useful SPL

The SPL (Splunk Search Processing Language

[Botsv2 Dataset](https://github.com/splunk/botsv2)

[Metadata Article](https://www.splunk.com/en_us/blog/tips-and-tricks/metadata-metalore.html?301=/blog/2017/07/31/metadata-metalore.html)

[Metadata](https://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Metadata) Command can be used to search for the same kind of information that is found in the Data Summary
```c
// Change index!
| metadata type=sourcetypes index=botsv2 | eval firstTime=strftime(firstTime,"%Y-%m-%d %H:%M:%S") | eval lastTime=strftime(lastTime,"%Y-%m-%d %H:%M:%S") | eval recentTime=strftime(recentTime,"%Y-%m-%d %H:%M:%S") | sort - totalCount
```

- **REMEMBER:
	- **TO SET THE TIME RANGE CORRECTLY**
	- There is a lot going on - simplify to:
		- Need some data?
			- Which log file will it be in - think big like protocol, service, location 
			- What fields of data are created by Locard's Principle of Exchange that we can query to find that data!
			- What attacks generate what output into logs

Return events containing Keyword
`index="botsv2 $keyword"`

PAN traffic source type - Find an IP address of `$keyword`
`index="botsv2" $keyword sourcetype="pan:traffic"` - check `src_ip` and `client_ip`

HTTP stream source type from IP address - pull the HTTP logs
`index="botsv2" 10.10.10.10 sourcetype="stream:HTTP"` + look at `site` or
Remove duplicates and display as a table
`index="botsv2" 10.10.10.10 sourcetype="stream:HTTP" | dedup site | table site`
- use `index="botsv2" 10.10.10.10 sourcetype="stream:HTTP" NOT (site=*.undesiredable.falspositives OR ...)` to remove false positives 

SMTP stream to search whom is emailing whom - domain to narrow down by domain
`index="botsv2" sourcetype="stream:smtp" target@email.com domain.tld`
- When looking at email select either raw text or select by `[+]`  -  prefer click by field 
- File attachments `attach_filename{}`

Count each source IP against a domain
`index=botsv1 imreallynotbatman.com sourcetype=stream* | stats count(src_ip) as Requests by src_ip | sort - Requests`

Find [[XSS-Cheatsheet]] - XSS always generates errors! 
- `error`

Find [[Cross-Site-Request-Forgery]] - get the token!

SSL/TLS traffic for SSL certificates
`index="botsv2" sourcetype="stream:tcp"` and various `ssl_*` fields
- `ssl_issuer`

Find Encrypted files because of Ransomware with: [[Ransomware-Encrypted-File-Extensions-List]]

`sourcetype=`[[Osquery]] if *was implemented* on system is very useful data source.
- `columns.path` for file path
- `columns.target_path` for target paths - destination of output onto the filesystem
- `columns.pid` for process ids
- `columns,.key` for environment variables
- For Usernames use [[Osquery]] formatting

Scheduled tasks
`index="botsv2" schtasks.exe` + `sourcetype` + `| dedup ParentCommandLine | table ParentCommandLine CommandLine` to reduce to the command line arguments run 

Windows Registry
`index="botsv2" source=WinRegistry` + path `\\$parent\\$child\\$etc`

Find [[Bad-USBs]]
`Vendor Id` + `Model ID` and enter into [Device Hunt](https://devicehunt.com/) 

Convert weird strings with [[CyberChef]]

Events before/after or same time of this a particular event
On the `Time` column of `Time | Event` in List formatting:
- `Click $time -> select either ("Before this time" || "After this time" || "At this time")`
- Then `Nearby Event -> select +/- Int (milliseconds, seconds, minutes, hours, days, weeks)` then `Apply`

Reverse the order of events displayed
`| reverse`

Create a table by piping then listing fields for the table whitespace separated
`| table _time src dest_ip form_data`

Form data containing provided data accepts [wildcards](https://docs.splunk.com/Documentation/SCS/current/Search/Wildcards) - trailing not leading
`form_data=*username*password*`

Regex 
`| rex field=form_data "passwd=(?<cred>\w+)" `

Handling finding Filenames
`part_filename{}`

## References

[THM Splunk 101 Room](https://tryhackme.com/room/splunk101)
[Splunk Documentation](https://docs.splunk.com/Documentation) 
[Metadata Documentation](https://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Metadata)
[THM Splunk 2 Room](https://tryhackme.com/room/splunk2gcd5)
[THM Splunk Inciident Handling Room](https://tryhackme.com/room/splunk201)
[Device Hunt](https://devicehunt.com/)
[Motasem Hamdan - Splunk Playlist](https://www.youtube.com/playlist?list=PLqM63j87R5p42cBwRwI24FQeF7oEBFmka)
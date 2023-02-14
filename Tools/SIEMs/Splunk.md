# Splunk


Splunk is one of the leading [[SIEM-Solutions]] that provides the ability to collect, analyze and correlate the network and machine logs in real-time. Splunk is compromised of three main components, list here in linear workflow order:
- Forwarder
	- Agent installed on endpoint intended to be monitored, collects data and sends to Splunk instance - lightwieght processes, requires minimal resources; data soureces
		- Logs
		- Database communications
		- Web traffic
- Indexer - Processes data from Forwarders
	- Normalize data into field-value pairs, datatype detirmination and stores data as events
- Search Head
	- Search & Reporting Application for users to search indexed logs  - uses Splunk Search Processing Lanaguage
	- Generate graph visualizations  

## GUI Navigation 

- Splunk Bar, top panel for:
	- Messages
	- Settings
	- Activity - job pregress
	- Help
	- Find - Search Features

- Apps Panel - App usage and Configuration
	- Notablely the `Search & Reporting` is accessed here

- Explore Splunk - quick links 
	- Add Data
	- Splunk Apps
	- Splunk Docs

- Splunk Dashboard - Dashboard are GUI scoping of Concepts monitored in Splunk -by default no dash is displayed

## Adding Data

By Upload:
1.  **Select Source** -> Pick a file
2.  **Select Source Type** -> Displays how the Splunk platform sees your data before indexing, allowing for user to select type for remove extranious data 
3.  **Input Settings** -> 
	1. Select the index where these logs will be dumped 
	2. `host` value to be associated with the logs, should be name of the machine events originate.  
	- *"a "sandbox" index as a destination if you have problems determining a source type for your data. A sandbox index lets you troubleshoot your configuration without impacting production indexes. You can always change this setting later."* 
5.  **Review** -> Review configuration 

## Useful SPL

The SPL (Splunk Search Processing Language)

[Botsv2 Dataset](https://github.com/splunk/botsv2)

[Metadata Article](https://www.splunk.com/en_us/blog/tips-and-tricks/metadata-metalore.html?301=/blog/2017/07/31/metadata-metalore.html)

[Metadata](https://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Metadata) Command can be used to search for the same kind of information that is found in the Data Summary
```c
// Change index!
| metadata type=sourcetypes index=botsv2 | eval firstTime=strftime(firstTime,"%Y-%m-%d %H:%M:%S") | eval lastTime=strftime(lastTime,"%Y-%m-%d %H:%M:%S") | eval recentTime=strftime(recentTime,"%Y-%m-%d %H:%M:%S") | sort - totalCount
```

Return events containing Keyword
`index="botsv2 $keyword"`

PAN traffic source type
`index="botsv2" $keyword sourcetype="pan:traffic"`

HTTP styream source type from IP address
`index="botsv2" 10.10.10.10 sourcetype="stream:HTTP"`
``

## References

[THM Splunk 101 Room](https://tryhackme.com/room/splunk101)
[Splunk Documentation](https://docs.splunk.com/Documentation) 
[Metadata Documentation](https://docs.splunk.com/Documentation/Splunk/latest/SearchReference/Metadata)
[THM Splunk 2 Room](https://tryhackme.com/room/splunk2gcd5)
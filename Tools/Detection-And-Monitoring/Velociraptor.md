# Velociraptor

#### Introduction and Overview

Velociraptor [documentation](https://docs.velociraptor.app/docs/overview/), *Velociraptor is a unique, advanced open-source endpoint monitoring, digital forensic and cyber response platform. It was developed by Digital Forensic and Incident Response (DFIR) professionals who needed a powerful and efficient way to hunt for specific artefacts and monitor activities across fleets of endpoints. Velociraptor provides you with the ability to more effectively respond to a wide range of digital forensic and cyber incident response investigations and data breaches:"
- Reconstruct attacker activities through digital forensic analysis
- Hunt for evidence of sophisticated adversaries
- Investigate malware outbreaks and other suspicious network activities
- Monitory continuously for suspicious user activities, such as files copied to USB devices
- Discover whether disclosure of confidential information occurred outside the network
- Gather endpoint data over time for use in threat hunting and future investigations

Server-client model where the client is an agent on a endpoint machine that transfers data to the server. Data can then by queried with Velociraptor Query Language (VQL). [VQL Fundamentals](https://docs.velociraptor.app/docs/vql/) *provide a deep dive into VQL and how to write your own artefacts and queries*.

Created by Mike Cohen, a former Google employee who worked on tools such as [GRR](https://github.com/google/grr) (GRR Rapid Response) and [Rekall](https://github.com/google/rekall) (Rekall Memory Forensic Framework). Mike joined Rapid7's Detection and Response Team and continues to work on improving Velociraptor.

Additional resources
- [https://docs.velociraptor.app/training/](https://docs.velociraptor.app/training/)
- [https://docs.velociraptor.app/blog/](https://docs.velociraptor.app/blog/)
- [https://docs.velociraptor.app/presentations/](https://docs.velociraptor.app/presentations/)
- [Subscriber room only - THM Velociraptor Room - deployment setup for testing](https://tryhackme.com/room/velociraptorhp)
- [John Hammond YouTube - Mass Digital Forensics & Incident Response with Velociraptor - With creator Mike Cohen and Matt Green from Rapid7](https://www.youtube.com/watch?v=M7bMfdmWR7A)

![](velociraptorofficialdocsimage-oneofthebestimageseveraboutdinosaurs.png)
This is possibly the best image of a Velociraptor on the internet and branding for Open Source Project  ever - [Image Reference](https://docs.velociraptor.app/docs/overview/). 
#### Cheatsheet

Navigation:
- Find Clients with `Search -> *Magnifying glass*` or `Show All` 
	- Clients has the follow data points:
		- Online State - Green dot for online - red dot for offline for over 24 hours
		- Client ID - Unique ID 
		- Agent Version
		- Agent Name
		- Last Seen At
		- Last Seen IP
		- Operating System Version
		- Hostname - Client ID is used over Hostname for identifying machine 
		- Release
		- Architecture
		- Client Metadata
		- Labels - Labelling helps group clients
	- Tabs:
		- Interrogate 
		- Collection 
			- ` + ` button to create a new collections involving:
				- `Select Artefacts -> Search -> $artefact` then provide input. 
					- `$OS.$targetModule.$funct` - `Window.Detection.ProcessMemory`, `Generic.Client.Info`
					- Input:
						- Configure Parameters
						- Specify Resources
						- Review
						- Launch
		- VFS (Client Virtual Filesystem)
		- Overview
		- `VQL Drillown` view shows:
			- Orange - Memory usage over a 24 hours time-span
			- Blue - CPU usage over a 24 hours time-span
		- Shell - execute commands on remote client machines - PowerShell,  Bash, CMD/Dos or VQL 

- Tabs
	- Home (House Icon) - Server Status
	- Hunt Manager - (Target Reticle Icon) 
	- View Artefact
	- Server Events
	- Server Artefacts
	- Notebooks
	- Host Information
	- Virtual Filesystem (VFS)
	- Collected Artefacts
	- Client Events







#### VQL

Get all the unique types and count of signal rules from `Hayabusa` being alerted on. 
```sql

SELECT * , count()  
FROM source(artifact="Windows.EventLogs.Hayabusa/Results")
GROUP BY RuleTitle
```


#### Deployment 

Deploy full-scale Velociraptor using either the [SSL-Self Signed](https://docs.velociraptor.app/docs/deployment/self-signed/) or [Cloud Deployment](https://docs.velociraptor.app/docs/deployment/cloud/) method, or set up a Velociraptor environment on your local machine with [Instant Velociraptor](https://docs.velociraptor.app/docs/deployment/#instant-velociraptor). Consider your options and [[RTFM]] as the [THM Velociraptor Room](https://tryhackme.com/room/velociraptorhp) utilises [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/about) with the server and agent on the same lab VM, which great to try out, but maybe not the best setup for you! 

## References

[Velociraptor documentation](https://docs.velociraptor.app/docs/overview/)
[Rekall](https://github.com/google/rekall) 
[GRR](https://github.com/google/grr) 
[SSL-Self Signed](https://docs.velociraptor.app/docs/deployment/self-signed/) 
[Cloud Deployment](https://docs.velociraptor.app/docs/deployment/cloud/)
[Instant Velociraptor](https://docs.velociraptor.app/docs/deployment/#instant-velociraptor)
[THM Velociraptor Room](https://tryhackme.com/room/velociraptorhp)
[VQL Fundamentals](https://docs.velociraptor.app/docs/vql/)
[https://docs.velociraptor.app/training/](https://docs.velociraptor.app/training/)
[https://docs.velociraptor.app/blog/](https://docs.velociraptor.app/blog/)
[https://docs.velociraptor.app/presentations/](https://docs.velociraptor.app/presentations/)
[John Hammond YouTube - Mass Digital Forensics & Incident Response with Velociraptor - With creator Mike Cohen and Matt Green from Rapid7](https://www.youtube.com/watch?v=M7bMfdmWR7A)
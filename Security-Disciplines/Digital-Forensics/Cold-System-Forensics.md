# Cold System Forensics

Cold system forensics emerged as a direct response to [[Cold-Boot-Attacks]]. These are a class of [[Side-Channel-Attacks]] were RAM temperature is as indicator use and would force continuous unexpected reboots till a compromised machine's RAM is full of sensitive data. Although Cold System Forensics has evolved into a discipline encompassing the examination of the entire dormant system.

The primary issue of Cold System Forensic is preventing potential tampering and modification of the system. It is a applicable in the following scenarios:
- Where [[Physical-Security]] and [[Physical-ACLs]] are operationally strong 
- Where risk of modification by live analysis or use would harm objective - legal settings, no Malware, etc
- Comprehensive data captures
- [[Incident-Response]] - but this very time consuming remember time budgeting
- Legal proceedings
- Data recovery/File carving
- Legacy Systems

If you need to scared out of shared Cloud and Data Centers consider how some in Forensics are devoid of the idea how **Authorial opinions**: THM (probably because companies exist to to do this) suggests Cloud and Virtualised Environments - I disagree:
> Unless you can:
> > 0. If the attacker can access the rack, you have (past and future) physical security and ACL problems of another company (what IoT cameras data is retained that is it just APT Beacons?)
> 1. pull the server from the rack (Good Luck getting that on time)))
> 2. deal with the legal issues of every other company on that server at some point (Have the legal team and budget of the GDP of small country)
> 3. ascertain what other VMs, Containers, microservices, IaaS or underlying data centre systems of any kind that have ever been run on the server (Have four leaf clovers in your hair as you run around show you have the data retention and analytics of the 2200s)
> 4. some how have cloud logs that date back beyond 2 weeks (are you Jason Borne?)
> 5. Then get your Legal team explain how X did Y on Z VM and not have the Defence include how ANY of the previously mentioned issues that could have been anyone or use it to encumber the case by backdooring the legal case by disclosing any publicly available information from provider and other service users to another company on the server or Data Center's IaaS IPO. Or defence could just say X provider was compromised at the time to such a degree, which does happen - how could prove this was not obfuscation from APT insert-number-here (does you Legal Team have plot armour as well)
> 6. Then get some people to find what you were looking for in a time constrained workplace setting... (the easiest on this list)
> 7. Then explain the above to your boss and how that is value or even possible
> Are you really able to prove anything with just a VM image to non-technical people in a court? Are you are Law Firm standing to gain from the disputes? What kind of criminals have AWS or Azure subscriptions? Have you been hit in the head with Server and are you in some kind of Coma? 
> - I am also certain that this is not a novel argument and I pretty sure I have heard someone on a podcast, talk or conference, not sure - but I remember the person saying them stating this issue before the big migration towards the cloud.


Order Volatility - Prioritisation based on the data potential exposure to change:
- CPU registers and cache
- Routing table, ARP Cache, Process table, Kernel Statistics and RAM
- Temporary File Systems
- Hard Disk
- Remote Logging and Monitoring Data
- Physical Configuration and Network Typology
- Archival Media


Acquisition Methods:
- Disk imaging - copy bit-by-bit of forensic data to another media of storage for replication and investigation without harming the original
	- Write blocking
- Physical Acquisition
	- Chip-off forensics: delicate process involving removing and reading a storage chip
	- Joint Test Action Group (JTAG) forensics: [[JTAG]] protocol interface to access data from embedded systems. 
- Secure Storage:
	- Faraday Cages: prevent contamination between devices and wireless and radio transmission signal of all kind
	- Device separation and asset management
	- Access Control 
	- Environmental Control - [[Physical-Security]]
	- Regular Auditing
- Chain of Custody of Forensic Data:
	- Document every step
	- Secure Transport
	- Hashing
	- Write Blocking

Associated Risks and Common Mistake of imaging, handling and investigating Cold Systems
- Data integrity: Use write-blockers to prevent accidental modification
- Misinterpretation of data: 
	- Understand the limitations of tool but also how they do what do
	- Data can a clue of a set of clues not evidence
- Documentation:
	- Good noting and reporting as you go makes the report better 
	- Tools are data harvesters, notes are bails of organised data points that your brain can work on, do not be a tool of tools. Use Brain. 
	- Saves time and prevents retreading steps
	- Screenshot says a thousand words and a few more if you draw and note on them
	- Timestamps for Timeline
	- Tool Versions 
	- Chain of custody for collected evidence
	- Phone numbers to call when something goes wrong or before it goes wrong
	- Scope


Image disks with tools
```bash
# Using dd
# Beware of using dd for tasks where something less powerful can do the same job
dd if=/$path/$to/$input of=/$path/$to/$output
# View mountable disks
df -h # will show if a device is automatically mounted 
lsblk # will all block devices
# gnome-disk for GNOME GUIs

# Copy input to output bytesize of 1M, synctronize data (or we need to use `sync` afterwards) and show progress
# Default bytesize is 526bytes
dd if=/$path/$to/$input of=/$path/$to/$output bs=1M conv=sync status=progress


dc3dd


guymager


```
Or [[FTK-Imager]]

For [[Memory-Forensics]] use:
- [[Volatility3]]

Disk Imaging Analysis Tools:
- [[Autopsy]]
- [[EnCase]]
- [[The-Sleuth-Kit]]

Mount a disk on Linux and explore
```bash
mount | grep $diskname

mount /mnt /$disk/$to/$mount/mnt
```

Mount a disk on Windows and explore
```

```

[[Recovering-Deleted-Data-Manually-For-Forensics]]




## References

[THM Room Intro to cold system forensics](https://tryhackme.com/r/room/introtocoldsystemforensics)
[baeldung dd command](https://www.baeldung.com/linux/dd-command)
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
> > 0. If the attacker can access the rack, you have (past and future) physical security and ACL problems of another company (what IoT cameras data is reatined that is it just APT Beacons?)
> 1. pull the server from the rack (Good Luck getting that on time)))
> 2. deal with the legal issues of every other company on that server at some point (Have the legal team and budget of the GDP of small country)
> 3. ascertain what other VMs, Containers, microservices, IaaS or underlying data centre systems of any kind that have ever been run on the server (Have four leaf clovers in your hair as you run around show you have the data retention and analytics of the 2200s)
> 4. some how have cloud logs that date back beyond 2 weeks (are you Jason Borne?)
> 5. Then get your Legal team explain how X did Y on Z VM and not have the Defence include how ANY of the previously mentioned issues that could have been anyone or use it to encumber the case by backdooring the legal case by disclosing any publicly available information from provider and other service users to another company on the server or Data Center's IaaS IPO. Or defense could just say X provider was compromised at the time to such a degree, which does happen - how could prove this was not obfuscation from APT insert-number-here (does you Legal Team have plot armour as well)
> 6. Then get some people to find what you were looking for in a time constrained workplace setting... (the easiest on this list)
> 7. Then explain the above to your boss and how that is value or even possible
> Are you really able to prove anything with just a VM image to non-technical people in a court? Are you are Law Firm standing to gain from the disputes? What kind of criminals have AWS or Azure subscriptions? Have you been hit in the head with Server and are you in some kind of Coma? 



## References

[THM Room Intro to cold system forensics](https://tryhackme.com/r/room/introtocoldsystemforensics)
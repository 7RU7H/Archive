# Cold Boot Attacks

Cold Boot Attacks are a class of [[Side-Channel-Attacks]] were RAM temperature is as indicator use and would force continuous unexpected reboots till a compromised machine's RAM is full of sensitive data. [[Cold-System-Forensics]] started as attempt at at least post-mortem this attack.

Cold Boot Attacks are extremely powerful. Hyper Visor Exploits exist and have existed, including the pre 2024 VMWare Admin to Domain Admin that is trivial. For detailed and opinionated rant on why the Forensics to deal with the attack are lunacy see appendix. 

to read
https://github.com/infosecconsultant/cold-boot-attacks 
https://www.blackhat.com/presentations/bh-usa-08/McGregor/BH_US_08_McGregor_Cold_Boot_Attacks.pdf

#### Prevention

The bigger the asset management list the unimaginably large this problem will get...
0. Do not do anything in the Cloud - ever see appendix
1. Physical Security - good luck with state of doors and locks - yikes
	1. No liquid nitrogen , freezing spray in the building
2. ACLs on who is allowed to touch anything that remotely resembles a computer
3. Asset management can never ever have blind spots 
	1. If you must merge, stagger merger and test every asset 
4. Do not host any AI at any point for any reason ever
5. Have a network segmentation that is such that any initial infection can never actually spread, because another automated system can pull cables out (and that has to not be connected and have its own ACL)
6. Be able and will to dump hardware, data without issue 
7. Have hardware modules that:
	1. Turn the the machine one that has wait till...
	2. Removed RAM is resat- creating separated automated check on reboots
8. All USB ports are enclosed, with required devices have bound cables to prevent tapping
9. No Bluetooth or WIFI
10. Encrypting RAM
11. Live and Shutdown Memory erasure
12. External Key storage
13. Turn it off properly when not in use
14. Audit firmware or lifespan everything
15. Disk Encryption

Temperature detector could fooled by stick something hot to the detector and cold to RAM
## References

[THM Room Intro to cold system forensics](https://tryhackme.com/r/room/introtocoldsystemforensics)
[Wikipedia - Cold Boot Attack](https://en.wikipedia.org/wiki/Cold_boot_attack)

## Appendix

If you need to scared out of shared Cloud and Data Centers consider how some in Forensics are devoid of the idea how **Authorial opinions**: THM (probably because companies exist to to do this) suggests Cloud and Virtualised Environments - I disagree:
> Unless you can:
> 0. If the attacker can access the rack, you have (past and future) physical security and ACL problems of another company (what IoT cameras data is reatined that is it just APT Beacons?)
> 1. pull the server from the rack (Good Luck getting that on time)))
> 2. deal with the legal issues of every other company on that server at some point (Have the legal team and budget of the GDP of small country)
> 3. ascertain what other VMs, Containers, microservices, IaaS or underlying data centre systems of any kind that have ever been run on the server (Have four leaf clovers in your hair as you run around show you have the data retention and analytics of the 2200s)
> 4. some how have cloud logs that date back beyond 2 weeks (are you Jason Borne?)
> 5. Then get your Legal team explain how X did Y on Z VM and not have the Defence include how ANY of the previously mentioned issues that could have been anyone or use it to encumber the case by backdooring the legal case by disclosing any publicly available information from provider and other service users to another company on the server or Data Center's IaaS IPO. Or defense could just say X provider was compromised at the time to such a degree, which does happen - how could prove this was not obfuscation from APT insert-number-here (does you Legal Team have plot armour as well)
> 6. Then get some people to find what you were looking for in a time constrained workplace setting... (the easiest on this list)
> 7. Then explain the above to your boss and how that is value or even possible
> Are you really able to prove anything with just a VM image to non-technical people in a court? Are you are Law Firm standing to gain from the disputes? What kind of criminals have AWS or Azure subscriptions? Have you been hit in the head with Server and are you in some kind of Coma? 



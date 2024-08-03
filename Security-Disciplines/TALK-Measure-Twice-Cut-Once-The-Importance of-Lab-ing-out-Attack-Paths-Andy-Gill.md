# Measure Twice, Cut Once: The Importance of Lab-ing out Attack Paths - Andy Gill

[Measure Twice, Cut Once: The Importance of Lab-ing out Attack Paths - Andy Gill - YouTube](https://www.youtube.com/watch?v=MAT_-BJxABI)

https://blog.zsec.uk/
https://www.youtube.com/@ZephrSec
https://github.com/ZephrFish

Mistakes are expense - Discover everything and then make a lab!

- Gain an understanding of environment as a standard user
	- GUI -> hidden file and look in `c:\` for indicators of a defensive stack, but be aware of what that user *would normally do*.
- Identify areas of focus

Circular Attack Path Methodology - CA/CD - CL
- Learn
- Build
- Break
- Fix
- Defend

[lolbas - Installutil](https://lolbas-project.github.io/lolbas/Binaries/Installutil/) is good
```
installutil
```

LOLBAS as a SOC are hard to map out. Sometimes real world client load vulnerable drivers legitimately for legitimate software, poor Blue Team.

Study your target, Lab out the key details:
- Red Teaming
- Pentesting
	- Do not use `nmap` on a production environment
	- AD lab is pretty quick
- Application Security 
	- If you can't replicate the specific scenario, test payloads elsewhere
	- If doing SQLI don not to `drop tables` 
- Social Engineering
	- Test your XYZ-ishing them on your own team first 
- Hardware & IOT Testing
	- Anti-Tampering can be countered with multiple test devices
- Physical Security
	-  Test recon, not "hello this is a bank robbery"

Inventory for your Lab?
- What is the EDR, can I get the same version?

Building
- Defender for Endpoint and Identity - free trial ~250 endpoints
- Azure pricing changes daily
- Mirror the defensive stack and the standard user
	- Be aware that with any emulated stack there is a learning period so *questionable* IOCs  would not necessarily flag 
	- Take into consideration the defensive tools like a chaining of booleans where a set of informationals occur and then trigger some alert
- Add addition logging
	- Mechanics of Visibility
	- Event Forwarding - because ELK, Kabana, Splunk (free trial on one system is fine, but multiple is not large enough capture size) is easy viewing - **authors opinion: "`EventViewer` is horrible"**
- Variety is key! 

Hades Canyon NUCs, i7, 64GB RAM, 4TB Storage

Andy Gill Collects and Fixes NUC like the NUCs [Womble](https://www.youtube.com/watch?v=kib7ZDsTgz0) as fellow hardware [Womble](https://www.youtube.com/watch?v=Kn3LMjLNlRs), [I approve and post this to all neigh-sayers](https://www.youtube.com/watch?v=RCw7z8h3m_Y&list=PLlCWumBKJS7BMLFhvlzJCaKwr3FyeeU4I), Marie Kondo did us all great service.

Build yourself before Automating it to see how the *cake* is made
- Automated
	- https://github.com/clong/DetectionLab
		- Uses vagrant and ansible - give it is own /24 range /8 is chaotic at best
		- If your home lab is 192.168.X.X, modify the vagrant to another like 172.16.X.X or change your home network to 10. ranges
	- https://github.com/AutomatedLab/AutomatedLab
	- https://blog.zsec.uk/orchestrating-the-hacklab/
Tooling
- Sysmon
- Velociraptor
- Security Onion
- HELK


Building your own lab offensive tooling and development
https://github.com/safebuffer/vulnerable-AD
FAFO - Build, break, defend and fix
Visual Studio - 2019
- Powershell
- Python
- Different networks

Andy the Beacon Slayer
- Never test in production
- Beacons with long jitter takes a long time to figure out something has gone very, very wrong
- Inline execution of non-graceful exit kills the parent process, which is the beacon
- Always multiple beacons on multiple channels - one is none and two is one for shells
- Linking beacons links the problems

Andy the Bacon Provider
- Keep it simple
- Bespokle function
- Not always Offensive focused
	- using net without using net
- Use the CLR for non-offensive - CLREnumator2 to find spoofable or sacrificable processes; require high privileges to use (this is great way to never have to do offensive `eventviewer` usage)

Almost get the password policy
- observation windows behavour differently:
	- Infinite observation window and spraying 3800 user (lab context) will lock all 3800 user out in one fell swoop

SharpEDRChecker lists process, services, loaded drives and OS 
- ASMI.dll calling will flag for Windows Defend 
- SharpEDRChecker displays indicators of Vulnerability management and EDR software
- This is good against Sysmon
	- If you enable the cloaking for Sysmon the driver still remains visible, unless you modify it manual - facepalm.
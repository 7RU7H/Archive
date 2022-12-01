# Lockhead Martin Cyber Kill Chain

![lhmck](Images/THE-CYBER-KILL-CHAIN-body.png.pc-adaptive.1920.medium.png)

1. Reconnaissance
	 - [[Active-Recon]] 
	 - [[Passive-Recon]]
	 - [[OSINT]] 
	 - [[Email-Harvesting]]
2.  Weaponization
	- Using a Command and Control - see [[C2-Matrix]] and apply techniques from [MITRE ATT&CK](https://attack.mitre.org/tactics/TA0011/).
	- Malicious VBA Macros see  [[Useful_Visual_Basic]] or article ["Intro to Macros and VBA For Script Kiddies" by TrustedSec](https://www.trustedsec.com/blog/intro-to-macros-and-vba-for-script-kiddies/).
	- [[Bad-USBs]]
	- Implants
3. Delivery 
	 - [[Phishing]] emails
	 - Distributing [[Bad-USBs]]
	 - [[Watering-Hole-Attack]] 
4. Exploitation
	- CVEs
	- Zero-days 
	- [[Social-Enigeering]] human users into compromising their machines for the attacker
	- Users triggering Email attachment
5.  Installation
	- Web Shells
	- [[Timestomping]]
	- Masquerade [T1036](https://attack.mitre.org/techniques/T1036/)
	- [[Metasploit]] shell with `msfvenom`
	- [[Reverse-Shells-Listing]]
	- [[Windows-Persistence-Implant-Existing-Services]] - as [T1543.003](https://attack.mitre.org/techniques/T1543/003/)
	- Run Keys / Startup Folder Persistence [T1547.001](https://attack.mitre.org/techniques/T1547/001/)
6. Command & Control 
	- DNS Tunneling 
	- Beaconing through legitmate protocols - port 4444 is well known metasploit port...
7. Actions on Objectives - Which is not the same as [[Data-Exfiltration-Defined]]
	-   Collect the credentials from users.
	-   Perform privilege escalation (gaining elevated access like domain administrator access from a workstation by exploiting the misconfiguration).
	-   Internal reconnaissance (for example, an attacker gets to interact with internal software to find its vulnerabilities).
	-   Lateral movement through the company's environment.
	-   Collect and exfiltrate sensitive data.
	-   Deleting the backups and shadow copies. Shadow Copy is a Microsoft technology that can create backup copies, snapshots of computer files, or volumes. 
	-   Overwrite or corrupt data.

-   exploit public-facing application

-   powershell
-   dynamic linker hijacking
-   spearphishing attachment - exploitation

-   fallback channels - c2
-   data from local system - ob

## References 
[LockMartin-Image-Source](https://www.lockheedmartin.com/en-us/capabilities/cyber/cyber-kill-chain.html)
["Intro to Macros and VBA For Script Kiddies" by TrustedSec](https://www.trustedsec.com/blog/intro-to-macros-and-vba-for-script-kiddies/).
[MITRE ATT&CK TA0011](https://attack.mitre.org/tactics/TA0011/)

# Adversary Emulation


## Takeaways from Jake Williams - Emulating the Adversary in Post-Exploitation w/ Jake Williams - SANS HackFest & Ranges Summit 2020

*"We all know that non-technical personnel (e.g. managers and executives) struggle to understand the impacts detailed in technical pentest/red team reports. But the same people have no trouble understanding the impact of a data breach. What's the difference? Well, in most red team reports, we focus on system compromise and getting domain admin rather than emulating the adversary and demonstrating what can be done with a compromise. Real attackers aren't interested in complicated exploitation techniques, they just want to get the data that pays the bills. In this talk, we'll discuss how attackers discover relevant data to target so you can more closely emulate your adversary and maximize the value of your next penetration test."*

Jake Williams @malwarejake, President & Founder, Rendition Infosec

Must be about demonstrating impact, for example having a Home Wifi config, more impactful than stating you got Domain Controll in X number of, yes if get the DC you get the configs - Just dont go full cyber - liability risk from human error is too high.
- We are inherently loss averse - spend more to avoid a loss than gain the same thing
- - Better understand tangible things than intangible counterparts
- SEES - Situational Awareness, Explain, Estimate and Strategic Notice - [[Good-Acronyms-And-Phrases]]
- 2 is 1, 1 is none; get multiple shells.
- Do no harm - you are a service
- Never go Full Cyber - Redteams should avoid, but APTs do not: 
	- Locking out accounts
	- Anything that might destroy data or impact systems, ask will this potentially cause collateral data destruction?
	- Anything involving switching - STP is fickle (Spanning Tree Protocols)
	- Actually exfiltrating sensitive, and especially regulated data - [[Data-Exfiltration-Defined]] - liability, create fake data to demonstrate you can
	- Exploiting storage devices and controllers
	- Performing post-exploitation on hypervisors - very cool but very fickle too

#### Post Exploitation

Pivot to data the user already has access to
- `get-psdrive`
- go for public shares, vortex of nightmares
- Recent documents
	 - Windows Search terms
	- `reg query "hkcu\software\microsoft\windows\currentversion\explorer\recentdocs"`
- Steal reg hive `rawcopy` `sluethkit`
- Hunt for the most sensitive documents - what highlights the biggest impact?
	- use `tika`  - https://github.com/apache/tika - [[Java]] 70mb+ extract office docs data with `.*x`
- Target backups - say you download the back, but do not download the backup for packet economy, time and legal reasons
	- open iSCSI endpoints - they exist
	- Duplication! stakeholders hate it 

- Compromise source code - Intellectual property is valuable - i.e. `mySpecialTradingAlgorithm.py`
	- Exfiltrate source code
	- Add a backdoor  - very difficult to find
	- API keys and passwords
	- Developers often have debug rights WITHOUT admin priveleges  - [[SeDebugPrivilege]]
- Plant web shells
	- There are stealthy webshells that are not destructive or resource heavy
	- Hunting is time expensive and infrastructure redeployment costly
	- Webshells demonstrate directory capability to perform modification, on files. Demo a logon page, customer data is legal liability.
Dump WIFI and VPN configs
- Personal laptops have home WIFI configs - scary 
- Jake's favourite share - the weirdly named public share; these are created to dump data to bypass the lengthy time intra-legally to creation of a security group for business-to-business contractors that need access.  

## References

[Emulating the Adversary in Post-Exploitation w/ Jake Williams - SANS HackFest & Ranges Summit 2020](https://www.youtube.com/watch?v=VctxgiEoDUU)
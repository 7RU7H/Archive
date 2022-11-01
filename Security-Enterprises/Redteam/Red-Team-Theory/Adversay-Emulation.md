
# Adversary Emulation




## Takeaways from Jake Williams - Emulating the Adversary in Post-Exploitation w/ Jake Williams - SANS HackFest & Ranges Summit 2020

*"We all know that non-technical personnel (e.g. managers and executives) struggle to understand the impacts detailed in technical pentest/red team reports. But the same people have no trouble understanding the impact of a data breach. What's the difference? Well, in most red team reports, we focus on system compromise and getting domain admin rather than emulating the adversary and demonstrating what can be done with a compromise. Real attackers aren't interested in complicated exploitation techniques, they just want to get the data that pays the bills. In this talk, we'll discuss how attackers discover relevant data to target so you can more closely emulate your adversary and maximize the value of your next penetration test."*

Jake Williams @malwarejake, President & Founder, Rendition Infosec

Must be about demonstrating impact, for example having a Home Wifi config, more impactful than stating you got Domain Controll in X number of, yes if get the DC you get the configs - Just dont go full cyber - liability risk from human error is too high.

2 is 1, 1 is none; get multiple shells.

#### Do no harm, dont go full cyber

Redteams should avoid, but APTs do not: 

- Locking out accounts
- Any potential collerateral data destruction
- Any switch; STP is fickle
- [[Data-Exfiltration-Defined]] - liability, create fake
- exploiting storage devices and controller - they break easily
- post exploitation hypervisor - very fickle too

#### Post Exploitation

Pivot to data the user already has access to
- `get-psdrive`
- go for public shares, vortex of nightmares
- `reg query "hkcu\software\microsoft\windows\currentversion\explorer\recentdocs"`
- steal reg hive rawcopy sluethkit
- 
Hunt for sensitive documents
- tika, java 70mb+ extract office docs data with `.*x`

Target backup servers
- open iscsi endpoints exist
- duplication! stakeholder hate it 

Compromise source code
- intellecrual property
- and backdoors - very difficult to find
- devs often have debug rights WITHOUT admin privs
- api keys and passwords

Plant web shells
- there are stealthy webshells
- hunting is time expensive and infrustructure redeployment costly
- webshells demonstrate directory capabilitt to perform modification,
 on files. demo a logon page, customer data is legal liability.

Dump WIFI and VPN configs
- personal laptops have home wifi configs - scary 


## References

[Emulating the Adversary in Post-Exploitation w/ Jake Williams - SANS HackFest & Ranges Summit 2020](https://www.youtube.com/watch?v=VctxgiEoDUU)
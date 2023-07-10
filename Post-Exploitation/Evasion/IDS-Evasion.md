# IDS Evasion

For general [[Evading-IPS-And-IDS]] - Split and change!

- IDS Typology
	- Network-based IDS (NIDS)
		- [Suricata](https://suricata.io/)
	- Host-based IDS
		- [Wazuh](https://wazuh.com/)
- Detection Methodologies
	- Signature-Based (rules that triggers alerts)
	- Anomaly-Based (activity narrative that triggers alerts)
- Data Visualisations
	- [Graylog](https://www.graylog.org/products/open-source) 
	- [ELK Stack](https://www.elastic.co/what-is/elk-stack).


## NIDS

Commonly deployed on the LAN side of a firewall

- Quality of rule set matters
	- Well defined, tested and consistently applied
- Can generate false positive due to volumes of traffic 
- In-transit encrypted packets are not analysable

## HIDS

Commonly deployed as installed agent on a host that forward data  to some central management system; data include:
- Logs - atypically network logs
- [[Windows-Registry]] changes
- Metric data
- File system status

- Requires automation to manage deployment 
- Configuration to monitor applications is required and potential oversight

## Reconnaissance

Methodological concerns
- Stealthier equates generally to less information, less stealthy more detectable
- Target position in relation to the network
	- Is it internet exposed?
		- Rate limiting - `fail2ban`
- Complete evasion or partial detection - IDS scoring as a metric of detection from a evasive side to quantify actions taken and to be taken?   

- OSINT
	- [[Shodan]] - services active on a node
	- [[Search-Engine-Dorking]] into an node - [[ExploitDB]] 
	- [[Recon-ng]] - [[DNS-Active-Recon]] and [[DNS-Recon-Passive]] - for domain information disclosures about a network behind  [[Firewalls]] 
	 - [[Amass]] - ASN and WHOIS record, [[DNS-Active-Recon]] and [[DNS-Recon-Passive]] 
	 - Scraping information Job listing for technologies required for roles
	 - Error pages, file extensions, debug pages, server tag in HTTP responses
		 -  [[Nuclei]]
-  Custom User-Agent 
	- [[Nmap-Cheatsheet]], [[Nmap-AllTheScripts]] -  `--script-args http.useragent=""`
	- [[Curl-Cheatsheet]] - `-A, --user-agent <name>`
	- [[Nikto-Cheatsheet]] -  `-useragent $agent`,
- Vulnerability
	- [[Nikto-Cheatsheet]] - tuning `-T $num`,  
	- [[Nuclei]]
- Evasion 
	- [[Nikto-Cheatsheet]] - `-e $num`



## References

[THM IDS evasion room](https://tryhackme.com/room/idsevasion)
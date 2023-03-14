
# Cyber Threat Intelligence Defined

## Introduction

[Cyber Threat Intelligence](https://en.wikipedia.org/wiki/Cyber_threat_intelligence) (CTI) is knowledge, skills and experience-based information concerning the occurrence and assessment of both cyber and physical threats and threat actors that is intended to help mitigate potential attacks and harmful events occurring in cyberspace.  The primary objective of CTI is to understand the relationship between your operational environment and your adversary and how to defend your environment against any attacks. CTI strict keyword definitions:

Noun | Definition
--- | ---
Data | Discrete indicators associated with an adversary such as IP addresses, URLs or hashes.
Information | A combination of multiple data points that answer questions such as “How many times have employees accessed tryhackme.com within the month?”
Intelligence | The correlation of data and information to extract patterns of actions based on contextual analysis.

Cyber Threat Context question saught to be answered by practioners:

-   Who’s attacking you?
	- Remember attribution is complex and non-absolute pseudo-result-based task 
-   What are their motivations? 
	- Data Exfiltration, Sabotage, Persistence (is for Post-Acquisition pivoting?), Ideological, Extortion, Hijacking
-   What are their capabilities? 
-   What artefacts and indicators of compromise (IOCs) should you look out for?

Sources:
-   Internal:  
    -   Corporate security events such as vulnerability assessments and incident response reports.
    -   Cyber awareness training reports.
    -   System logs and events
-   Community
    -   Open web forums.
    -   Dark web communities for cybercriminals
-   External
    -   Threat intel feeds (Commercial & Open-source) 
		- Threat reporting from [Mandiant](https://www.mandiant.com/resources), [Recorded Future](https://www.recordedfuture.com/resources/global-issues) and [AT&TCybersecurity](https://cybersecurity.att.com).
    -   Online marketplaces.
    -   Public sources include government data, publications, social media, financial and industrial assessments.

## Threat Intelligence Classifications

*Threat intelligence is data that is collected, processed, and analyzed to understand a threat actor’s motives, targets, and attack behaviors...quote:Threat intelligence is evidence-based knowledge (e.g., context, mechanisms, indicators, implications and action-oriented advice) about existing or emerging menaces or hazards to assets.* – Gartner - [Crowdstrike](https://www.crowdstrike.com/cybersecurity-101/threat-intelligence/)

-   **Strategic Intel:** High-level intel takes into consideration the entire organisation’s threat landscape and maps out the risk areas based on trends, patterns and emerging threats that may impact business decisions.
-   **Technical Intel:** Looks into evidence and artefacts of attack used by an adversary. Incident Response teams can use this intel to create a baseline attack surface to analyse and develop defence mechanisms.    
-   **Tactical Intel:** Assesses adversaries’ tactics, techniques, and procedures (TTPs). This intel can strengthen security controls and address vulnerabilities through real-time investigations.
-   **Operational Intel:** Looks into an adversary’s specific motives and intent to perform an attack. Security teams may use this intel to understand the critical assets available in the organisation (people, processes and technologies) that may be targeted.


## CTI Lifecycles

Continous data processing from raw data to contextualised and actionable insights focusing triaging security incidents:

1. Planning and Direction 
	- Asset inventory
	- Impact per Asset loss
	- Sources of data and intel used in protection
	- Defensive Tooling
1. Collection
	- Gathering process, usual automated for timesaving during triaging
1. Processing
	- Sorting, organising, data correlation and data presentation 
1. Analysis
	- Investigating potential threats
	- Refining defensive action plans
	- Strengthening security controls or justifying investments in additional resources
1. Dissemation
	- Reporting produced for targeting specific stakeholders reporting requirements  
1. Feedback
	- Analysts rely on regular feedback provided by stakeholders to improve the threat intelligence process and implementation of security controls

## CTI Standards and Models

[[MITRE-ATT&CK]]

[The Trusted Automated eXchange of Indicator Information (TAXII)](https://oasis-open.github.io/cti-documentation/taxii/intro) defines protocols for securely exchanging threat intel to have near real-time detection, prevention and mitigation of threats. The protocol supports two sharing models:
-   Collection: Threat intel is collected and hosted by a producer upon request by users using a request-response model.
-   Channel: Threat intel is pushed to users from a central server through a publish-subscribe model.

[Structured Threat Information Expression (STIX)](https://oasis-open.github.io/cti-documentation/stix/intro) is a language developed for the "specification, capture, characterisation and communication of standardised cyber threat information". 

[[Lockhead-Martin-Cyber-Kill-Chain]]

[[Diamond-Model]]

## CTI Tools

[**Urlscan.io**](https://urlscan.io) *is a free service to scan and analyse websites. When a URL is submitted to urlscan.io, an automated process will browse to the URL like a regular user and record the activity that this page navigation creates. This includes the domains and IPs contacted, the resources (JavaScript, CSS, etc) requested from those domains, as well as additional information about the page itself. urlscan.io will take a screenshot of the page, record the DOM content, JavaScript global variables, cookies created by the page, and a myriad of other observations. If the site is targeting the users one of the more than 400 brands tracked by urlscan.io, it will be highlighted as potentially malicious in the scan results*.

[Abuse.ch](https://abuse.ch) is a research project hosted by the Institue for Cybersecurity and Engineering at the Bern University of Applied Sciences in Switzerland. It was developed to identify and track malware and botnets through several operational platforms developed under the project, these platforms:

-   [Malware Bazaar](https://bazaar.abuse.ch/):  A resource for sharing malware samples.
-   [Feodo Tracker](https://feodotracker.abuse.ch/):  A resource used to track botnet command and control (C2) infrastructure linked with Emotet, Dridex and TrickBot.
-   [SSL Blacklist](https://sslbl.abuse.ch/):  A resource for collecting and providing a blocklist for malicious SSL certificates and JA3/JA3s fingerprints.
-   [URL Haus](https://urlhaus.abuse.ch/):  A resource for sharing malware distribution sites.
-   [Threat Fox](https://threatfox.abuse.ch/):  A resource for sharing indicators of compromise (IOCs).

[Security Onion](https://github.com/Security-Onion-Solutions/securityonion) *"Security Onion is a free and open platform for threat hunting, enterprise security monitoring, and log management. It includes our own interfaces for alerting, dashboards, hunting, PCAP, and case management. It also includes other tools such as Playbook, osquery, CyberChef, Elasticsearch, Logstash, Kibana, Suricata, and Zeek."*

## References

[THM Cyber Threat Intel Room](https://tryhackme.com/room/cyberthreatintel)
[Wikipedia Cyber Threat Intelligence](https://en.wikipedia.org/wiki/Cyber_threat_intelligence) 
[Crowdstrike](https://www.crowdstrike.com/cybersecurity-101/threat-intelligence/)
[Wikipedia's Bank Of England quote Definition](https://www.bankofengland.co.uk/-/media/boe/files/financial-stability/financial-sector-continuity/understanding-cyber-threat-intelligence-operations.pdf)
[urlscan.io About](https://urlscan.io/about/)
[Abuse.ch](https://abuse.ch)
[THM Threat Intel Tools Room](https://tryhackme.com/room/threatinteltools)
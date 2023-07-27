# Network Security


## Access Control

Any control that attempt to ensure authentication and authorization.

- [[Firewalls]] - Controls incoming and outgoing network traffic with predetermined security rules
- Network Access Control (NAC) - verifies device specifications and conditions as to whether it is compliant with a profile
- Identity and Access Management (IAM) - Controls and manages the asset identities and user access to data systems and resources over the network.
- Load Balancing - Controls resource usage to distribute task across a set of resources
- Network Segmentation - segmentation divides a network in smaller sections to improve performance and security
- Virtual Private Networks (VPN) - encrypted communication commonly with [[IPsec]] protocol
- Zero Trust Model - "*Zero Trust is a security framework requiring all users, whether in or outside the organization’s network, to be authenticated, authorized, and continuously validated for security configuration and posture before being granted or keeping access to applications and data.*" - [Crowdstrike definition of Zero Trust Security](https://www.crowdstrike.com/cybersecurity-101/zero-trust-security/)

## Threat Control

- Intrusion Detection and Prevention - Inspects the traffic and creates alerts (IDS) or resets the connection (IPS) when detecting an anomaly/threat.
	- Consider the article [[Defending-With-IPS-And-IDS]]
- Data Loss Prevention (DLP) - Inspects traffic to block the exfiltration of data - see [[Data-Exfiltration-Defined]]
- Endpoint Protection
- Cloud Security
- [[SIEM-Solutions]]
- Security Orchestration Automation and response (SOAR) - Coordination and automation of task between parties to identify anomalies, threat and vbulnerabilities.
- Network Traffic Analysis & Network Detection and Response - Inspecting network traffic or traffic capture to identify anomalies and threats.


## References

[THM Room Traffic Analysis Essentials](https://tryhackme.com/room/trafficanalysisessentials)
[Crowdstrike - Zero Trust Security](https://www.crowdstrike.com/cybersecurity-101/zero-trust-security/)
[Microsoft Evolving Zero Trust](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWJJdT)
[Cisco - Whart is Network Segmentation](https://www.cisco.com/c/en/us/products/security/what-is-network-segmentation.html)
# Network Security

## Architecture

- [Topology](https://en.wikipedia.org/wiki/Network_topology):
	- Flat versus Hierarchical
		- Flat - all device have equal access
		- Segmented - Subnets divided network, where each subnet contains devices that only need to communicate within the subnet 
			- Unless a device requires to communicate with another device on another subnet, **which should be the exception**
		- Air-Gapped - separate hardware per network that *does not connect in any way*
			- Beware the Bad USB, device-traversing Malware - practice device hygiene 
	 -  Real World:
		- On premise network should not be flat:
			- Network Hardware exists to connect everything to a network
			- Network Hardware needs to be segmented with air-gapped (no connection point between two networks)
		- Cloud can be flat - even in Active Directory - as Governance over the entire set of resource is controlled at the management plane with Policy and Roles with Role Based Access Controls
			- The Hardware is the provider's - your network is virtualised
			- Do not need Domain Controllers in the cloud 
	- [[Secure-Network-Architecture]] best practices
- Services:
	- Promote encryption at rest, egress and ingress (outbound and inbound)

## Access Control

Any control that attempt to ensure authentication and authorisation.

- [[Firewalls]] - Controls incoming and outgoing network traffic with predetermined security rules
- Network Access Control (NAC) - verifies device specifications and conditions as to whether it is compliant with a profile
- Identity and Access Management (IAM) - Controls and manages the asset identities and user access to data systems and resources over the network.
- Load Balancing - Controls resource usage to distribute task across a set of resources
- Network Segmentation - segmentation divides a network in smaller sections to improve performance and security
- Virtual Private Networks (VPN) - encrypted communication commonly with [[IPsec]] protocol
- Zero Trust Model - "*Zero Trust is a security framework requiring all users, whether in or outside the organisation's network, to be authenticated, authorised, and continuously validated for security configuration and posture before being granted or keeping access to applications and data.*" - [Crowdstrike definition of Zero Trust Security](https://www.crowdstrike.com/cybersecurity-101/zero-trust-security/)

## Threat Control

- Intrusion Detection and Prevention - Inspects the traffic and creates alerts (IDS) or resets the connection (IPS) when detecting an anomaly/threat.
	- Consider the article [[Defending-With-IPS-And-IDS]]
- Data Loss Prevention (DLP) - Inspects traffic to block the exfiltration of data - see [[Data-Exfiltration-Defined]]
- Endpoint Protection
- Cloud Security
- [[SIEM-Solutions]]
- Security Orchestration Automation and response (SOAR) - Coordination and automation of task between parties to identify anomalies, threat and vulnerabilities.
- Network Traffic Analysis & Network Detection and Response - Inspecting network traffic or traffic capture to identify anomalies and threats.


## References

[Wikipedia Network Toplogy](https://en.wikipedia.org/wiki/Network_topology)
[THM Room Traffic Analysis Essentials](https://tryhackme.com/room/trafficanalysisessentials)
[Crowdstrike - Zero Trust Security](https://www.crowdstrike.com/cybersecurity-101/zero-trust-security/)
[Microsoft Evolving Zero Trust](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWJJdT)
[Cisco - Whart is Network Segmentation](https://www.cisco.com/c/en/us/products/security/what-is-network-segmentation.html)[]
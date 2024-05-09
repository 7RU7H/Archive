# Network Forensics

[Network Forensics](https://en.wikipedia.org/wiki/Network_forensics) is a sub-branch of digital Forensics and focuses on monitoring and analysis of network traffic. It is the discipline of capturing network traffic, organising and handling data to then analyse it and form basis of understanding as to attribute cause for some purpose, beyond the investigation. It primary purposes are Security Operations (SOC) and Incident Handling/Response and Threat Hunting, but generally for information gathering, legal evidence, or intrusion detection. SOCs are daily security monitoring activities on system performance and health, user behaviour, and security issues. Incident Handling/Response and Threat Hunting purpose of Network Forensics occurring During/Post-incident investigation activities on understanding the reason for the incident, detecting malicious and suspicious activity, and investigating the data flow content. The investigated data types are either live traffic, traffic captures and log files. 

  
**Use cases** |  **Description**
--- | ---
**Network discovery** | Discovering the network to overview connected devices, rogue hosts and network load.    
**Packets reassembling** |  Reassembling the packets to investigate the traffic flow. This use case is helpful in unencrypted traffic flows.  
**Data leakage detection**  | Reviewing packet transfer rates for each host and destination address helps detect possible data leakage.   
**Anomaly and malicious activity detection**  | Reviewing overall network load by focusing on used ports, source and destination addresses, and data helps detect possible malicious activities along with vulnerabilities. This use case covers the correlation of indicators and hypotheses as well.  
**Policy/Regulation compliance control**  | Reviewing overall network behaviour helps detect policy/regulation compliance.

- Record packets of network traffic  
- Create investigat-able sources
- Establishing Attribution

An investigation process identifies communicated hosts in terms of time, frequency, protocol, application and data, therefore tries to answer the **5Ws**;
-  Who (Source IP and port)
-  What (Data/payload)
-  Where (Destination IP and port)
-  When (Time and data)
-  Why (How/What happened)

Advantages | Challenges
--- | ---
Availability of network-based evidence | Sufficient data/evidence collection - lack of full-packet capture on suspicious events
Ease of Data collection - without creating noise | Too much data - short captures must be relevant
Network evidence is hard to destroy | GDPR and Privacy concerns
Availability of log sources | But also for attackes and logs are often erased
Evidence for memory and non-residential malicious activities gathering | Different timezone zones create difficulties in event correlation.
Alot can be actually be done, but | What do you actually do? Analysis Paralysis
Established hardware and technological advances aid analysts | Encrypted Traffic coupled with partial data or enough complex is too complex

Sources of Network Forensics Evidence
-   TAPS
-   InLine Devices
-   SPAN Ports
-   Hubs
-   Switches
-   Routers
-   DHCP Servers
-   Name Servers
-   Authentication Servers
-   Firewalls
-   Web Proxies
-   Central Log Servers
-   Logs (IDS/IPS, Application, OS, Device)

## Concepts

[[Traffic-Analysis]]
[[Packet-Analysis-Header-Filtering]]

## Tools 

[[Wireshark]]
[[Brim]]
[[Snort]]


## References

[Wikipedia Network Forensics](https://en.wikipedia.org/wiki/Network_forensics)
[THM Network Miner Room](https://tryhackme.com/room/networkminer)
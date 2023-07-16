# EDR Defined

[Crowdstrike](https://www.crowdstrike.com/cybersecurity-101/endpoint-security/endpoint-detection-and-response-edr/) (vendor) *"Endpoint Detection and Response (EDR), also referred to as endpoint detection and threat response (EDTR), is an endpoint security solution that continuously monitors end-user devices to detect and respond to cyber threats like ransomware and malware."* 

[Coined by ’s Anton Chuvakin of Gartner coined](https://www.gartner.com/reviews/market/endpoint-detection-and-response-solutions) EDR. It is defined as a solution that *"records and stores endpoint-system-level behaviours, uses various data analytics techniques to detect suspicious system behaviour, provides contextual information, blocks malicious activity, and provides remediation suggestions to restore affected systems.”*

The following section is work in progress as it is a solution that will not be replaced and I have yet to face on in a CTF or in a workplace setting to make simplified, compressed communicable information about EDR with legitimate working knowledge. 

- Near Real-Time Monitoring 
	- Use behaviour rules or threat intelligence for hunting indicators of attack. 
- Collection of activity data from endpoints
	- Telemetry data points
	- Storage of data on endpoints
- Analyse data for Threats
	- Aggregation of data on an endpoint
	- Search for Indicators of compromise
- Alert security personnel

[THM Aurora Room](https://tryhackme.com/room/auroraedr) describes EDRs broadly to haver the following components... 
EDR vendors would classify their capabilities differently. However, the following are the common classifications:
-   **Detection:** Fundamentally, EDR solutions are tasked with threat detection. For example, with file analysis, EDRs can flag suspicious files at the sight of any malicious behaviour. The detection process is also based on how good the threat intelligence sources are.
-   **Response/ Containment:** EDRs provide response features that help investigate, detect, remediate and contain threats. The actions here include host segmentation, file deletion/cleanup and conducting investigations through sandboxing conditions. Advanced EDR solutions have the capability to trigger an automated response based on a set of preconfigured rules.
-   **Integration:** EDRs extend endpoint visibility through the collection and aggregation of data. Therefore, in addressing endpoint security, EDR solutions need to work smoothly with existing security solutions in an organisation.
-   **Insights:** Real-time analysis of events is becoming very common, providing a rapid evaluation and correlation of threat data. Through complex machine learning and artificial intelligence algorithms, EDR solutions can automate threat identification and perform behavioural analysis, mapping them to frameworks such as the MITRE ATT&CK.
-   **Forensics:** In-depth investigation of past threats provides valuable information on the inner workings of exploits and how a breach was successful. With this, EDR solutions can outline threat timelines and identify lurking threats that go undetected.

## Open Source EDRs

Vendors will be vendors and have there own marketing teams and budgets, for those learning or not a massive enterprise Open Source EDR exist. 

https://www.ossec.net/
https://github.com/ComodoSecurity/opened
https://www.rapid7.com/products/velociraptor/
- https://velociraptor.velocidex.com/
https://wazuh.com/

## References

[Crowdstrike - What is Endpoint Detection and Response (EDR)?](https://www.crowdstrike.com/cybersecurity-101/endpoint-security/endpoint-detection-and-response-edr/)
[Black Hills - Open Source and Free EDR](Open Source and Free EDR)
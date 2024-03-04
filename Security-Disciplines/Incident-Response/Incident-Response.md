# Incident Response

More commonly as of 2020s referred to as the [[Purple-Team]], Incident Response is a major role where you are expected to end the breaches and remediate disasters.
- Preparation
- Detection and Analysis 
- Containment, Eradication and Remediation
- Post-Incident activities

## IR and IM

The primary objective is ascertain the scope of incident, otherwise incident management process will not be sufficient in response to totality of the incident.  

Incidents start as:
- [[EDR]] Alerts
- [[Anti-Virus]] Alerts
- Network Tap Alerts
- Alerts from [[SIEM-Solutions]] 

Alerts may not be enough... [[Digital-Forensics]] may be deployed to:
- Recover Disks
- Recover volatile memory - [[Memory-Forensics]]
- [[Log-Analysis]] of System and Network [[Logs]]
- [[Phishing-Email-Header-Analysis]]

Incident Management
- Documenting the incident
- Triaging to assess the incident severity (cyclic to informational update)
- Communications between teams (as these may be monitored by adversary)
- Containment
- Eradication
- Recovery
- Using and guiding a team through a Playbooks (known battle-tested tactics) 
- Closing the incident

Level 1: SOC Incident
Level 2: CERT Incident
Level 3: CSIRT Incident
Level 4: CMT Incident

NIST's [SP-800-61 Incident Handling guide](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-61r2.pdf)

1.  Preparation
2.  Detection and Analysis
3.  Containment, Eradication, and Recovery
4.  Post-incident Activity

SANS's [Incident Handler's handbook](https://www.sans.org/white-papers/33901/):

1.  Preparation  
2.  Identification
3.  Containment
4.  Eradication
5.  Recovery
6.  Lessons Learned


## References

[THM DFIR Room](https://tryhackme.com/room/introductoryroomdfirmodule)
[THM Intro to IR and IM](https://tryhackme.com/room/introtoirandim)
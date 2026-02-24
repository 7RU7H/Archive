# Incident Response

More commonly as of 2020s referred to as the [[Purple-Team]], Incident Response is a major role where you are expected to end the breaches and remediate disasters.
- Preparation
- Detection and Analysis 
- Containment, Eradication and Remediation
- Post-Incident activities

## Preparation

Three pillars of SOC People, Process, Technology

## IR and IM

The primary objective is ascertain the scope of incident, otherwise incident management process will not be sufficient in response to totality of the incident.  

- Incident Response is determining what happened
- Incident Management is how to deal with it


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

Level 1: SOC Incident - not normally classified as incidents
- SOC analyst is alerted, investigates the issues and then modifies security posture 
Level 2: Computer Emergency Readiness Team (CERT) Incident
- Additional investigation to determine scope
- Investigate any user interaction, if malware and user interaction is found then the invocation of a CSIRT Incident 
Level 3: Computer Security Incident Response Team (CSIRT) incident
- Entire SOC will focus on the incident
- Analysts and Forensics teams will investigate the full scope of the incident - if the investigation find the scope is larger it will be elevated to a CMT incident
- Management will take action against the threat actor
Level 4: Crisis Management Team (CMT) Incident
- Involvement of several key stakeholders
#### IR Roles

[THM Intro to IR and IM](https://tryhackme.com/room/introtoirandim)

|   |   |
|---|---|
|**Role**|**Description**|
|SOC Analyst|A SOC analyst is a person that deals with the various events and alerts that happen in the SOC. There are usually different levels of analysts. Ultimately, analysts are usually some of the first members that would get involved in dealing with an incident.|
|SOC Lead|The SOC lead, also called the SOC Manager or Head of SOC, is responsible for dividing the tasks in the SOC and deciding to escalate an alert to the level of incident. Usually, the SOC manager understands the technical information required to perform an investigation to better help them divide the different tasks during an incident.|
|Forensic Analyst|A forensic analyst is a person that performs an investigation to better understand what happened during an incident. This is often digital forensics that must be investigated by reviewing artefacts such as the memory or hard drive of a device.|
|Malware Analyst|A malware analyst is a forensic analyst who focuses on understanding how the malware works. These analysts often have significant technical capabilities to debug and decompile malware to understand how it works. These analysts often help to uncover Indicators of Compromise (IoCs) that are signatures of the malware that can be used to identify the malware in the environment.|
|Threat Hunter|A threat hunter is a person that actively tries to uncover new threats in the environment. The goal of threat hunting is to try and create new alert rules based on information available in logs and other sources. By performing threat hunting, an alert would be generated that could help the team discover an attacker that attempted to use the same technique.|
|First Responder|In certain cases, it isn't actually the SOC that is first alerted to an incident. Often, a cyber incident could have started as a business incident. For example, a product team discovers that their application has slowed down and isn't responding as it should. In these cases, that team becomes the First Responders to the incident. While they would not be expected to deal with the entire incident by themselves, there are some key steps that first responders should take to ensure that they don't compromise information that will be required to better understand the cyber incident.|
|Security Engineer|While security engineers are not directly involved with the SOC, they can often be involved in incidents. Security engineers are responsible for the security of their division, application, or system. In the event that there is an incident in their area, they will often be relied upon as a subject matter expert to aid in the investigation. Furthermore, security engineers will often work closely with the SOC to ensure that the SOC is receiving log information from their division.|
|Information Security Officer|Similar to a security engineer, an information security officer (ISO) is responsible for the security of their division. However, this is usually more management focussed than technical, such as security engineers. ISOs are also often involved in incidents as subject matter experts and responsible for acting as the bridge between the Incident Response team and their division team that will have to implement the actions provided by the Incident Manager.|
|Incident Manager|An incident manager is a person that was trained in performing the management duties for Incident Response and Management. Incident Managers have to be exceptional in note-taking and organised to ensure that everything during an incident is properly documented and that the processes are followed.|
|Project Owner|A product owner is usually the person that takes the lead during the development of a solution. In the past, with the waterfall method, products were only released after they were fully completed. However, today, using Agile processes, products are released and continuously updated. As such, since a version of the project is already live as the team is still performing development, incidents can already occur. In the event of an incident, the product owner is often called in as a subject matter expert to help with the investigation.|
|Subject Matter Expert|The blue team cannot be expected to be experts in every single technology or system. As such, Subject Matter Experts (SMEs) are often relied upon based on the specific incident at hand. For example, if, in the incident, Active Directory has been compromised, one of the Domain Admins could be called in as an SME. SMEs are often relied on to provide more information that allows the blue team to better understand the incident scope and what potential actions can be taken against the threat actors.|
|Crisis Manager|A crisis manager is the lead for the crisis management team. This is usually an executive such as the CIO or COO. This person is responsible for ensuring that the CMT functions as they should and can deal with the crisis.|
|Executive|In the event that an incident is sufficiently severe, executives of a company will be involved in the CMT. This includes the CEO, COO, CIO, CTO, and CISO.|

NIST's [SP-800-61 Incident Handling guide](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-61r2.pdf)

1.  Preparation
	- Identify key stake holders and call trees (list of people to call that are responsible accounting for absence)
	- Create and update Response playbooks
	- Exercises for teams
	- Continuous [[Threat-Hunting]] to create new alert rules 
1.  Detection and Analysis
	- Review alerts
	- Perform a [[Digital-Forensics]] investigation
	- Perform [[Malware-Analysis]]
1.  Containment, Eradication, and Recovery
	- Contain the problem
	- Eradicate the problem
	- Recover and return to Business as Usual
1.  Post-incident Activity
	- Evaluation

SANS's [Incident Handler's handbook](https://www.sans.org/white-papers/33901/):

1.  Preparation  
2.  Identification
3.  Containment
4.  Eradication
5.  Recovery
6.  Lessons Learned

#### Common Pitfalls

- Insufficient Hardening
- Insufficient Logging
- Insufficient- and Over-Alerting
- Insufficient Determination of Incident Scope
- Insufficient Backups

## References

[THM DFIR Room](https://tryhackme.com/room/introductoryroomdfirmodule)
[THM Intro to IR and IM Room](https://tryhackme.com/room/introtoirandim)
[THM Preparation Room](https://tryhackme.com/room/preparation)

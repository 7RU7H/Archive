# Logs

Logs are computer generated data that is recorded into a file in tabular structure and commonly have the file extension `.log`. The act of [Logging](https://en.wikipedia.org/wiki/Logging_(computing)): *logging is the act of keeping a [log](https://en.wiktionary.org/wiki/log#Etymology_2 "wikt:log") of [events](https://en.wikipedia.org/wiki/Event_(computing) "Event (computing)") that occur in a computer system, such as problems, errors or just information on current operations.* [THM Room - Intro to Logs](https://tryhackme.com/room/introtologs): *These records provide a detailed account of what a system has been doing, capturing a wide range of events such as user logins, file accesses, system errors, network connections, and changes to data or system configurations.*

[THM Intro to Log analysis](https://tryhackme.com/room/introtologanalysis) states the importance of logs:
- **System Troubleshooting**: Analyzing system errors and warning logs helps IT teams understand and quickly respond to system failures, minimizing downtime, and improving overall system reliability.
- **Cyber Security Incidents:** In the security context, logs are crucial in detecting and responding to security incidents. Firewall logs, intrusion detection system (IDS) logs, and system authentication logs, for example, contain vital information about potential threats and suspicious activities. Performing log analysis helps SOC teams and Security Analysts identify and quickly respond to unauthorized access attempts, malware, data breaches, and other malicious activities.
- **Threat Hunting:** On the proactive side, cyber security teams can use collected logs to actively search for advanced threats that may have evaded traditional security measures. Security Analysts and Threat Hunters can analyse logs to look for unusual patterns, anomalies, and indicators of compromise (IOCs) that might indicate the presence of a threat actor.
- **Compliance:** Organizations must often maintain detailed records of their system's activities for regulatory and compliance purposes. Regular log analysis ensures that organizations can provide accurate reports and demonstrate compliance with regulations such as GDPR, HIPAA, or PCI DSS.

[Crowdstrike's](https://www.crowdstrike.com/cybersecurity-101/observability/log-file/) Basic anatomy of a log file:
- **The timestamp** – the exact time at which the event logged occurred
- **User information**
- **Event information** – what was the action taken

Contextual Correlation is about understanding the situation and how events are connected. The log data is analysed, aggregated, and is cross-referenced. Similar for [[Question-Based-Penetration-Testing-Methodology]], a [[Question-Based-DFIR-Methodology]] very general categorises around asking questions:
- **What** happened?
- **When** did it happen?
- **Where** did it happen?
- **Who** is responsible?
- **Were** their actions **successful**?
- **What** was the result of their action?


#### Relate Pages By Topic

Linux related - [[Linux-Logging]]
Windows related - [[ETW]]
Blue Team and DFIR related - [[Log-Analysis]]
Web application hacking -[[Log-Poisoning]]
Red teaming - [[Logging-And-Monitoring-Evasion]]
## Typology 

- **Application Logs:** Messages about specific applications, including status, errors, warnings, etc.
- **Audit Logs:** Activities related to operational procedures crucial for regulatory compliance.
- **Security Logs:** Security events such as logins, permissions changes, firewall activity, etc.
- **Server Logs:** Various logs a server generates, including system, event, error, and access logs.
- **System Logs:** Kernel activities, system errors, boot sequences, and hardware status.
- **Network Logs:** Network traffic, connections, and other network-related events.
- **Database Logs:** Activities within a database system, such as queries and updates.
- **Web Server Logs:** Requests processed by a web server, including URLs, response codes, etc.

## Formats

- Semi-Structured Logs
	- Syslog Message Format:
		- A widely adopted logging protocol for system and network logs.
	- Windows Event Logs (EVTX) Format - [[ETW]]:
		- Proprietary Microsoft log for Windows systems.
#### Structure Logs
	
- Field Delimited Formats
	- Comma-Separated Values (CSV) and Tab-Separated Values (TSV) are formats often used for tabular data.
- JavaScript Object Notation ([[JSON]])
	- Known for its readability and compatibility with modern programming languages.
- W3C Extended Log Format (ELF)
	- Defined by the World Wide Web Consortium (W3C), customisation for web server logging. It is typically used by Microsoft Internet Information Services (IIS) Web Server.
- eXtensible Markup Language (XML)
	- Flexible and customisation for creating standardised logging formats.
#### Unstructured Logs:

Comprising free-form text, these logs can be rich in context but may pose challenges in systematic parsing.
- NCSA Common Log Format (CLF)
	- A standardised web server log format for client requests. It is typically used by the Apache HTTP Server by default.
- NCSA Combined Log Format (Combined)
	- An extension of CLF, adding fields like referrer and user agent. It is typically used by Nginx HTTP Server by default.

## Log Standards

- [Common Event Expression (CEE):](https://cee.mitre.org/) 
	- This standard, developed by MITRE, provides a common structure for log data, making it easier to generate, transmit, store, and analyse logs.
- [OWASP Logging Cheat Sheet:](https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html)
	- A guide for developers on building application logging mechanisms, especially related to security logging.
- [Syslog Protocol:](https://datatracker.ietf.org/doc/html/rfc5424) 
	- Syslog is a standard for message logging, allowing separation of the software that generates messages from the system that stores them and the software that reports and analyses them.
- [NIST Special Publication 800-92:](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-92.pdf) 
	- This publication guides computer security log management.
- [Azure Monitor Logs:](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/data-platform-logs) 
	- Guidelines for log monitoring on Microsoft Azure.
- [Google Cloud Logging:](https://cloud.google.com/logging/docs) 
	- Guidelines for logging on the Google Cloud Platform (GCP).
- [Oracle Cloud Infrastructure Logging:](https://docs.oracle.com/en-us/iaas/Content/Logging/Concepts/loggingoverview.htm) 
	- Guidelines for logging on the Oracle Cloud Infrastructure (OCI).
- [Virginia Tech - Standard for Information Technology Logging:](https://it.vt.edu/content/dam/it_vt_edu/policies/Standard_for_Information_Technology_Logging.pdf) 
	- Sample log review and compliance guideline.
## Log Collection

- **Identify Sources:** List all potential log sources, such as servers, databases, applications, and network devices.
- **Choose a Log Collector:** Opt for a suitable log collector tool or software that aligns with your infrastructure.
- **Configure Collection Parameters:** Ensure that time synchronisation is enabled through NTP to maintain accurate timelines, adjust settings to determine which events to log at what intervals, and prioritise based on importance.
- **Test Collection:** Once configured, run a test to ensure logs are appropriately collected from all sources.
#### Log Management

- **Storage:** Decide on a secure storage solution, considering factors like retention period and accessibility.
- **Organisation:** Classify logs based on their source, type, or other criteria for easier access later.
- **Backup:** Regularly back up your logs to prevent data loss.
- **Review:** Periodically review logs to ensure they are correctly stored and categorised.

#### Log Centralisation

- **Choose a Centralised System:** Opt for a system that consolidates logs from all sources, such as the Elastic Stack or Splunk.
- **Integrate Sources:** Connect all your log sources to this centralised system.
- **Set Up Monitoring:** Utilise tools that provide real-time monitoring and alerts for specified events.
- **Integration with Incident Management:** Ensure that your centralised system can integrate seamlessly with any incident management tools or protocols you have in place.
## Log Storage

Storage Location Choice:
- **Security Requirements:** Ensuring that logs are stored in compliance with organisational or regulatory security protocols.
- **Accessibility Needs:** How quickly and by whom the logs need to be accessed can influence the choice of storage.
- **Storage Capacity:** The volume of logs generated may require significant storage space, influencing the choice of storage solution.
- **Cost Considerations:** The budget for log storage may dictate the choice between cloud-based or local solutions.
- **Compliance Regulations:** Specific industry regulations governing log storage can affect the choice of storage.
- **Retention Policies:** The required retention time and ease of retrieval can affect the decision-making process.
- **Disaster Recovery Plans:** Ensuring the availability of logs even in system failure may require specific storage solutions.

Log Retention is platform defined time scales that are defined in a range by temperature and in some cases like [[Azure-Administration-Log-Analytics]] Archival. These scales are defined by frequency of required access and the hotter the storage the requirement for fast query speeds.

Log Deletion
- Maintain a manageable size of logs for analysis.
- Comply with privacy regulations, such as GDPR, which require unnecessary data to be deleted.
- Keep storage costs in balance.

Best Practices:
- Determine the storage, retention, and deletion policy based on both business needs and legal requirements.
- Regularly review and update the guidelines per changing conditions and regulations.
- Automate the storage, retention, and deletion processes to ensure consistency and avoid human errors.
- Encrypt sensitive logs to protect data.
- Regular backups should be made, especially before deletion.

## References

[Wikipedia - Logging (computing)](https://en.wikipedia.org/wiki/Logging_(computing))
[Wikipedia - log](https://en.wiktionary.org/wiki/log#Etymology_2 "wikt:log")
[Wikipedia - events](https://en.wikipedia.org/wiki/Event_(computing) "Event (computing)") 
[THM Room - Intro to Logs](https://tryhackme.com/room/introtologs)
[Crowdstrike - Log file](https://www.crowdstrike.com/cybersecurity-101/observability/log-file/)
[Virginia Tech - Standard for Information Technology Logging](https://it.vt.edu/content/dam/it_vt_edu/policies/Standard_for_Information_Technology_Logging.pdf) 
[Oracle Cloud Infrastructure Logging](https://docs.oracle.com/en-us/iaas/Content/Logging/Concepts/loggingoverview.htm)
[Google Cloud Logging](https://cloud.google.com/logging/docs)
[Azure Monitor Logs](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/data-platform-logs)
[NIST Special Publication 800-92](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-92.pdf)
[Syslog Protocol:](https://datatracker.ietf.org/doc/html/rfc5424)
[OWASP Logging Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html)
[Common Event Expression (CEE):](https://cee.mitre.org/)
[THM Intro to Log analysis](https://tryhackme.com/room/introtologanalysis) 
# Auditing And Monitoring

## Definitions and Disambiguation

[Auditing](https://en.wikipedia.org/wiki/Audit_(disambiguation) *"is the independent evaluation of an organisation, process, project, product or system."*

Monitoring is catch all term of the capturing of data for analysis to determine the state of some computational system(s): 
- [Application performance management](https://en.wikipedia.org/wiki/Application_performance_management), also called application performance monitoring, monitoring and management of performance and availability of software applications
- [Event monitoring](https://en.wikipedia.org/wiki/Event_monitoring "Event monitoring"), process of collecting, analysing, and signalling event occurrences to subscribers such as operating system processes, active database rules as well as human operators
- [Business transaction management](https://en.wikipedia.org/wiki/Business_transaction_management "Business transaction management"), also called business transaction monitoring, managing information technology from a business transaction perspective
- [Network monitoring](https://en.wikipedia.org/wiki/Network_monitoring "Network monitoring"), systems that constantly monitors a computer network for slow or failing components and that notifies the network administrator
- [System monitoring](https://en.wikipedia.org/wiki/System_monitoring "System monitoring"), a process within a distributed system for collecting and storing state data
- [User activity monitoring](https://en.wikipedia.org/wiki/User_activity_monitoring "User activity monitoring"), the process of recording user input
- [Website monitoring](https://en.wikipedia.org/wiki/Website_monitoring "Website monitoring"), the process of testing and verifying that end-users can interact with a website or web application as expected.

## Audit Typology and Objectives  

Typology
- Internal Audit - organisation's personnel conduct the audit 
- External Audit - independent auditors conduct the audit 
- Third-party audits - Audits of third parties

- Primary Objectives
	- Assess the effectiveness of internal controls
	- Identify and assess risks
	- Assess the efficiency and effectiveness of information systems
	- Ensure compliance with laws and regulations
- Formal
	- Risk assessment
	- Regulatory compliance
	- IT governance
	- Security management
	- Operational and performance evaluation
	- Data management and quality
	- Business continuity and disaster recovery
	- Fraud detection and prevention

|Framework|Description|Industries|Notes|
|---|---|---|---|
|COSO|[Internal Control-Integrated Framework](https://www.coso.org/sitepages/internal-control.aspx) that helps organisations design, implement, and monitor their internal controls.|All industries|COSO is a comprehensive framework that covers all aspects of internal control.|
|COBIT| The [Control Objectives for Information and Related Technology](https://www.isaca.org/resources/cobit) create ISACA is an IT governance framework that helps organisations align their IT with their business goals.|All industries|COBIT is a flexible framework that can be adapted to the needs of any organisation.|
|[ISAE3402](https://isae3402.com/ISAE3402_overview.html)|Assurance standard that provides assurance on the controls of a service organisation.|All industries|ISAE 3402 is a relatively new standard gaining popularity in the financial services industry.|
|[ISO 27001](https://www.iso.org/standard/27001)|Information security management system (ISMS) standard that helps organisations protect their information assets.|All industries|ISO 27001 is the world’s most widely adopted ISMS standard.|
|[ITIL](https://en.wikipedia.org/wiki/ITIL)|IT service management (ITSM) framework, created by UK Government's [Central Computer and Telecommunications Agency](https://en.wikipedia.org/wiki/Central_Computer_and_Telecommunications_Agency "Central Computer and Telecommunications Agency") (CCTA), which helps organisations deliver high-quality IT services.|All industries|ITIL is a well-established framework that organisations of all sizes use.|
|PCI DSS|[Payment Card Industry Data Security Standard](https://www.pcisecuritystandards.org/document_library/?document=pci_dss) that helps organisations protect cardholder data.|Financial services|PCI DSS is a mandatory standard for organisations that process credit and debit card payments.|
|SOX|Sarbanes-Oxley Act that sets requirements for internal controls over financial reporting.|Publicly traded companies|SOX is a complex law that has a significant impact on public companies.|

## Audit Process

Stages:
- Planning
- Information gathering
- Risk assessment and control evaluation
- Testing
- Analysis and findings
- Reporting
- Follow-up

Audit Areas: 
- Information Systems hardware
- OS
- File System
- Database Management Systems
- Network Operations Controls
- IT Operating Controls
- Lights-Out Operations
- Problem Management Operations
- Monitoring Operations
- Procurement
- Business Continuity Planning
- Disaster Recovery Planning
## Log Management

Logging provides a historical account of events for later analysis or audit review; it is essential for diagnostic, forensics, and compliance purposes. Logging is a form of data collection and a record-keeping activity, which can be processed and used to understanding and improve situations. 

General Strategy:
- Log to a central location
- Use a tool to filter and parse the logs
- Setup alerts

[[Linux-Logging]]
[[Windows-Logging]]

## Monitoring

Monitoring is a real-time, continuous process used to detect issues or anomalies immediately. Monitoring attempt to ensure effective operational control, security, and optimal performance.

Importance:
- Troubleshooting 
- Maintenance
- Performance Optimisation
- Preventing Failures
- Security Risk Mitigation
- Regulatory Compliance

[[SIEM-Solutions]] can provide the answer to some large scale monitoring technical requirements. Security Information and Event Management (SIEM) is a set of integrated management technologies that aim to provide a holistic view of an organisation’s information security. SIEM systems collect and aggregate log data generated throughout the organisation’s IT infrastructure from network devices, systems, and applications. Its capabilities include:
- Data aggregation - automates the collection and management of data 
- Potential Correlation - Correlation does not equal causation
- Analytic tooling - Humans still have to do the analysis
	- Forensic Analysis - processing data to help analysts analyses more effectively with historical analysis 
	- Threat Intelligence - integrating intelligence feeds 
- Automating and Orchestration - some SIEMs can automatically respond to some detected incidents 

## References

[THM Auditing and Monitoring Room](https://tryhackme.com/room/auditingandmonitoringse)
[Wikipedia Audit (disambiguation)](https://en.wikipedia.org/wiki/Audit_(disambiguation))
[Application performance management](https://en.wikipedia.org/wiki/Application_performance_management "Application performance management")
[Event monitoring](https://en.wikipedia.org/wiki/Event_monitoring)
[Business transaction management](https://en.wikipedia.org/wiki/Business_transaction_management "Business transaction management")
[Network monitoring](https://en.wikipedia.org/wiki/Network_monitoring "Network monitoring")
[System monitoring](https://en.wikipedia.org/wiki/System_monitoring "System monitoring")
[User activity monitoring](https://en.wikipedia.org/wiki/User_activity_monitoring "User activity monitoring")
[Website monitoring](https://en.wikipedia.org/wiki/Website_monitoring "Website monitoring")
[Internal Control-Integrated Framework](https://www.coso.org/sitepages/internal-control.aspx)
[Control Objectives for Information and Related Technology](https://www.isaca.org/resources/cobit)
[ISAE3402](https://isae3402.com/ISAE3402_overview.html)
[ISO 27001](https://www.iso.org/standard/27001)
[Wikipedia ITIL](https://en.wikipedia.org/wiki/ITIL)
[Payment Card Industry Data Security Standard](https://www.pcisecuritystandards.org/document_library/?document=pci_dss)
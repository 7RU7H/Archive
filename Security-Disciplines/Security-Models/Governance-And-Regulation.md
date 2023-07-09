# Governance And Regulation

## Introduction

Probably for the foreseeable future this article will be a summarised and additive version of [THM Governance & Regulation Room](https://tryhackme.com/room/cybergovernanceregulation), where either rewording for ease of understanding or compression to reduce bloat is the main goal. Additive information from other sources to expands and improves on simplify and summarised information will built in over time. The rationale for this decision is that this documentation is verbose for practical legal implementations and learning it is valuable but time consuming and maybe unnecessary to absolute fluent in, but still valuable to understand.  

#### Introductory Glossary 

- Compliance: 
	- Adherence to the local or regional laws, regulations and standards that apply organisation or system
- Governance: 
	- Managing and directing an organisation or system to achieve its objectives and ensure compliance with laws, regulations, and standards
- Information Security Frameworks:
	- Policies: 
		- A formal statement that outlines an organisation's goals, principles, and guidelines for achieving specific objectives.
	- Standards: 
		- A document establishing specific requirements or specifications for a particular process, product, or service.
	- Guidelines: 
		- A document that provides recommendations and best practices (non-mandatory) for achieving specific goals or objectives.
	- Procedures: 
		- Set of specific steps for undertaking a particular task or process.
	- Baselines: 
		- A set of minimum security standards or requirements that an organisation or system must meet.
- Regulation: 
	- A rule or law enforced by a governing body to ensure compliance and protect against harm


## Effective Governance

Cyber Security Governance - from [THM Governance & Regulation Room](https://tryhackme.com/room/cybergovernanceregulation); and Effective Governance - from [NCSC.gov.uk - Cyber security Governance](https://www.ncsc.gov.uk/collection/risk-management/cyber-security-governance)
- Strategy:
	- Aligns overall organisation objectives
	- Delegate decision making
	- Develop an effective culture and environment
	- Communicate risk management information effectively
	- Deal with complexity and uncertainty
	- [Quote](https://www.ncsc.gov.uk/collection/risk-management/cyber-security-governance): *this uncertainty is exacerbated by:
		- *the biases of those involved in risk analysis, assessment and decision making processes*
		- *limitations in available risk management skills and experience*
		- *limitations in methods and tools, and they way they are used*
	- *...those responsible for making decisions need to:* 
		- *understand the limitations of the methods, approaches and tools they are using*
		- *understand that there are contexts when risks can be managed through the implementation of predefined security controls and approaches, and contexts when they cannot*
		- *adopt different strategies for making sensible security risk management decisions in different contexts*
- Policies and procedures:
	- Preparing policies and procedures that govern the use and protection of information assets.
	- Explanation and example through real-world scenarios communicated in both technical and non-technical - impact based on organisation's role that you are communicating it too; for example:
		- CEO - How much money would this cost if we did not comply be a Law and were found negligent in protecting customer data both from fines and in reputation with clients. 
	- Incident Response Procedures - [[Incident-Response 1|Incident-Response 1]]
- Risk Management:
	- Conduct risk assessments
	- Implement risk mitigation measures
	- Investment in risk management, trust in decision makers
- Performance measurement:
	- Establishing metrics
	- Key performance Indicator (KPIs)
- Compliance:
	- Ensuring compliance with relevant regulations and industry best practice


#### Benefits of effective Governance

- More robust security posture
- Increased stakeholder confidence
- Regulatory compliance
- Better alignment with organisation objective
- Informed decision-making
- Competitive advantage

#### Developing Governance Documentation

- Identity the scope and purpose
- Research and review
- Draft the document
- Review and approval
- Implementation and communication
- Review and update

## Relevant Laws and Regulation in Information Security

[THM Governance & Regulation Room](https://tryhackme.com/room/cybergovernanceregulation) "*Information security regulation refers to legal and regulatory frameworks that govern the use and protection of information assets. Regulations are designed to protect sensitive data from unauthorised access, theft, and misuse. Compliance with regulations is typically mandatory and enforced by government agencies or other regulatory bodies.*"

|   |   |   |
|---|---|---|
|**Law/Regulation**|**Domain**|**Description**|
|General Data Protection Regulation (GDPR)|Data Privacy & Protection|GDPR is a regulation propagated by the European Union that sets strict requirements for how organisations handle and protect and  secure the personal data of EU citizens and residents.|
|Health Insurance Portability and Accountability Act (HIPAA)|Healthcare|A US-based official law to maintain the sensitivity of health-related information of citizens.|
|Payment Card Industry Data Security Standard (PCI-DSS)|Financial|Set technical and operational requirements to ensure the secure handling, storage, processing, and transmission of cardholder data by merchants, service providers, and other entities that handle payment cards.|
|Gramm-Leach-Bliley Act (GLBA)|Financial|Financial companies must be sensitive to their customers' nonpublic personal information (NPI), including implementing information security programs, providing privacy notices, and disclosing information-sharing practices.|
From - [THM Governance & Regulation Room](https://tryhackme.com/room/cybergovernanceregulation)

## Governance Risk and Compliance (GRC)

- Governance component
	- guiding an organisation by directing:
		- information security strategy
			- policies
			- standards
			- baselines
			- frameworks
- Risk Management component 
	- identifying, assessing, and prioritising risks
	- implementing controls and mitigation strategies
- Compliance component
	- Ensuring an organisation:
		- meets its legal, regulatory, and industry obligations 
		- ...and its activities align with its policies and procedures

Developing GRC program
- Define the scope and objective
- Conduct a risk assessment
- Develop policies and procedures
- Establish governance processes
- Implement controls
- Monitor and measure performance
- Continuously improve

## Data and Privacy Protection

#### General Data Protection Regulation (GDPR)

The [THM Governance & Regulation Room](https://tryhackme.com/room/cybergovernanceregulation) summarises the [GDPR](https://gdpr-info.eu/) as a data protection law implemented by the European Union on May 2018 to protect personal data. Personal data is "_Any data associated with an individual that can be utilised to identify them either directly or indirectly_". Key points of the law include the following:  
-  Prior approval must be obtained before collecting any personal data.
-  Personal data should be kept to a **minimum** and only collected when necessary.
-  Adequate measures are to be adopted to protect stored personal data.

#### Payment Card Industry Data Security Standard (PCI DSS)

[PCI DSS](https://www.pcisecuritystandards.org/) is focused on maintaining secure card transactions and protecting against data theft and fraud. [PCI_DSS-QRG-v4_0 Document](https://docs-prv.pcisecuritystandards.org/PCI%20DSS/Supporting%20Document/PCI_DSS-QRG-v4_0.pdf)

## NIST special publications

National Institute of Standards and Technology (NIST), US, develops and provides a catalogue of security controls to protect the CIA triad of information systems. They publish a framework of assessments and augmentation for organisations to act on.

- [NIST 800-53](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf) is a publication titled "Security and Privacy Controls for Information Systems and Organisations"
	- Control families
		- Administrative Controls
			- Audit and accountability
			- Awareness and Training
			- Configuration management
			- Contingency Planning
			- Incident Response
			- Maintenance
			- Program Management
			- Risk Assessment
			- Security Assessment and Authorisation
		- Technical Controls
			- Access Control
			- Identification and authentication
			- System and Communications Protection
			- System and Information integrity
			- System and Services Acquisition
			- System and Services Development
			- Program System and Services Development
		- Physical Controls
			- Personnel Security
			- Physical and Environmental
			- Media Protection 
		- Strategic Controls
			- Planning
	- Compliance Best Practices
		- Discovery and Classify
		- Map
		- Manage
		- Monitor
- NIST Special Publication 800-63B is a set of guidelines created by the NIST to help organisations establish effective digital identity practices.

## Information Security Management and Compliance

#### ISO/IEC 27001

**ISO 27001** is an internationally recognised standard for requirements to **plan, develop, run, and update** an organisation's Information Security Management System (ISMS). The official ISO/IEC 27001 documents are paid for and can be purchased from this [link](https://www.iso.org/standard/27001). It was developed by International Organisation for Standardisation (ISO) and the International Electrotechnical Commission (IEC) and has the following core components:
- **Scope**: This specifies the ISMS's boundaries, including the covered assets and processes.
- **Information security policy**: A high-level document defining an organisation's information security approach.
- **Risk assessment**: Involves identifying and evaluating the risks to the confidentiality, integrity, and availability of the organisation's information.
- **Risk treatment**: Involves selecting and implementing controls to reduce the identified risks to an acceptable level.
- **Statement of Applicability (SoA)**: This document specifies which controls from the standard are applicable and which are not.
- **Internal audit**: This involves conducting periodic audits of the ISMS to ensure that it is operating effectively.
- **Management review**: Review the performance of ISMS at regular intervals.

#### Service Organisation Control 2 (SOC 2)

[**SOC 2**](https://soc2.co.uk/) was developed by the American Institute of Certified Public Accountants (AICPA) as a **compliance/auditing framework**.

SOC 2 Important Cardinals are about the quality of humans auditing, auditing the audit and report quality in finding and recommendations:
- SOC 2 is an auditing standard that evaluates the usefulness of a service organisation's controls related to confidentiality, availability, integrity, and privacy.
- Independent auditors conduct SOC 2 audits to determine that security controls meet the relevant criteria.
- SOC 2 reports provide valuable information to customers, stakeholders, and regulators on a service organisation's security and privacy practices. 
- The SOC 2 audit report will assess the controls in place at the cloud computing company and include any findings or recommendations for improvement.

Generic controls:
- Security
- Availability
- Processing integrity
- Confidentiality
- Privacy

Planning and Undergoing a SOC 2 Audit
- Determine the scope
- Chose a suitable auditor
- Plan a audit
- Prepare for the audit
- Conduct the audit
- Receive the audit report


## References

[THM Governance & Regulation Room](https://tryhackme.com/room/cybergovernanceregulation)
[NCSC.gov.uk - Cyber security Governance](https://www.ncsc.gov.uk/collection/risk-management/cyber-security-governance)
[GDPR](https://gdpr-info.eu/)
[PCI DSS](https://www.pcisecuritystandards.org/)
[PCI_DSS-QRG-v4_0 Document](https://docs-prv.pcisecuritystandards.org/PCI%20DSS/Supporting%20Document/PCI_DSS-QRG-v4_0.pdf)
[NIST 800-53](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf) 
[SOC 2](https://soc2.co.uk/)
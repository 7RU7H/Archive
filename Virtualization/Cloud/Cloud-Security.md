# Cloud Security 

 Remember `Risk = Likelihood * Impact`. 



## Concepts of Cloud and Cloud Security

#### Characteristics in relation to security
The characteristics of the Cloud are:
- Scaliable - Save money, no excess resources 
- Simple - Templates, Digital Compliance models
- Cost Effective - Hub network architectures with security solutions for data in transit and rest
- Enhances Automation - Reduces human error and automates compliance to regulation more easily  
- Asset and Budget Mappable - IT has a diagram of what have and how much everything is costing!
- Hybrid Cloud to segregate - Solutions to manage
- Secure Segregation models - segregate host machines from AWS or Azure customers

#### Data types
- Confidential
- Internal
- Public

#### Cloud Data Life-cycle
- Create/Update
	- Implement SSL/TLS
	- Encryption at rest
	- Encryption in transit
	- Permission restrictions - Who owns, can modify resources and data?
- Store
	- Encryption at rest
	- Backup
	- Permission restrictions - Who owns or can store data?
	- Disaster Recovery 
- Use
	- Encryption in transit
	- Secure connections
	- Secure platform
	- Permission restrictions - Who owns, can access - read and write data?
	- Secure Virtualisation - Cloud Model on shared hosts
- Share
	- Jurisdiction
	- Data Loss Prevention
	- Permission restrictions - Who owns, can access and can modify data 
- Archive
	- Encryption at rest
	- Physical Security 
	- Location - physical location of storage
	- Backup Procedure
	- Disaster Recovery 
- Destroy
	- Secure destruction


## Security Issues, Risks in the Cloud

#### Global scoped issues

- Data confidentiality - Cloud service providers can access data without detection
- Data classification - is it too sensitive to host in the cloud?
- Insecure interfaces and API
- Malicious Insider - this even worse than one location as Cloud can have regional or global impact
- Account service hijacking
- Virtual Ownership - Virtual ownership as a role in resource management entire groups of resources from network to data and everything in between can be compromised due to hacking the owner of hierarchy of objects.  	  
- Access Control Mechanism - 

#### Risks per Cloud type

Private Cloud
- Personnel threats 
	- Cloud Provider Staff [[OSINT]]-ed and then threatened
	- Malicious insiders
	- Cloud provider vetting
- Natural disasters - *according to THM* - Geo-redundancy exists by the way...
- External attacks
	- Unauthorised access
	- [[MITM-Attacks]]
	- [[DDoS-Attacks]]

Public Cloud
- Vendor Lock-in: vendor dependency brings data moving costs and reduction in feasibility to move it    
- Threats of new entrants: your competitors may share the same provider 
- Escalation of Privilege Authorised

Community Cloud
- Vulnerability: 
	- One node falls others will too
	- Consensus on configuration, management, standards is potentially impossible
- Policy and administration
	- Enforcement of decisions and procedures are more difficult

## Security Through Management

Security management decision:
- Determine security level of organisation
- Options for high degree of security, potentially in stages
- Ask:
	- What does secure look like?
	- How to improve?
	- How to measure improvement?

- Cost management
   - aligning separate departments on business goals
- Security policy
   - cloud security items
   - compliance best practices
- Cloud governance committee
    - table of business executives from departments using cloud that meet for leadership, stakeholder representation

## Security Through Design

Organisation phases:
- road map planning - most org do not start in the cloud
- building foundation
- migration/deployment
- operations
- continuous optimisation

- Infrastructure architecture and protections
	- configuration management - focus on this!
	- image management - automate, check image sums(me)
	- cloud secure architecture - best practices, landing zone - grows back into automate
	- resource management - tag resources!
	- network controls - internal and external IP address, rented IP changes, geolocation fit network setup, user connection

## Security Through Data Specification

Data protections rely on decisions about what needs protect in the cloud and what should not be in the cloud at all...Then provide (more per *Security Through...* section): 
- Encryption 
- Classification and protection - visibility
- Backup and resilience

## Security Through Policy

- Identity-based
- Resource-based
- Session-based

## Security Through Access Management

Access Management - correct permissions for the correct account to correctly perform a task.  
- Create Identities - Template identities, make excepts exceptionally
- Authentication Factors
	- MFA at least, but always push for better for regular users - move away from password to passphrase and bad storage methods or passwords all together to something that what a user has to have together
		- But make it easy and not irritatating for the user! 
	- More powerful permissions require more oversight and less single point of failure human interaction: Big Federation-Level Own account requires - X people with Y regular authentication plus Account specific authorisation, not one person and one password to own your entire cloud.
- Roles: Policy and Organisation Structure should inform account Roles limited to that Role

IAM - Focus on and improve for success
- Identity management - user and machine - integration between federations and clouds
- Do not share passwords or account
- Segregation - permission hierarchy relative to organisation and B2B
- Access management 
	- multiplier of amount access control makes it difficult to perfect it
- Authorisation and Authentication systems that are MFA 
	- More is good in most cases
		- Do not make it irritating or difficult for genuine users attempts your user base will make find ways to make there life easier and your Cloud-System Administrator life hell. 
			- You provide a service not a challenge.
	- Just-in-Time  		  
- Workforce transformation

lam and Cloud security maturity framework
- understand current context 
- align with CMMI
- Visit - sans.org/posters/ciso-scorecard-cloud-maturity-model

## Security Through Network Management

Network Security Groups - Rule based management
- Defaults
- What resource to where and how

Virtual Security Solutions
- Gateways
	- VPN  
	- Load-balancers
	- Firewalls
	- DNS Firewalls
	- Application gateways

Connection between On-Premise and Cloud
- Cross-service credential management
- Cross domain access management


## Security Through Storage Management

Storage is not Archival (Backup) 

- Use or Create Geographical Boundaries
- Set Role-based Authorisation and Access though Policy
- Encryption at rest and in transit

## Security Through Monitoring and Logging

Good log management
- Centralised 
- Pushing for more than the default held time for logs

[[Azure-Administration-Azure-Monitor]]
- Azure Monitor Logs
- Azure Log Workspaces
- Azure Log Agent

[[AWS-Defined]] Logging:
- Identity & Access Management: Basic logging features related to access management, e.g. logs credential reports of user accounts.
- CloudTrail: Logs all API calls made to AWS resources.
- CloudWatch: Monitors the entire cloud infra and informs about applications status performance changes, ensuring better resource utilisation.
- GuardDuty: Ensures continuous monitoring of malicious activity and unauthorised behaviour.

## Security Through Backup Management


## Security Through Disaster Management


## Security Through Patching

[[Azure-Automation]] 
- Update Agent

AWS - Systems Manager

## Security Through Personnel Capabilities

- Workplace readiness - Training for cloud tech
    - skill readiness
    - organisation alignment

- [[Phishing]] Training

## Security Through Asset Management 
#### Pets and Cattle

[SANS Cloud Security - New Paradigms for Cloud Security: Keynote](https://www.youtube.com/watch?v=gX7OMC_qDjI)
- Pet versus Cattle - Should it be on the cloud
	- Fewest pets and most cattle

## References

[THM Intro TO Cloud Security](https://tryhackme.com/room/introductiontocloudsecurityc6)
[Cloud SANS Zero to Hero Talk](https://www.youtube.com/watch?v=Xfq0sTW7cp8)
[SANS Cloud Security - New Paradigms for Cloud Security: Keynote](https://www.youtube.com/watch?v=gX7OMC_qDjI)
# Cloud Security 




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

## Security Through Design

## Security Through Data Specification

## Security Through Policy

## Security Through Access Management

## Security Through Network Management

## Security Through Storage Management

## Security Through Monitoring and Logging

## Security Through Backup Management

## Security Through Disaster Management

## Security Through Patching



# MOVE BELOW

# Cloud SANS Zero to Hero

https://www.youtube.com/watch?v=Xfq0sTW7cp8

org phases:
roadmap planning - most org do not start in the cloud
building foundation
migration/deployment
operations
continuous optimisation

security management decision:
determine security level of org
options for high degree of security, potentially in stages

what does secure look like?
how to improve?
how to measure improvement?

lam and 
cloud security maturity framework

understand current context 
aligned with CMMI

sans.org/posters/ciso-scorecard-cloud-maturity-model

security domains

security goverance

org went cloud to go fast, but higher failure

cost management
    aligning seperate departments on business goals
security policy
    cloud security items
    compliance best practices
cloud governance commitee
    table of business executives from departments using cloud that meet for leadership, stakeholder representation

workplace readiness - training for cloud tech
     skill readiness
     organization alignment

infrastructure architecture and protections

configuration management - focus on this!
image management - automate, check image sums(me)
cloud secure architecture - best practices, landing zone - grows back into automate
resource management - tag resources!
network controls - internal and external ip address, rented ip changes, geolocatiom fit network setup, user connection


data protections

encryption
classification and protection - visibility
backup and resilience

security
security assurance
detection and response
app and workload protection


IAM - focus on
identity management - user and machine - integration between federations and clouds
segregation - permission hierarchy relstive to org
access management - multiplier of amount access control makes it difficult to perfect it.

workforce transformation


## References

[THM Intro TO Cloud Security](https://tryhackme.com/room/introductiontocloudsecurityc6)
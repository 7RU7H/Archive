# Penetration Testing

Objectives and goals should be determined by the client's data infrastructure and business model. The ultimate goal would be to reach hi ghest level of administrative access, although this is always required or necessary. This reason to state that it would be to accomplish this level of access is to because a breach of this kind would similiar has such a goal to obtain data or persistence to collect more data.

## Scoping and Phases

During a pentration test the tester goes back a forth from enumeration to exploitation. 
Scope defines what is boundaries of an assessment possible given that the objective is to assess a network. 

## Network Structuring

Depending the structuring 



## Public Network Enumeration
Starting with a external host resolvable through the DNS name the tester would enumeration network externally facing network to assess what internet facing services are vulnerable. In the how to be a [[How-To-Be-A-Better-PenTester]] some jobs require physical component to testing physical security while other can be a virtualised network that a team of testers can assess off client site.

Port scanners like [[Masscan-Cheatsheet]], [[Nmap-Cheatsheet]] or customised scanners are scripted to successful enumerating internal network from then on. Often webservers or phishing campaigns against the employees of a campaigns a common point of intrusion, although as it is always relative to the scope of assessment.

See [[Website-Recon]], [[Web-Hacking-Checklist]], [[Web-App-Hacking-Methodology]].
See [[Phishing]].

## Internal Network Enumeration

Due to [[Firewalls]], [[Intrusion-Detection-Systems]] and [[Intrusion-Prevention-Systems]] various testing is applied, often with custom tooling to stealthily assess the viable ways to bypass [[Port-Redirection-And-Tunneling]]. 

[[Active-Directory-Footholding]]


## Databases

[[Database-Hacking]]
1. Database software vulnerability RCEs on Database
1. Credentials on the Database

## Local host Enumeration
[[Windows-Privilege-Escalation-Enumeration]] and [[Linux-Privilege-Escalation]]
[[Active-Directory-Enumeration-Defined]]

## Local host Privilege Escalation
[[Active-Directory-Privilege-Escalation]], [[Windows-Privilege-Escalation-Vectors]]

## Persistence
[[Persistence]], [[Active-Directory-Persistence]], [[Linux-Persistence]] and [[Windows-Persistence]]
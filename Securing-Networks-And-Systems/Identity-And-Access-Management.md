# Identity And Access Management



## Identification, Authentication, Authorisation, and Accountability (IAAA)

Identification, Authentication, Authorisation, and Accountability (IAAA) are four pillars of information security. IAAA helps prevent unauthorised access, data breaches, and other security incidents, although is reliant of good implementation of each.

- Identification: the process of verification of user or machine account
- Authentication:  the process of proving the identity of the claiment
	- Something you know: passwords, passphrase, PIN, etc
	- Something you have: physical proof
	- Something you are: biometric readers
	- Multi-Factor Authentication (MFA): two or more of the above mechanisms of something you (know|have|are)
- Authorisation: determination of the scope of a users or machine account's allowed access
- Accountability: tracking activity to ensuring an user or machine account is responsible for their actions 
	- Logging is the procedure of recording events that occur 
	- [[SIEM-Solutions]] aggregate log data from multiple sources and perform a level of analysis to correlate security threats, identify anomalies, detect potential security incidents and provide alerts to security teams.  

- *Some sources refer to IdM and Identity and Access Management (IAM) interchangeably.*
- Identity Management (IdM): 
	- Inclusive of all the necessary policies and technologies for identification, authentication, and authorisation as a process of managing and controlling digital identities.
- Identity and Access Management (IAM):
	- Encompasses all the processes and technologies to manage and secure digital identities and access rights.
	- IAM systems help organisations comply with regulatory requirements.

Access Control Typology:
- Discretionary Access Control (DAC)
	- Access based on the discretion of the resource owner or administrator 
- Mandatory Access Control (MAC)
	- Access based on predefined rules or policies enforced by the control mechanism of a resource
- Role Based Access Control (RBAC) 
	- Access based on an pre-assigned role granted to users to define granular level of access 
- Attribute-Based Access Control (ABAC)
	- Access based on attributes that control access: role, time, location, device, etc. 

Single Sign-On improves security by reducing the overhead for users having to remember multiple credentials. Then users then have one strong credential, MFA layer can be added, which is both more efficient for the user and management of credential and support requests are simpler. 


## Attacks Against IAM

- [[Replay-Attacks]]
- [[Broken-Access-Control]]

## References


[THM OWASP Broken Access Control](https://tryhackme.com/room/owaspbrokenaccesscontrol)
[THM Identity And Access Management Room](https://tryhackme.com/room/iaaaidm)
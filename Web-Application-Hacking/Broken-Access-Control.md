# Broken Access Control

Access control is a security mechanism used to control which user account or machine accounts are allowed to access a particular resource. Broken access control vulnerabilities refer to situations where access control mechanisms fail to enforce proper restrictions on user access to resources or data. [[OWASP-Top-10-Historic-Definitions]] - was a Top 1. 

Access Control Typology:
- Discretionary Access Control (DAC)
	- Access based on the discretion of the resource owner or administrator 
- Mandatory Access Control (MAC)
	- Access based on predefined rules or policies enforced by the control mechanism of a resource
- Role Based Access Control (RBAC) 
	- Access based on an pre-assigned role granted to users to define granular level of access 
- Attribute-Based Access Control (ABAC)
	- Access based on attributes that control access: role, time, location, device, etc. 


Broken Access Control Typology 
- Horizontal Privilege escalation
	- Traversing privilege to another user
- Vertical Privilege escalation
	- Traversing privilege to user with great levels of access 
- Insufficient Access Control Checks
	- Where checks are inconsistent or incorrectly performed
- [[Insecure-Direct-Object-Reference]]s 
	- Where data can be modified to affect access control 

## Mitigation

1. Implement RBAC
2. Use Parameterised Queries
3. Proper session Management
4. Use Secure Coding Practices

## References

[THM OWASP Broken Access Control](https://tryhackme.com/room/owaspbrokenaccesscontrol)
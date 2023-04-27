# API Hacking

An Application Programming Interface is middleware that facilitates communication between multiple applications (any software) via a set of protocols and definitions to specific interfaces (service contract between two applications). Communication a set of requests and responses. 

Try put in an empty body of http request json {}

## OWASP API Top 10

[OWASP API Top 10](https://owasp.org/www-project-api-security/)

#### Broken Object Level Authorisation (BOLA)

[OWASP](https://github.com/OWASP/API-Security/blob/master/2019/en/src/0xa1-broken-object-level-authorization.md) *"Attackers can exploit API endpoints that are vulnerable to broken object level authorization by manipulating the ID of an object that is sent within the request. This may lead to unauthorized access to sensitive data."* 
- It is similar to Insecure Direct Object Reference (IDOR) - see [[Insecure-Direct-Object-Reference]]; but for APIs
- Implemented in APIs with Models (Model-View-Controller Architecture) at the code level
	- 

Migitations:
- Validate any incoming API calls for request methods
- Authorization mechanisms reliant on user policies and hierarchy
	- Write tests for API authorization mechanisms! - see:  [[Test-Driven-Development]]
- Randomise GUIDs for record IDs

#### Broken User Authentication (BUA)

#### Excessive Data Exposure

#### Lack of Resources & Rate Limiting

#### Broken Function Level Authorisation

## References

[Ippsec.rocks](https://ippsec.rocks)
[THM Room OWASP API Security](https://tryhackme.com/room/owaspapisecuritytop105w)
[OWASP API Top 10](https://owasp.org/www-project-api-security/)
[OWASP - Broken Object Level Authorization](https://github.com/OWASP/API-Security/blob/master/2019/en/src/0xa1-broken-object-level-authorization.md)
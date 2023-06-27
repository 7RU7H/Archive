# OWASP Top 10 - Historic Definitions 

This document is a condensing of OWASP various years listing of top ten vulnerability definitions. This is in  anticipation that Web Application vulnerability will persist, change and reappear into the future and therefore a document that catalogues all of them in the most condensed format is conceivably valuable.  The reason for various listing document specification is that historically some vulnerabilities return in nasty ways. Similar to other documents in this repository maximum of a couple of sentences to define a concept, but provide the addition recommendations regarding:
- Indicators of Vulnerability
- Prevention

## Broken Access control 	

Given a level of authentication, inadequate security allowing unintended access to, or control of the machine, user accounts and system files. 
- For admin panels see [[Web-App-Administration-Consoles]]
- [[File-Inclusion]]
- [[Insecure-Direct-Object-Reference]]

Indicators of Vulnerability:
Prevention:

## Cryptographic Failures

Poor implementation of or lack of adequate cryptographic algorithms to protect data, or weak or faulty implementations; token cracking like [[JSON-Web-Tokens]], cookie cracking like [[Javascript-Cookie-Abuse]], man in the middle
- [[MITM-Attacks]]
- 
Indicators of Vulnerability:
Prevention:

## Injection

Submitable data that is not properly filtered at an injection point: log in form, search feature or ANY interactive components.
- SQLi see [[SQLInjection]]
- XSS (2021 included as an injection attack) [[XSS-Cheatsheet]], 
- Remplate-injection like: [[Server-Side-Template-Injection-Cheatsheet]]
- [[Command-Injection-Cheatsheet]] 

Indicators of Vulnerability:
Prevention:

## Insecure Design

Where the web application design is fundamentally flawed. OWASP *"An insecure design cannot be fixed by a perfect implementation as by definition, needed security controls were never created to defend against specific attacks"*

Indicators of Vulnerability:
Prevention:

## Security Misconfiguration

Mismanaged security configurations of web server stack, underlying Operation System, databases, external services. 
- Permissions
- Secret management
- Exposing Error messages 
- Not using [HTTP security headers](https://owasp.org/www-project-secure-headers/), although this not a vulnerability in itself
- No brute force prevention or restrictions on [[Bypassing-Rate-Limits]]

[OWASP top 10 entry for Security Misconfiguration](https://owasp.org/Top10/A05_2021-Security_Misconfiguration/).

Indicators of Vulnerability:
Prevention:

## Vulnerable And Outdated Components

External services such as frameworks, software libraries

Indicators of Vulnerability:
- If you do not know the versions of all components you use (both client-side and server-side). This includes components you directly use as well as nested dependencies.
- If the software is vulnerable, unsupported, or out of date. This includes the OS, web/application server, database management system (DBMS), applications, APIs and all components, runtime environments, and libraries.
- If you do not scan for vulnerabilities regularly and subscribe to security bulletins related to the components you use.    
- If you do not fix or upgrade the underlying platform, frameworks, and dependencies in a risk-based, timely fashion. This commonly happens in environments when patching is a monthly or quarterly task under change control, leaving organizations open to days or months of unnecessary exposure to fixed vulnerabilities.
- If software developers do not test the compatibility of updated, upgraded, or patched libraries.
- If you do not secure the components’ configurations (see [A05:2021-Security Misconfiguration](https://owasp.org/Top10/A05_2021-Security_Misconfiguration/)).

## Identification and Authentication Failures

Weak credentials, steal-able session information, firewall mismanagement allowing for brute forcing. See [[Default-Passwords-Data-Recovery-Table]] or [[Password-Attacks]]
- Brute Force Attacks
- Weak credentials
- Weak session cookies
- Lack of MFA or modern prevention of brute forcing the user to respond to MFA requests
- Account creation logic flaw within the authentication mechanism where input is not sanitising whitespace "`user`" and  "` user`" are treated the as re-registering not a new account. 

## Software and Data Integrity Flaws

Software and data integrity failures relate to code and infrastructure that does not protect against integrity violations. 
- [[Upload-Vulnerabilities]]
- [[Hijacking-Remote-Technology-Repositories]]


Integrity of file hashes
```bash
echo "$expectHash" && md5sum $file
echo "$expectHash" && shasum -a $algorhythm $file
```

- [[Javascript-Cookie-Abuse]] and [[JSON-Web-Tokens]]

## Security Logging and Monitoring Failures

Indicators of Vulnerability:
- Missing appropriate security hardening across any part of the application stack or improperly configured permissions on cloud services.
- Unnecessary features are enabled or installed (e.g., unnecessary ports, services, pages, accounts, or privileges).
- Default accounts and their passwords are still enabled and unchanged.
- Error handling reveals stack traces or other overly informative error messages to users.
- For upgraded systems, the latest security features are disabled or not configured securely.
- The security settings in the application servers, application frameworks (e.g., Struts, Spring, ASP.NET), libraries, databases, etc., are not set to secure values.
- The server does not send security headers or directives, or they are not set to secure values.
- The software is out of date or vulnerable (see [A06:2021-Vulnerable and Outdated Components](https://owasp.org/Top10/A06_2021-Vulnerable_and_Outdated_Components/)).

Prevent:
- Ensure all login, access control, and server-side input validation failures can be logged with sufficient user context to identify suspicious or malicious accounts and held for enough time to allow delayed forensic analysis.
- Ensure that logs are generated in a format that log management solutions can easily consume.
- Ensure log data is encoded correctly to prevent injections or attacks on the logging or monitoring systems.
- Ensure high-value transactions have an audit trail with integrity controls to prevent tampering or deletion, such as append-only database tables or similar.    
- DevSecOps teams should establish effective monitoring and alerting such that suspicious activities are detected and responded to quickly.
- Establish or adopt an incident response and recovery plan, such as National Institute of Standards and Technology (NIST) 800-61r2 or later.

## Server-Side Request Forgery (SSRF)

When web application is fetching a remote resource without validating the user-supplied URL.  If an attacker can control the contents of the URL, they can force the application to process a crafted request to an unexpected destination, even when protected by a firewall, VPN, or another type of network access control list (ACL).

Indicators of Vulnerability:

Prevention - **Do not mitigate SSRF via the use of a deny list or regular expression!**
- From Network layer
	- Segment remote resource access functionality in separate networks to reduce the impact of SSRF
	- Enforce “deny by default” firewall policies or network access control rules to block all but essential intranet traffic.  
		- Hints:  
		    - Establish an ownership and a lifecycle for firewall rules based on applications.  
		    - Log all accepted _and_ blocked network flows on firewalls (see [A09:2021-Security Logging and Monitoring Failures](https://owasp.org/Top10/A09_2021-Security_Logging_and_Monitoring_Failures/)).
- From Application layer:
	- Sanitise and validate all client-supplied input data   
	- Enforce the URL schema, port, and destination with a positive allow list
	- Do not send raw responses to clients
	- Disable HTTP redirections
	- Be aware of the URL consistency to avoid attacks such as DNS rebinding and “time of check, time of use” (TOCTOU) race conditions


## References

[OWASP Top 10 entry](https://owasp.org/Top10/)
[HTTP security headers](https://owasp.org/www-project-secure-headers/)
[THM Room OWASP top 10 2021](https://tryhackme.com/room/owasptop102021)
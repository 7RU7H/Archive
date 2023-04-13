# OWASP Top 10 - WHENEVER 

This document is a condensing of OWASP various years listing of top ten vulnerability definitions. The reason for various listing document specification is that historically some vulnerablities return in nasty ways.
Similiar to other documents in this repository maximum of a couple of sentences to define a concept.
 

## Broken Access control 	

Given a level of authentication, inadequate security allowing unintended access to, or control of the machine, user accounts and system files. 
- For admin panels see [[Web-App-Administration-Consoles]]
- [[File-Inclusion-And-Directory-Traversal]]
- [[Insecure-Object-Reference]]

## Cryptographic Failures

Poor implementation of or lack of adequate cryptographic algorithms to protect data, or weak or faulty implementations; token cracking like [[JSON-Web-Tokens]], cookie cracking like [[Javascript-Cookie-Abuse]], man in the middle
- [[MITM-Attacks]]

## Injection

Submitable data that is not properly filtered at an injection point: log in form, search feature or ANY interactive components.
- SQLi see [[SQLInjection]]
- XSS(2021 included as an injection attack) [[XSS-Cheatsheet]], 
- Remplate-injection like: [[Server-Side-Template-Injection-Cheatsheet]]
- [[Command-Injection-Cheatsheet]] 

## Insecure Design

Where the web application design is fundementally flawed. OWASP *"An insecure design cannot be fixed by a perfect implementation as by definition, needed security controls were never created to defend against specific attacks"*

## Security Misconfiguration

Mismanaged security configurations of web server stack, underlying os, databases, external services. 
- Permissions
- Secret management
- Exposing Error messages 
- Not using [HTTP security headers](https://owasp.org/www-project-secure-headers/), although this not a vulnerablity in itself
- No brute force prevention or restrictions on [[Bypassing-Rate-Limits]]

[OWASP top 10 entry for Security Misconfiguration](https://owasp.org/Top10/A05_2021-Security_Misconfiguration/).

## Vulnerable And Outdated Components

External services such as frameworks, software libraries

## Identification and Authentication Failures

Weak credentials, stealable session information, firewall mismanagement allowing for brute forcing. See [[Default-Passwords-Data-Recovery-Table]] or [[Password-Attacks]]
- Brute Force Attacks
- Weak credentials
- Weak session cookies
- Lack of MFA or modern prevention of brute forcing the user to respond to MFA requests
- Account creation logic flaw within the authenication mechanism where input is not sanitizing whitespace "`user`" and  "` user`" are treated the as re-registering not a new account. 

## Software and Data Integrity Flaws

Deployments, code storage, data storage, insecure respoistories or delivery systems such that authorized access to or control over will lead to compromise:
- [[Upload-Vulnerabilities]]
- [[Hijacking-Remote-Technology-Repositories]]

Integrity of file hashes
```bash
echo "$expectHash" && md5sum $file
echo "$expectHash" && shasum -a $algorhythm $file
```

## Security Logging and Monitoring Failures

Lack of or undisciplined logging of user activity and patterns; coupled with incident response mechanisms if there is no logging where is the evidence to lead investigation, if there are extensive logging but no responsers is there an incident. Do incident responsers sit in the logs or shit in the woods. The [[Log4J]] exploit is great example. 

## Server-Side Request Forgery

When web application tries to reach a remote server without validating the URL of the remote server. If attack controls the contents of the URL, they can force the application to make a request to a resource it should not be able to reach, including attacker own server.


## References

[OWASP top 10 entry for Security Misconfiguration](https://owasp.org/Top10/A05_2021-Security_Misconfiguration/)
[HTTP security headers](https://owasp.org/www-project-secure-headers/)
[OWASP top 10 2021](https://tryhackme.com/room/owasptop102021)
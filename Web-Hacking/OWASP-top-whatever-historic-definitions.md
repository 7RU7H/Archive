# OWASP TOP WHATEVER

This document is a condensing of OWASP various years listing of top ten vulnerability definitions. The reason for various listing document specification is that historically some vulnerablities return in nasty ways.
Similiar to other documents in this repository maximum of a couple of sentences to define a concept.
 

## Broken Access control 	
Given a level of authentication, inadequate security allowing unintended access or control to the machine, user accounts and system files. For admin panels see [[Web-App-Administration-Consoles]], or for [[File-Inclusion-And-Directory-Traversal]].

## Cryptographic Failures
Poor implementation of or lack of adequate cryptographic algorithms to protect data, or weak or faulty implementations.
token cracking like [[JSON-web-tokens]], cookie cracking like [[Javascript-Cookie-Abuse]], man in the middle


## Injection
Submitable data that is not properly filtered at an injection point: log in form, search feature or ANY interactive components.
SQLi see [[SQLInjection]], XSS(2021 included as an injection attack) [[XXS-Cheatsheet]], template-injection like: [[Server-Side-Template-Injection-Cheatsheet]]

## Insecure Desgin 
Where the web application design is fundementally flawed.

## Security Misconfiguration
Mismanaged security configurations of web server stack, underlying os, databases, external services. No brufe force prevention or restrictions on [[Bypassing-Rate-Limits]]

## Vulnerable And Outdated Components
External services such as frameworks, software libraries

## Identification and Authentication Failures
Weak credentials, stealable session information, firewall mismanagement allowing for brute forcing. See [[Default-Passwords-Data-Recovery-Table]] or [[Password-Attacks]]

## Software and Data Integrity Flaws
Deployments, code storage, data storage, insecure respoistories or delivery systems such that authorized access to or control over will lead to compromise like [[Upload-Vulnerabilities]]

## Security Logging and Monitoring Failures
Lack of or undisciplined logging of user activity and patterns; coupled with incident response mechanisms if there is no logging where is the evidence to lead investigation, if there are extensive logging but no responsers is there an incident. Do incident responsers sit in the logs or shit in the woods. The [[log4J]] exploit is great example. 

## Server-Side Request Forgery
When web application tries to reach a remote server without validating the URL of the remote server. If attack controls the contents of the URL, they can force the application to make a request to a resource it should not be able to reach, including attacker own server.



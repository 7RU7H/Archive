# OWASP TOP WHATEVER

This document is a condensing of OWASP various years listing of top ten vulnerability definitions.
The reason for various listing document specification is that historically some vulnerablities return in nasty ways.
Similiar to other documents in this repository maximum of a couple of sentences to define a concept.
 

## Broken Access control 	
Given a level of authentication, inadequate security allowing unintended access or control to the machine, user accounts and system files.

## Cryptographic Failures
Poor implementation of or lack of adequate cryptographic algorithms to protect data, or weak or faulty implementations.
JWT token cracking, cookie cracking, man in the middle

## Injection
Submitable data that is not properly filtered at an injection point: log in form, search feature or ANY interactive components.
SQLi, XSS(2021 included as an injection attack), template-injection

## Insecure Desgin 
Where the web application design is fundementally flawed.

## Security Misconfiguration
Mismanaged security configurations of web server stack, underlying os, databases, external services.

## Vulnerable And Outdated Components
External services such as frameworks, software libraries

## Identification and Authentication Failures
Weak credentials, stealable session information, firewall mismanagement allowing for brute forcing

## Software and Data Integrity Flaws
Deployments, code storage, data storage, insecure respoistories or delivery systems such that authorized access to or control over will lead to compromise.

## Security Logging and Monitoring Failures
Lack of or undisciplined logging of user activity and patterns; coupled with incident response mechanisms if there is no logging where is the evidence to lead investigation, if there are extensive logging but no responsers is there an incident. Do incident responsers sit in the logs or shit in the woods. 

## Server-Side Request Forgery
When web application tries to reach a remote server without validating the URL of the remote server. If attack controls the contents of the URL, they can force the application to make a request to a resource it should not be able to reach, including attacker own server.



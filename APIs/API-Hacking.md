# API Hacking

An Application Programming Interface is middleware that facilitates communication between multiple applications (any software) via a set of protocols and definitions to specific interfaces (service contract between two applications). Communication a set of requests and responses. 

## Tricks

- Try put in an empty body of http request json `{}`
``

## OWASP API Top 10

[OWASP API Top 10](https://owasp.org/www-project-api-security/)

#### Broken Object Level Authorisation (BOLA)

[OWASP](https://github.com/OWASP/API-Security/blob/master/2019/en/src/0xa1-broken-object-level-authorization.md) *"Attackers can exploit API endpoints that are vulnerable to broken object level authorization by manipulating the ID of an object that is sent within the request. This may lead to unauthorized access to sensitive data."* 
- It is similar to Insecure Direct Object Reference (IDOR) - see [[Insecure-Direct-Object-Reference]]; but for APIs
- Implemented in APIs with Models ([Model-View-Controller](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) Architecture) at the code level - see [[Model-View-Controller]] for details, but basically:
	- MVC:
		- `User` - uses `Controller`
		- `Controller` manipulates -> `Model`
		- `Model` updates -> `View`
		- `View` sees `User` 

Migitations:
- Validate any incoming API calls for request methods
- Authorization mechanisms reliant on user policies and hierarchy
	- Write tests for API authorization mechanisms! - see:  [[Test-Driven-Development]]
- Randomise GUIDs for record IDs

#### Broken User Authentication (BUA)

Broken User Authentication (BUA) is incorrect implementation of authenication mechanism leading to the compromising of authentication tokens or temporary or permanent impersonation of user’s identities.

Migitations:
- Ensure end users use complex passphrases
- Ensure High Entropy and credential encryption at rest 
- Do not expose credentials in GET or POST requests
- Strong [[JSON-Web-Tokens]], Authorisation Headers
- Implement MFA, account lockout, captcha system to migitate brute forcing 


#### Excessive Data Exposure

Mitigations:
- Never rely on the client side to filter sensitive data.
- Review the responses from the API to make sure they contain only legitimate data.
- Ask who is consuming this data before exposing a new API endpoint
- Avoid generic methods such as `to_json()` and `to_string()`; cherry-pick specific properties you really want to return
- Classify sensitive and personally identifiable information (PII) that your application stores and works
- Implement a schema-based response validation mechanism as an extra layer of security.
- Review all API calls returning or handling any classified data - sensitive or personally identifiable information (PII)

#### Lack of Resources & Rate Limiting

#### Broken Function Level Authorisation





## References

[Ippsec.rocks](https://ippsec.rocks)
[THM Room OWASP API Security - part 1](https://tryhackme.com/room/owaspapisecuritytop105w)
[OWASP API Top 10](https://owasp.org/www-project-api-security/)
[OWASP - Broken Object Level Authorization](https://github.com/OWASP/API-Security/blob/master/2019/en/src/0xa1-broken-object-level-authorization.md)
[Wikipedia Model-View-Controller](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller)
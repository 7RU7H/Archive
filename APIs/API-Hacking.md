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

Excessive Data Exposure is simple - exposure of object, properties or endpoints that expose data that should be classified as sensitive and handle in secure way and the reliance on client data filtering. Attackers sniff the traffic to analyze the API responses.
v
- Never rely on the client side to filter sensitive data.
- Review the responses from the API to make sure they contain only legitimate data.
- Ask who is consuming this data before exposing a new API endpoint
- Avoid generic methods such as `to_json()` and `to_string()`; cherry-pick specific properties you really want to return
- Classify sensitive and personally identifiable information (PII) that your application stores and works
- Implement a schema-based response validation mechanism as an extra layer of security.
- Review all API calls returning or handling any classified data - sensitive or personally identifiable information (PII)

#### Lack of Resources & Rate Limiting

Both lack of resource and controls to enforce rate usage of resources can lead to Denial of Service (DoS), [*but also leaves the door open to authentication flaws such as brute force.*](https://owasp.org/www-project-api-security/)

Mitigations and Prevention:
- Use docker with ease of use over limit [memory](https://docs.docker.com/config/containers/resource_constraints/#memory), [CPU](https://docs.docker.com/config/containers/resource_constraints/#cpu), [number of restarts](https://docs.docker.com/engine/reference/commandline/run/#restart-policies---restart), [file descriptors, and processes](https://docs.docker.com/engine/reference/commandline/run/#set-ulimits-in-container---ulimit).
- Implement a limit on how often a client can call the API within a defined timeframe.
- Notify the client when the limit is exceeded by providing the limit number and the time at which the limit will be reset.
- Add proper server-side validation for query string and request body parameters, specifically the one that controls the number of records to be returned in the response.
- Define and enforce maximum size of data on all incoming parameters and payloads such as maximum length for strings and maximum number of elements in arrays.

#### Broken Function Level Authorisation





## References

[Ippsec.rocks](https://ippsec.rocks)
[THM Room OWASP API Security - part 1](https://tryhackme.com/room/owaspapisecuritytop105w)
[OWASP API Top 10](https://owasp.org/www-project-api-security/)
[OWASP - Broken Object Level Authorization](https://github.com/OWASP/API-Security/blob/master/2019/en/src/0xa1-broken-object-level-authorization.md)
[Wikipedia Model-View-Controller](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller)
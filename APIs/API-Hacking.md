# API Hacking

An Application Programming Interface is middleware that facilitates communication between multiple applications (any software) via a set of protocols and definitions to specific interfaces (service contract between two applications). Communication a set of requests and responses. 

## Tricks

- Try put in an empty body of http request json `{}`

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

Hunt for:
- Are there checks for any API endpoints does the user have access to perform the requested action of the requested object?


Migitations:
- Validate any incoming API calls for request methods
- Authorization mechanisms reliant on user policies and hierarchy
	- Write tests for API authorization mechanisms! - see:  [[Test-Driven-Development]]
- Randomise GUIDs for record IDs

#### Broken User Authentication (BUA)

Broken User Authentication (BUA) is incorrect implementation of authenication mechanism leading to the compromising of authentication tokens or temporary or permanent impersonation of user’s identities.

Hunt for:
- Can you: 
	- Credential stuff
	- Brute force
	- Break a weak encryption key if encrypted, weakly hashed or in plain text
	- Pass unsigned/weakly signed [[JSON-Web-Tokens]] - no expiration datas?
- Does the API permit weak passwords?
- Does the API validate tokens
- Is sensitive data sent in the URL

Migitations:
- Ensure end users use complex passphrases
- Ensure High Entropy and credential encryption at rest 
- Do not expose credentials in GET or POST requests
- Strong [[JSON-Web-Tokens]], Authorisation Headers
- Implement MFA, account lockout, captcha system to migitate brute forcing 


#### Excessive Data Exposure

Excessive Data Exposure is simple - exposure of object, properties or endpoints that expose data that should be classified as sensitive and handle in secure way and the reliance on client data filtering. Attackers sniff the traffic to analyze the API responses.

Hunt for:
- Can you sniff traffic erroneously intended by the develope to be filtered on the client-side?

Mitigations and Preventions:
- Never rely on the client side to filter sensitive data.
- Review the responses from the API to make sure they contain only legitimate data.
- Ask who is consuming this data before exposing a new API endpoint
- Avoid generic methods such as `to_json()` and `to_string()`; cherry-pick specific properties you really want to return
- Classify sensitive and personally identifiable information (PII) that your application stores and works
- Implement a schema-based response validation mechanism as an extra layer of security.
- Review all API calls returning or handling any classified data - sensitive or personally identifiable information (PII)

#### Lack of Resources & Rate Limiting

Both lack of resource and controls to enforce rate usage of resources can lead to Denial of Service (DoS), [*but also leaves the door open to authentication flaws such as brute force.*](https://owasp.org/www-project-api-security/)

Hunt for:
- Execution timeouts
- Max allocable memory
- Number of file descriptors
- Number of processes
- Request payload size (e.g., uploads)
- Number of requests per client/resource
- Number of records per page to return in a single request response


Mitigations and Prevention:
- Use docker with ease of use over limit [memory](https://docs.docker.com/config/containers/resource_constraints/#memory), [CPU](https://docs.docker.com/config/containers/resource_constraints/#cpu), [number of restarts](https://docs.docker.com/engine/reference/commandline/run/#restart-policies---restart), [file descriptors, and processes](https://docs.docker.com/engine/reference/commandline/run/#set-ulimits-in-container---ulimit).
- Implement a limit on how often a client can call the API within a defined timeframe.
- Notify the client when the limit is exceeded by providing the limit number and the time at which the limit will be reset.
- Add proper server-side validation for query string and request body parameters, specifically the one that controls the number of records to be returned in the response.
- Define and enforce maximum size of data on all incoming parameters and payloads such as maximum length for strings and maximum number of elements in arrays.

#### Broken Function Level Authorisation

Where a user can bypass the mechanisms to secure associated access, permissions and privileges of other groups to then exploit this extension to their capabilities.  

Hunt for
- Non-Administrative access to administrative endpoints? 
	- Do not base this on the path only!
- Can Non-Administrative users perform standand or non-standard administrative actions?
- Can Non-Administrative user from one security group access functions exposed only to another group? 

Mitigations and Preventions:
- Consistent and easy to analyze authorization module that is invoked from all your business functions 
- The enforcement mechanism(s) should deny all access by default, requiring explicit grants to specific roles for access to every function.
- Review your API endpoints against function level authorization flaws, while keeping in mind the business logic of the application and groups hierarchy.
- Make sure that all of your administrative controllers inherit from an administrative abstract controller that implements authorization checks based on the user’s group/role.
- Make sure that administrative functions inside a regular controller implements authorization checks based on the user’s group and role.
 

#### Mass Assignment

Mass alignment is mass modification by the client to data models. *"Exploitation of mass assignment is easier in APIs, since by design they expose the underlying implementation of the application along with the properties’ names"* 

Hunt For...
1. Seek to understanding the API structure, business logic and object's relations)
2. Hunt for:
	- Lack of filtering of client input 
		- Is there a schema to data expected?
		- Is there blacklisting?
	- Client’s input data payload fields

Mitigations and Preventions:
-   If possible, avoid using functions that automatically bind a client’s input into code variables or internal objects.
-   Whitelist only the properties that should be updated by the client.
-   Use built-in features to blacklist properties that should not be accessed by clients.
-   If applicable, explicitly define and enforce schemas for the input data payloads.

#### Security Misconfiguration

Any configuration that leads to a security vulnerability, therefore a considered a misconfiguration. 

Hunt for:
- Versioning - out-of-date or missing patches
- Error handling leaking information like stack traces or sensitive information
- No TLS
- Security directives are not sent to clients (e.g., [Security Headers](https://www.owasp.org/index.php/OWASP_Secure_Headers_Project))
- Cross-Origin Resource Sharing (CORS) policy is missing or improperly set


Mitigations and Preventions:
The API life cycle should include:
- A repeatable hardening process leading to fast and easy deployment of a properly locked down environment.
- A task to review and update configurations across the entire API stack. The review should include: orchestration files, API components, and cloud services (e.g., S3 bucket permissions).
- A secure communication channel for all API interactions access to static assets (e.g., images).
- An automated process to continuously assess the effectiveness of the configuration and settings in all environments.

- Use TLS 
- Define and enforce all API response payload schemas including error responses.
- Disable all HTTP verbs other than the specified 
- Proper implement of Cross-Origin Resource Sharing (CORS) policy.


#### Injection

Where injection attacks can occur through API queries. See [[SQLInjection]], [[Command-Injection-Cheatsheet]], etc.

Hunt for:
- Unfiltered, unvalidated or unsanitized client-supplied data
- Direct concatenation of client-supplied data and embeded service queries through an API query
- Data from external systems is unfiltered, unvalidated or unsanitized 

Mitigations and Preventions:
- Perform data validation using a single, trustworthy, and actively maintained library.
- Validate, filter, and sanitize all client-provided data, or other data coming from integrated systems.
- Special characters should be escaped using the specific syntax for the target interpreter.
- Prefer a safe API that provides a parameterized interface.
- Always limit the number of returned records to prevent mass disclosure in case of injection.
- Validate incoming data using sufficient filters to only allow valid values for each input parameter.
- Define data types and strict patterns for all string parameters.

#### Improper Assets Management

Scenarios where variant versions both past or development branches of an API are exposed along with the production branch.

Hunt for:
- Unclear answers to the purpose of an API host:
	- Which environment is the API running in (e.g., production, staging, test, development)?
	- Who should have network access to the API (e.g., public, internal, partners)?
	- Which API version is running?
	- What data is gathered and processed by the API (e.g., PII)?
	- What's the data flow?
- Old, development or previous API versions are running unpatched on live systems
- Integrated services inventory, either first- or third-party, is missing or outdated.

Migitiations and Preventions:
- API security firewalls for all exposed versions of your APIs
- API versions inventory - All API hosts and document important aspect of each
	- Inventory integrated services and document important aspects
	- Hosting  branches - production, staging, test, development
		- Access controls relevant to each
	- Avoid using production data with non-production API deployments 		
- Retirement planning
- API documentation available to those authorized to use the API
- Generate documentation automatically by adopting open standards
- Document all aspects of your API
- Perform risk analysis on newer versions that include security improvements


#### Insufficient Logging & Monitoring



## References

[Ippsec.rocks](https://ippsec.rocks)
[THM Room OWASP API Security - part 1](https://tryhackme.com/room/owaspapisecuritytop105w)
[OWASP API Top 10](https://owasp.org/www-project-api-security/)
[OWASP - Broken Object Level Authorization](https://github.com/OWASP/API-Security/blob/master/2019/en/src/0xa1-broken-object-level-authorization.md)
[Wikipedia Model-View-Controller](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller)
# HTTP Defined

Stateless without cookies. Data from one HTTP request does not influence the next request sent by the same user. The web server can only process the data available on the request. For [[HTTP-Routing]]

- Start line = what kind of message and how message should be handled 
- Headers = key-value pairs providing information about the HTTP message
- Empty line = is format device to segment Body and Headers
- Body = data is stored here

## Versions

The **HTTP version** shows the protocol version used to communicate between the client and server. Here’s a quick rundown of the most common ones:

**HTTP/0.9** (1991)The first version, only supported GET requests.

**HTTP/1.0** (1996)Added headers and better support for different types of content, improving caching.

**HTTP/1.1** (1997)Brought persistent connections, chunked transfer encoding, and better caching. It’s still widely used today.

**HTTP/2** (2015)Introduced features like multiplexing, header compression, and prioritisation for faster performance.

**HTTP/3** (2022)Built on HTTP/2, but uses a new protocol (QUIC) for quicker and more secure connections.

Although HTTP/2 and HTTP/3 offer better speed and security, many systems still use **HTTP/1.1** because it’s well-supported and works with most existing setups. However, upgrading to HTTP/2 or HTTP/3 can provide significant performance and security improvements as more systems adopt them.
## Requests

METHODS | Description
--- | ---
GET | Request to receive the HTML for specific page 
POST | For form (a set of criteria for data) on a page data is submitted to the application
PUT |  Updates the content of a given resource with the client's input.
DELETE | Removes the requested resource.
OPTIONS | Returns the communication options allowed by the server, including the allowed methods that the server accepts.
HEAD | Similar to GET, but only retrieves the HTTP headers of the page without the response body.
TRACE | allows the client to see what is being received at the other end of the request chain and use that data for testing or diagnostic information
EXEC | Execute

..sometimes servers have CUSTOM METHODS...

METHOD | PATH | QUERY STRING | PARAMETERS | PROTOCOL
--- | --- | --- | --- | ---
GET |  	/user | /login? | user=hacker |	HTTP/1.1

#### GET parameters and URL encoding:
```
    ? - The query string identifier, which starts a query string. Example: http://site.com?search
    = - Separates a parameter and value pair. Example: "language=english"
    & - Appends another parameter and value pair. Example: "language=english&color=blue"
    / - Indicates hierarchical directory structure or http route. Example: http://site.com/folder/page.txt
    . - Part of a directory structure. A single period (".") represents the current directory and two of them ("..") represents one parent up.
    : - Separates the protocol and port from the resource. Example: http://site.com
    % - Indicates a URL encoding character.
```

#### Headers 

Request Headers:
```
User-Agent: specifies browser and version
Origin: Where the request originates
Accept-Langauge: Human Language to use
Accept-Encoding: Encoding type the client can decode - client server negotiate which compression algorithm for data transmission
Forwarded: Diagnostics for given request via proxy
Content-Type: # what type of data the server expects i.e:"application/x-www-form-urlencoded", "application/json", and "multipart/form-data"
```


Response Headers:
```javascript
Set-Cookie: <cookie-name>=<cookie-value>
Set-cookie: Secure // response header to ensure they are only transmitted over HTTPS
Set-cookie: HttpOnly // prevent JavaScript access
```

Security Headers
- Content-Security-Policy (CSP)
	- `default-src`
	    - specifies the default policy of self of current website.    
	- `script-src`
	    - specifics the policy for path to scripts can be loaded from
	- `style-src` 
	    - specifies the policy for where style CSS style sheets can be loaded from
- Strict-Transport-Security (HSTS)
	- `max-age` 
	    - Expiry time in seconds for a setting 
	- `includeSubDomains`  
	    - An optional setting that instructs the browser to also apply this setting to all subdomains.     
	- `preload`
		- Optional setting allows the website to be included in preload lists. Browsers can use preload lists to enforce HSTS before even having their first visit to a website.
- X-Content-Type-Options
	- `nosniff`
		- Directive instructing the browser not to sniff or guess the MIME type.
- Referrer-Policy
	- `no-referrer`  
	    - Completely disables any information being sent about the referrer  
	- `same-origin`  
	    - This policy will only send referrer information when the destination is part of the same origin.
	- `strict-origin`
	    - Only sends the referrer as the origin when the protocol stays the same.   
	- `strict-origin-when-cross-origin`
	    - Similar to strict-origin, except for same-origin requests where it sends the full URL path in the origin header.


[The HTTP **`WWW-Authenticate`** response header defines the [HTTP authentication](https://developer.mozilla.org/en-US/docs/Web/HTTP/Authentication) methods ("challenges") that might be used to gain access to a specific resource.](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/WWW-Authenticate)

### HTTP Body

Body last line(s) of HTTP request where the payload, any data transmitted will be located


## Responses
Once the server has process the request it will respond with status codes:

#### HTTP status codes.

    200 to 299: Success
    300 to 399: Redirection
    400 to 499: Client Error (request is unauthorized or not found)
    500 to 599: Server Error

Response Headers:
```
Server: Often software running the web server
Proxy-Authenticate: type of authentication to access page or resource behind a proxy
Strict-Transport-SEcutiry(HSTS): informs client access by HTTPS only!
X-*:Non standard HTTP headers, often revealing information is here
```


## URL Encoding

To ensure data is parse correctly by client and server data can be encoded with URL encoding that  works by replacing all forbidden URL characters with the "%" sign followed by the hexadecimal ASCII value of the specified character.


## References

[Mozilla WWW-Authenticate Documentation](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/WWW-Authenticate)
[TryHackMe Web Application Basics](https://tryhackme.com/room/webapplicationbasics)
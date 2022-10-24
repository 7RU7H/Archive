# HTTP Defined

Stateless without cookies. Data from one HTTP request does not influence the next request sent by the same user. The web server can only process the data available on the request. For [[Ht]]

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

`Set-Cookie: <cookie-name>=<cookie-value>`

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




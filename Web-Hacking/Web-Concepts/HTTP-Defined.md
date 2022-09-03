# HTTP Defined

Stateless without cookies. Data from one HTTP request does not influence the next request sent by the same user. The web server can only process the data available on the request.

## Requests

METHODS | Description
--- | ---
GET | Request to receive the HTML for specific page 
POST | For form (a set of criteria for data) on a page data is submitted to the application
PUT |  Updates the content of a given resource with the client's input.
DELETE | Removes the requested resource.
OPTIONS | Returns the communication options allowed by the server, including the allowed methods that the server accepts.
HEAD | Similar to GET, but only retrieves the HTTP headers of the page without the response body.
sometimes servers have CUSTOM METHODS...

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



##  HTTP Routing 

Traditionally web servers would have directory structures where the "web root" is the base directory. On linux it is located under /var/www/html/. If files are added here they are hosted by the web server:
- The .index files contain default content, these are the default page browsers route to.  If an .index file is unspecified the web server may return a directory listing.
- Robots.txt allows specifying of the non-crawlable pages.
- Humans.txt is newer convention listing web content creators.
- sitemap.xml is antithesises to robots.txt

Modern sites INSTEAD of files in a directory structure would define a URL at site/ to respond with a certaon resource.To reiterate slightly, site/ is not a file, it would be a full name of a resource and not actually a path to a file. No files hosting content - we NEED to know the full name of the resource in order to access it: /user be a resource but not /users/ Resources can be coded to be access via a particular method. This makes resource enumeration more time consuming.
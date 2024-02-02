# HTTP Desync Attacks

## albinowax - HTTP Desync Attacks: Smashing into the Cell Next Door - DEF CON 27 Conference

**Beware this very dangerous to all including weaponisation of this, IF there is a cache it will send everyone your way**
**HTTP REquest Smuggling is real**
**HTTP/1.1 parsing is security critical**
**Dectection desn't have to be dangerous**

HTTP requests are traditionally viewed as isolated, standalone entities. In this session, I'll introduce techniques for remote, unauthenticated attackers to smash through this isolation and splice their requests into others, through which I was able to play puppeteer with the web infrastructure of numerous commercial and military systems, rain exploits on their visitors, and harvest over $50k in bug bounties.

Using these targets as case studies, I’ll show you how to delicately amend victim's requests to route them into malicious territory, invoke harmful responses, and lure credentials into your open arms. I’ll also demonstrate using backend reassembly on your own requests to exploit every modicum of trust placed on the frontend, gain maximum privilege access to internal APIs, poison web caches, and compromise my favourite login page.
Although documented over a decade ago, a fearsome reputation for difficulty and collateral damage has left this attack optimistically ignored for years while the web's susceptibility grew. By applying fresh ideas and new techniques, I’ll unveil a vast expanse of vulnerable systems ranging from huge content delivery networks to bespoke backends, and ensure you leave equipped to devise your own desync techniques and tailor attacks to your target of choice.

albinowax
James Kettle is Head of Research at PortSwigger Web Security, where he designs and refines vulnerability detection techniques for Burp Suite's scanner. Recent work has focused on using web cache poisoning to turn caches into exploit delivery systems. James has extensive experience cultivating novel attack techniques, including server-side RCE via Template Injection, client-side RCE via malicious formulas in CSV exports, and abusing the HTTP Host header to poison password reset emails and server-side caches. He has spoken at numerous prestigious venues including both BlackHat USA and EU, and OWASP AppSec USA and EU.

Notes

The Fear Theory 

Best research topic is one the that make most scared

HTTP Request Smuggling

- Hiding Wookiees in HTTP DEFCON 
Watchfire - documented case: 2005


### Theory and Methodology

[Users] -> Website -> HTTP over tls/tcp -> [BACK-END]
Each tls request is back to back each server in the chain is require to parse each HTTP HEADER to figure out where each begins and ends 

Funneled by single stream...An attack can then send an ambiguious first message that then get merged by a second when the first is unparsable in its ending

Prefix on the back-end that is then hit by another message.

Classic - wont work on anything modern but a good example:
```
POST / HTTTP /1.1
HOST: example.com
Content-Length: 6 <- Frontend sees this
Content-Length: 5 <- Backend sees this

12345G

```
POST / HTTP /1.1
HOST: example.com 
```
Unknown GPOST response

Chunked Approach 

```
...
Content-Length: 6 <- Frontend sees this
Transefer-Encoding: chunked <- Backend sees this

```

What if Header are parsed in the opposite *"\*-End Sees.."* configuration to the above?

RFC 2616: *"If a message is recieved with both a Transfer-Encoding header field and a Content-Lengtyh header field, the latter MUST be ignored."*

If one server does not supprt chunk it will fallback to Content-Length

Some Normalise white space
Some Token xchunked

```
Transfer-Encoding: chunked 
Content-Length: 123
```

```
Transfer-Encoding: chunked 
```
albinowax's:
```
Transfer-Encoding: xchunked 
```

```
GET / HTTP/1.1
Transfer-Encoding: chunked 
```

```
Transfer-Encoding
   :  chunked 
```

```
Transfer-Encoding: chunked
Transfer-Encoding: x
```

```
Transfer-Encoding:[tab]chunked
```

```
X: X[\n]Transfer-Encoding: chunked
```

Method
Detect -> Confirm -> Explore -> Store | Attack


Detecting desync

Timing in sending a pair is key live testing with other users present may interrupt our desynchronisation

Try this one first
CL.CL: backend response
TE.TE: frontend response
TE.CL: frontend response
CL.TE: timeout

```
POST /about HTTP/1.1
Host: example.com
Transfer-Encoding: chunked
Content-Length: 6

3
abc
```
```
Q
```
Or you may poison the socket

CL.CL: backend response
TE.TE: backend response
TE.CL: timeout 
CL.TE: socket poison

```
POST /about HTTP/1.1
Host: example.com
Transfer-Encoding: chunked
Content-Length: 6

0
```
```
x
```

Every end point as the request maybe routed to different backend servers.

There are false positives, less likely there are false negatives

Confirming desync

```
POST /search HTTP/1.1
Content-Length: 51
Transfer-Encoding: zchunked

11
=x&q=smuggling&x=
0


GET /404 HTTP/1.1
X: X
```

```
POST /search HTTP/1.1		# Trigger
Host: example.com
```


```
POST /search HTTP/1.1
Content-Length: 4
Transfer-Encoding: zchunked

96
GET /404 HTTP/1.1
X: X=1&q=smugging&x=
HOST: example.com
Content-Length: 100

x=
0
```

```
POST /search HTTP/1.1 			# Trigger
Host: example.com
```

Crucial these two request are not sent over the same connection to the front end server - you 'l get false positives
Endpoint is important - backend will reject and close connection to front and poison section in the first request will be drop
These are non detirministic - anyone else request interrupts it will fail, even if they arent any other user's browsing it they may have pool on the backend at may require multiple attempts.


### Exploitation Case Studies

Bypassing rules - Request admin page then root webpage, backend sends the admin panel.

Bypassing rewrite - 100% you know it vulnerable, but timeout and traffic is so you have no chance to desync: Blind request smuggling - unique host name

(Custom application Headers): Request reflection - Shuffle parameters + put custom header last; concatenation occurs with second request.
- Then you get SSRF over HTTP Request Smuggling

Involuntary request storage - if application has persistent text storing data then HTTP Request Smuggling you get random user control

Harmful responses - With reflected xss you can then with HTTP RS serve the reflected xss on mass

Cache Poisoning - This can be dangerous to the hacker - storing your ip that then get hit over over and over again after HTTP RS back you...lol 
Web Cache Deception, but random user, attacker has no control of API key will end up somewhere on the static resources on website
- Avoid with
	- Anticaching header
	- Try as fast as possible
	- Geolocation that is asleep

CDN Chaining - If Backend is a content delivery network CDN, you can desynchronise them.

Chaining DOM Problems - chaining DOM based redirect with server side local redirect to gain control of a url in a users browser

Redirect with teeth - Local redirects turn into Open redirects because we can change the smuggled host header

Apache and IIS default behaviour: if you tr access a folder and you dont specify a trailing slash it gives a redirect with populate hostname in the host Header: redirect js to control whatever page the js load comes from
307 redirect is gold dust: repost credentials to the new website

### Defence 

Prevented on the Front-end best as the Backend cannot normalise

You need to be able to find it!
Attack tooling
- Support manual/invalid content-length
- Dont normalize requests
- If using curl depending on the technique it may not work!
- Test environment must match prod

FE: Normalize ambigious request - RFC 7230
FE: Use HTTP/2 to talk to backend
BE: Drop request & connection

### Futher reading

Whitepaper: https://portswigger.net/blog/http-desync-attacks

Lab: https://portswigger.net/web-security/request-smuggling

Burp Suite Extension: https://github.com/portswigger/http-request-smuggler

References: http://cgisecurity.com/lib/HTTP-Request-Smuggling.pdf

## References

[DEFCONConference Youtube](https://www.youtube.com/watch?v=w-eJM2Pc0KI)

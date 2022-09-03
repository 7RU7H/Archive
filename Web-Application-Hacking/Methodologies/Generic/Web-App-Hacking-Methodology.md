# Web-App Hacking Methodology
## Introduction

Web-related hacking may seem very independent as a system, but in actuality Web applications are an attack vector that is a layer over other systems, thus are often a common path to a foothold on that underlying system. For a more Bug Bounty focuesed recon methodology see the awesome [[Haddix-Methodology]] and follow this link for [[Application-Analysis]], both concatenated versions of the versions of these talks by Jason Haddix. Web-Apps generally expose a large attack surface due to intial requirement of having to be exposed to the internet, a lack of mature application code, multiple dependencies from language libraries or framework usage and insecure server configurations.

## Tools
You can do alot with just `Burp`, `[insert browser of choice] Dev tools`, `Nikto` a `insert directory buester of choice` and `curl`, but sometimes less so `curl` can be blocked as [[Mechanizing-The-Methodology]] points out method for bypassing curl blocking. Bounty bug tools and framework on Github have become numerous and powerful, [[Haddix-Methodology]] and [[Application-Analysis]] provide great sources of good tools.

[[Nikto-Cheatsheet]]
[[Burpsuite-Helpsheet]]
[[OpenVAS]]
[[Nmap-Cheatsheet]]


## Web Application Assessment vs Peneteration test
Web App assessments have borad objective on a small selection of applcations or hosts. Whereas Penetration tests are very specific goal over  a larger than the web application potential scoping. [See Penetration Testing Execution Standard (PTES)](http://www.pentest-standard.org/index.php/Main_Page) and [OWASP's Web Application Security Testing](https://owasp.org/www-project-web-security-testing-guide/) for some ideas around the various stardards applied to assesement structuring.

## Web Application Assessment
Information gathering 
Component identification is vital to time effiency when enumerating as the underlying technology must be targeted.

## Attack Surface
Detirmination of attack surface is outlined in [[Application-Analysis]].
0. Stack Enumeration
1. URLs
2. Page Content
3. Response Headers
4. Sitemaps
5. Administration pages
6. Data Entry
7. Data Retrieval
8. Uploading
9. Searching
10. Any other interactions
11. Cookies, Tokens
12. Login  pages
13. Source code for static analysis

#### Web Stack Enumeration
A web stack is the combinations of web technologies from front-end typically UX of a webpage to back-end database, a (or combination of) language(s) and finally the host OS of a server.

1. What does the application do?
2. Languages, Frameworks?
3. Web server software used?
4. Database software used?
5. Server software application is ran on?

To find: 
1. Spider/bust a site for libraries, API, .extensions
*Disclaimer: Applications leveraging routes use logic to determine what content is returned to the user and make URI extensions largely irrelevant*
2. `Server:` header
3. Injection attacks that target the Templates of Frameworke
4. Injection attacks that target the Database
5. Parameters?

#### Page Content Inspection 
Firefire DevTools `Debugger` may display JavaScript frameworks, hidden input fields, comments, client-side controls within HTML, JavaScript, and more. With `Debugger -> { }` we can prettify [minified code](https://en.wikipedia.org/wiki/Minification_(programming). `Right-click -> Inspect Element`

#### Response Headers
Firefire DevTools `Network` tool or for more manual customisation `curl`check out[[Curl-Cheatsheet]] or `Burpsuite` check out [[Burpsuite-Helpsheet]].

#### Sitemaps
These pages contain `Allow` and `Disallow` are directives for search engine bots and web crawlers to not to crawl.
`robots.txt` 
`sitemap.xml`

`Burpsuite` has a sitemap tab that maps the pages you have traversed.

#### Administration Consoles
For a definitive list: [[Web-App-Administration-Consoles]]


#### User Enumeration
To perform client-side exploits against we need to enumerate users. Patterns of names, usernames and emails are important as the underlying technology hosts functionality that presents it on the site or for credentials.


## Web Exploits
Check [[OWASP-top-whatever-historic-definitions]] for more historic definitive listing.


## Authentication Bypass

Type of bypass | Identification 
--- | ---
Authentication bypass | default credentials, flawed credential reset flows
[Forced browsering](https://owasp.org/www-community/attacks/Forced_browsing) | Web connect scanners
Insecure Direct Object References (IDOR) | Openly editable parameter `?id=1` that does verify the requestor changing it

## Session Hijacking
Using some form of cross-site scripting to steal user's session cookie.

## Business Logic Flaws
Flaw in application logic to perform unintended actions.

## Remote Code Execution (RCE)
When an attacker can execute any command on the server. Very bad/good.


## References

[Penetration Testing Execution Standard (PTES)](http://www.pentest-standard.org/index.php/Main_Page)
[OWASP's Web Application Security Testing](https://owasp.org/www-project-web-security-testing-guide/)
[Forced browsering - OWASP](https://owasp.org/www-community/attacks/Forced_browsing)
[Minification Wiki](https://en.wikipedia.org/wiki/Minification_(programming))
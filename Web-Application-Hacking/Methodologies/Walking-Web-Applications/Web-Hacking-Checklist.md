# Web Hacking Checklist

## Walking the Website
Mostly Ippsec inspired - use [[Burpsuite-Helpsheet]]
0. `curl -L $url` for grepping 
1. Check the Certificate - Contains email address
2. Quick check for url: /index.(htlm/php)
3.  `Ctrl + U` for source code
	1. Check if page is Static or Dynamic
4. Search `Ctrl + F` for languages
5. Check Cookies
6. Inspect Elements
7. Request functionality
8. Check for CMS and google dork it and its version on site  - README.md
9. Check for API
10. Default Credentials in Login pages
11. CSRF tokens
12. Change Request Types

In the Background

Fuzz for:
1. Subdomains if there is a domain name
2. Fuzz Directories for RCE injectable files
3. Fuzz Parameters for [[OWASP-Top-10-Historic-Definitions]]
4. Fuzz for [[SQLInjection]]


If you get banned Directory Busting, [[Bypassing-Rate-Limits]]

Note and test:
User suppliable input - Login forms, Search bars, Comment sections
Parameters

## Once Authenticated Enumerate:
[[Haddix-Methodology]]
1. My profile Section
2. Integration Functions
3. Paid Account Functions
4. Published / used Authenicated API Calls
5. Upload / Export Functions
6. Undocumentated API CAlls and Admin tools
7. Multiple User Levels
8. Customer Data 
9. Persistent User Input


## References
[NahamCon2022 - Jason Haddix BBHM - AA](https://www.youtube.com/watch?v=HmDY7w8AbR4) 
[THM Room](https://tryhackme.com/room/walkinganapplication)
[IppsecRocks](https://ippsec.rocks/)
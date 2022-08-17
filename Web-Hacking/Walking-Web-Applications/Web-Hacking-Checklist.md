# Web Hacking Checklist

## Walking the Website
Mostly Ippsec inspired - use [[Burpsuite-Helpsheet]]
1. Check the Certificated - Contains email address
2. Quick check for url: /index.(htlm/php)
3. Check source for if page is Static or Dynamic
5. Search `Ctrl + F` for languages
6. Check Cookies
7. Inspect Elements
8. Request functionality
9. Check for CMS and google dork it and its version on site  - README.md
10. Check for API
11. Default Credentials in Login pages
12. CSRF tokens


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
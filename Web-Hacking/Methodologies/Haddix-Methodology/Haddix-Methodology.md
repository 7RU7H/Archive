# Bug Hunter Methodology 
For [[Application-Analysis]] by Jason Haddix follow the aforementioned link.
Link all talks
[]()

# Disclaimer
This is just my notes of the talks mentioned above. These notes were taken to further my research in bug hunting and ethical hacking.

# Books/Articles to read
Get: 
OWASP testing guide
The Web application hacker's handbook 2



# Discovery
Go the road less traveled:
1. subdomains
1. obscure webservers
1. find acquisitions especially new acquisition 
1. functionality changes or redesigns
1. mobile websites
1. new mobile app versions

# OSINT

recon-ng

READ previous bug bounties on a specific company:
they appear in lots of places and gives you understanding about the targe

`nmap -sS -A -PN -p- --script=http-title ip`

raftlists for bruteforcing directories
remember to continue to bruteforce directories afterwards!

github.com/intrigueio.intrigue-core

rsnakes xss cheatsheat
ash javed xxs research 
mathias karlsson xxs

xss observations:
customizable themes and profiles via css
event or meeting names
URI based
imported from a 3rd party 
json post values (check returning content type)
file upload names
uploaded file (swf, HTML ++
custom error pages
take params ?realparam=1&foo=bar'+alert(/xss/)+
login and forgot password forms

swf parameter xss:
common params:
onload, allowedDomain, movieplayer, xmlPath, eventhandler, callback (see owasp page)
common injection strings:
\%22})))}catch(e)alert(document.domain);}//
"];)catch(e)()if(!self.a)self.a=!alert(document.domain);//
"a")(((type:"ready")));)catch(e)alert(1))//

github: cure53/Flashbang


sql injection observations

id
currency values
item number values
sorting parametres (i.e order, sort, etc
json and xml values
cookie values
custom headers (look for possible integration with cdn's or waf's)
REST based services

Liffy github

file=
location=
locale=
path=
display=
load=
read=
retrieve=

Saroush Dali's file upload presentation 

remote file includes and redirects

# Common blacklist bypasses
```php
escape "/" with "\/" or "//" with "\/\/"
try single "/" instead of "//"
remove http i,e "continue=//google.com"
"/\/\","|/", "/%09/"
encode.slashes
"./" CHANGE TO "..//"
"./" CHANGE TO "....//"
"/" CHANGE TO "//"
```

dest=
continue=
redirect=
url=
url=
window=
next=

remote file includes and redirects
```php
File=
Folder=
Path=
style=
template=
php_path=
doc=
document=
root=
pg=
pdf=
```

CSRF bypasses
Common bypasses
Remove CSRF token from the request
Remove CSRF token parametre value
Add bad control chars to CSRF parametre value
Use a second identical CSRF parametre
Change POST to GET

github burpy
finding csrf


github BurpExtension/csrfr_token_detector.py

burp store -> autorize


# Find Privilege 
Add user function
Delete user function
start project/campaign/etc function
change account info(pass, CC, etc) functoin
customer analytics view
any view!! with PII on it

Transport

github arvinddorraiswamy/mywebappscripts/tree/master/ForceSSL

# Find Logic Flaws
substituting hashed parametres
step mainuplation
use negatives in quantities
authentication bypass
application level DoS
Timing attacks
# Application Analysis
[NahamCon2022 - Jason Haddix BBHM - AA](https://www.youtube.com/watch?v=HmDY7w8AbR4)

# Disclaimer
This is just my notes of the talk mentioned above. These notes were taken to further my research in bug hunting and ethical hacking.

# Mental Hurdles

1. Client Reputation - Care of your biases, be humble, be bold to find bugs.
2. Pre-Testing - There are still bugs and will always be bugs if you don't find anything you will learn 
3. Size - Templification exists
4. IT'S X! A Self-Hosted, OSS, COTS...- There be bugs, if don't look you won't find them! 
5. Only Touching The Surface - Push through Authentication 
	1. My profile Section
	2. Integration Functions
	3. Paid Account Functions
	4. Published / used Authenticated API Calls
	5. Upload / Export Functions
	6. Undocumentated API CAlls and Admin tools
	7. Multiple User Levels
	8. Customer Data 
	9. Persistent User Input


# Pre-manual Testing and Automation

## Testing Layers
Open Ports Services
Web Hosting Sofware
Application Framework
Application: Custom Code or Custom Off-the-Shelf Software
Application Libraries
Integrations

## Tech Profiling
[Wappalyzer](https://www.wappalyzer.com/)
[WhatRuns](https://www.whatruns.com/)
[Webanalyze](https://github.com/rverton/webanalyze)

## Finding CVE's and Misconfigs
#### Nuclei

[Nuclei](https://github.com/projectdiscovery/nuclei) - [[Nuclei]] cheatsheet locally




[Kali](https://www.kali.org/tools/nuclei/)
```bash
sudo apt install nuclei # Kali
```

Templating making is good for NEW bugs if you can template.

#### GoFingerprint
[GoFingerprint](https://github.com/Static-Flow/gofingerprint)
GoFingerprint helps quickly indentify web servers by checking their HTTP responses against a user defined list of fingerprints. Whether it's trying to determine which servers in your recon set are bootspring or testing for a specific response from a payload, gf is the tool for you!

#### Sn1per (PAID)
[Sn1per](https://github.com/1N3/Sn1per)
Attack Surface Management Platform

#### Intrigue-core (Mandiant Limited Open Source)
[intrigue-core](https://github.com/intrigueio/intrigue-core)
Intrigue project is no longer actively maintained. Discover Your Attack Surface!

#### Jaeles
[jaeles](https://github.com/jaeles-project/jaeles)
Jaeles is a powerful, flexible and easily extensible framework written in Go for building your own Web Application Scanner. This project was part of [Osmedeus Engine](https://github.com/j3ssie/osmedeus).

#### Retire.js
[retire.js](https://github.com/RetireJS/retire.js) a scanner detecting the use of JavaScript libraries with known vulnerabilities.

#### Vulners (Priced - Free version no API calls)
[Vulners](https://vulners.com/plugins)

#### Important Tip
1. Sometimes the beaten path extends to tools too, so use them but dive deep.


## Port Scanning
#### Naabu

[Naabu](https://github.com/projectdiscovery/naabu) and [kali Naabu](https://www.kali.org/tools/naabu/)

## Content Discovery
Contents
1. Based on tech
1. COTS/PAID/OSS
1. Custom
1. Historical
1. Recursive
3. Mobile APIs
4. Change Detection

#### Tips

1. Find these:
	1. Configurations files for database connection
	1. Where the admin login and route/endpoints are located
1. Recursively Bruteforce Content Discovery of your Target 
1. Do the above but with **mobile version** [apkleaks](https://github.com/dwisiswant0/apkleaks) 
1. Changes! Stay updated via
	1. Newletters
	2. Affiliate Programs
	3. Googling Conference Talks
	4. Monitoring the domain for code changes

#### Content Discovery Tools
In no particular order
1. [Gobuster](https://github.com/OJ/gobuster) - [[Gobuster-Cheatsheet]]
1. [ffuf](https://github.com/ffuf/ffuf) - [[FFUF-Cheatsheet]]
1. [Wfuzz](https://github.com/xmendez/wfuzz) - [[WFUZZ]]
1. [Feroxbuster](https://github.com/epi052/feroxbuster) - PAUSABLE AND EDITABLE - [[Feroxbuster]]
1. [TurboIntruder](https://github.com/PortSwigger/turbo-intruder) - Burp plugin

#### Content Discovery Wordlists
Map wordlists to Tech stack.
[Assetnote.Wordlists](https://github.com/assetnote/wordlists)
[Assetnote.io](https://wordlists.assetnote.io/)

#### COTS/PAID/OSS Content Discovery Lists
OSS:
[Source2URL](https://github.com/danielmiessler/Source2URL)
Parse source code directories and output list of URLs that are then sent through a proxy.

COTS/PAID:
Demos? Call for a demo?

#### Custom Content Discovery Lists
Jason uses [Scavenger](https://github.com/0xDexter0us/Scavenger)

#### Historical
[Gau](https://github.com/lc/gau)
```bash
echo $domain | gau | wordlistgen | sort -u
```
Fetch known URLs from AlienVault's Open Threat Exchange, the Wayback Machine, and Common Crawl.

**UNSPAMIFY THE OUTPUT**

[wordlistgen](https://github.com/ameenmaali/wordlistgen)
`wordlistgen` is a tool to pass a list of URLs and get back a list of relevant words for your wordlists. Wordlists are much more effective when you take the application's context into consideration. `wordlistgen` pulls out URL components, such as subdomain names, paths, query strings, etc. and spits them back to stdout so you can easily add them to your wordlists

[trashcompactor](https://github.com/michael1026/trashcompactor)
Simple Go program to remove URLs with duplicate functionality based on script resources included. The theory behind this being if two pages include the same five scripts, they most likely have the same functionality.

#### Application Analysis
How does the app pass data?

```url
resource?parameter=value&param2=value
Methods -> /route/resource/subresource/... # rest
```

How/where does the app talk about users?
	How? 
		UID, email, username, UUID
	Where? 
		Cookies, API Calls?

Does the site have multi-tenacy or user levels?
	App is designed for multiple customers?
	App has multiple user levels - 
		Admin (cms/framework)
		Account Admin
		Account User
		Account View
		Unauthenticated functionality
		
Does the site have a unique threat model?
	API keys
	Application data for doxing
	
Has there been past security research & vulnerabilities?
	Similar devs make similar bugs
	
How does the app handle?
	XSS - output encoding of special characters 
				-> dork/research the framework protections
	CSRF - How generally THEN how custom code handles it!
	Code Injection - Input sanitization


## Spidering
ZAP and BURP Or [Hakrawler](https://github.com/hakluke/hakrawler) or [Gospider](https://github.com/jaeles-project/gospider).

## Javascript parsing
[xnLinkFinder](https://github.com/xnl-h4ck3r/xnLinkFinder)
[GAP](https://github.com/xnl-h4ck3r/burp-extensions)(Burp Extension!)

Tips:
Minified and obfuscated code manually can de-\* with https://beautifier.io, tool are beeing developed

## Heatmapping 
Locations where bad things normally happen or may indicate interesting places to explore.

**Jason Haddix's Heatmapping mindmap**

1. Upload Functions
	1. Integration from a 3rd party
		1. XSS
	2. Self uploads
		1. XML based
			1. SSRF
			2. XSS
		1. Image
			1. XSS Shell
				1. Name
				2. Binary header
				3. Metadata
	3. Where is the data stored
2. Content types
	1. Look for multipart-forms 
	1. Look for content-type XML
	1. Look for content type json
3. APIs
	1. Methods
4. Account Selection
	1. Profile
		1. Stored XSS
	1. App Custom Fields
	1. Integrations
		1.  SSRF
		2.  XSS
5. Errors
	1. What causes errors?
	2. What information does the error code disclose

## Paramater Analysis
Unmaintained : [HUNT](https://github.com/bugcrowd/HUNT) 

XSSed.com or Hackerone.com Discloures

[GF](https://github.com/tomnomnom/gf)

BurpBounty(Paid)
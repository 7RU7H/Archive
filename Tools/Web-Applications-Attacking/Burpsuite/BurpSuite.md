# BurpSuite

## Important Notice

Warning with recent changes - [Portswigger](https://portswigger.net/burp/documentation/desktop/settings) - December the 15th 2022

They now added a `Burp -> Settings` and all the `Project options`, `User options` that are listed below as such and instructions are now in a Windows with there own search bar! Thank you for change this insane UI nightmare of lists of scroll-able settings. Some of the tricks here are still useful, but it does mean that you now you just search for the settings you need to change.

Prior to the disclaimer...

This is not a full detailed guide of how to use Burp Suite more a selection of tricks and tips, for **Community Version Only**. It not really a cheatsheet and more a sheet of helpful stuff. There are full courses of how to use this available from Portswigger, but their are also massive amounts of free resources and relatively cheap resources to learn and practice from. This Helpsheet is more just shortcuts, but is intended to make available some of the functionality you may require extract from GUI menu to a scenario:   
> *Problem X -> Do this with Burpsuite (plus another applications)*  

It is also not a showcase of plugins I like or support.  
Some of the tips very simple for simple problems, sometimes that is simply required.

## Introduction

[THM](https://tryhackme.com/room/burpsuitebasics): *"Burp Suite is a Java-based framework designed to serve as a comprehensive solution for conducting web application penetration testing. It has become the industry standard tool for hands-on security assessments of web and mobile applications, including those that rely on application programming interfaces (APIs)."*

For the [Official Documentation](https://portswigger.net/burp/documentation/desktop) 
For article on the [[BurpSuite-Pro-Version]]

#### Features

- Proxy: intercept and modify requests and responses
	- Logging
		- HTTP History Sub-Tab
		- Web Sockets Sub-Tab
	- Web Socket support
	- Match and Replace
		- Use [[Regular-Expressions]] to modify incoming and outgoing requests
- Repeater: capturing, modifying and re-sending a request
- Intruder: Rate-limited (Community version) endpoint spraying tool
	- Positions: select attack type and configure payload within the request with the `§` symbol
	- Payloads: value configuration of payload
		- Payload sets
			- Payload set for the number of set(s) of payloads
			- Payload type
		- Payload settings
			- Load or Paste payloads into selected Payload type 
		- Payload processing
			- Add, Edit, Define and prioritise rules to perform processing tasks  
		- Payload encoding
	- Resource Pool: Automation configure a feature of [[Burpsuite-Pro-Version]]
	- Settings: configure attack behaviour and Burp Suite's result handling
- Decoder: Decodes data
- Comparer: compares two data streams at the word or byte level
- Sequencer: assess token randomness

Other Tabs:
- Target
	- Site map
		- Maps web applications base on links, form and visited pages
		- Issues definitions 
			- [[Burpsuite-Pro-Version]] vulnerability scan
		- Scope settings
			- Scope via enabling include or exclude specific domains and IP addresses


#### Key binds

|Shortcut|Tab|
|---|---|
|`Ctrl + Shift + D`|Dashboard|
|`Ctrl + Shift + T`|Target tab|
|`Ctrl + Shift + P`|Proxy tab|
|`Ctrl + Shift + I`|Intruder tab|
|`Ctrl + Shift + R`|Repeater tab|

# Cool things for the `cmd` more

- Builtin Browser, never setup the burp certificate with your own browser every again!
Go to `Project settings -> no sandbox for builtin browser`

## FoxyProxy / Firefox proxy

Firefox menu -> Settings -> Network Settings click Settings
Select manual proxy configuration:
	HTTP proxy: 127.0.0.1 8080
	uncheck: Also use this proxy for FTP and HTTPS 
	delete: ANYTHING in the "No proxy for" field

## Burp Suite CA

To intercept and analyse HTTPS traffic, BS has Certificate Authority and uses it to issue on-the-fly certificates for each website that we visit and pass through Burp.

http://burp -> CA Certificate 
save the file cacert.der to `/home/<user>/Downloads`
GOTO Certificate manager in Firefox -> Import it!

## Bypassing Proxy for (some) HTTPS Traffic

`Proxy -> Options -> TLS Pass Through -> Add`

Need pass through for:
- Targeting
- Required mutual authentication or HTTP Public Key Pinning

## Bypass intercepting HTTPS traffic by configuration to forward traffics towards websites without decryption and re-encrypting them first.

## SOCKS Proxy in Burp

`User options -> SOCKS Proxy -> 127.0.0.1 & port number` then tick the `Use Proxy`

## Too much data -> Add Scope to include/exclude

`Target -> Scope -> Target scope`, to add manually or 
right click and add under main `Target Site map` tab.

## How is the site structured -> Sitemap

`Target -> Site map` Click the `>` and view in tree form.

## "Bad Request This combination of host and port requires TLS" -> Read Url

Use https in URL you fool!

## Software is preventing site X browser from connecting -> Setup certificates in browser

Goto the very good visual guide on [THM](https://tryhackme.com/room/burpsuitebasics) - Task 10.

## Burp Intercepting Everything -> use the embedded Browser

If you do not want manage proxys on host OS or inside a browser, just use the embedded browser. Goto
`Project options -> Misc -> Embedded Browser` and check the  `Allow the embedded browser to run without a sandbox`.

**This is a solution to a problem I have yet to encounter but is here to solve a problem at a later date**
```
SSL/TLS  -> SSL pass through feature
[official-ps/blog/ssl-pass-through](https://portswigger.net/blog/ssl-pass-through-in-burp)
```

## Shortcuts

For customisation go to `User Options > Misc > Edit Hotkeys`, for default shortcuts:

**Navigation**

Shortcut | Function  
--- | ---
`Ctrl + Shift + D` | Switch to the Dashboard  
`Ctrl + Shift + T`   |  Switch to the Target tab  
`Ctrl + Shift + P   ` | Switch to the Proxy tab  
`Ctrl + Shift + I   ` | Switch to the Intruder tab  
`Ctrl + Shift + R   ` | Switch to the Repeater tab

**Proxy**

Shortcut | Function  
--- | ---
`Ctrl + F` | Forward an intercepted message
`Ctrl + L` | Drop an intercepted message
`Ctrl + D` | Delete an intercepted message

## Intruder Payloads

- Recursive Grep = allows extract each paylaod from the response to the previous request - useful when you need to extract useful data or deliever an exploit 

## Need to Spoof your IP in burp?
- `Proxy -> Option -> Match and Replace`
-  Requires you to find a custom IP Header
	1. Leave Match field empty
	2. In the Replace field: `X-Forwarded-For: 127.0.0.1`

[Match and Replace](https://portswigger.net/burp/documentation/desktop/tutorials/using-match-and-replace): "*Note: In the wild, the de-facto standard header `X-Forwarded-For` is often used for this purpose, but you may encounter websites that use different custom headers. These are normally applied to your requests by an intermediary server, such as a load balancer or other reverse proxy belonging to a CDN, for example.*"

[r3d-buck3t Medium Article](https://medium.com/r3d-buck3t/bypass-ip-restrictions-with-burp-suite-fb4c72ec8e9c)

## Can't get a page you fuzzed?
- `Proxy -> Option -> Match and Replace`
	1. Change Type: Responder Header
	2. Leave Match field: `Location: AnnoyingPage.Lang`
	3. In the Replace field: empty

## Intruder Success

- Location Response Header?
- Unique Response Size

## References

[Official Documentation](https://portswigger.net/burp/documentation/desktop)
[THM Burpsuite basics](https://tryhackme.com/room/burpsuitebasics)
[official-ps/blog/ssl-pass-through](https://portswigger.net/blog/ssl-pass-through-in-burp)
[cybrary](https://www.cybrary.it/blog/burp-suite-tutorial-part-2-essential-shortcuts-in-burp-suite-proxy-for-more/)
[Match and Replace](https://portswigger.net/burp/documentation/desktop/tutorials/using-match-and-replace)
[r3d-buck3t Medium Article IP bypassing](https://medium.com/r3d-buck3t/bypass-ip-restrictions-with-burp-suite-fb4c72ec8e9c)

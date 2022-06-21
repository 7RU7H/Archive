# Burpsuite
This is not a full detailed guide of how to use burpsuite more a selection of tricks and tips. It not really a cheatsheet and more a sheet of helpful stuff. There are full courses of how to use this avaliable from Portswigger, but their are also massive amounts of free resources and relatively cheap resources to learn and practice from. This Helphsheet is more just shortcuts, but is intended to make avaliable some of the functionality you may require extract from GUI menu to a scenario:   
*Problem X -> Do this with Burpsuite(plus another applications)*  
It is also not a showcase of plugins I like or support.  
Some of the tips very simple for simple problems, sometimes that is simply required.

[Official Documentation](https://portswigger.net/burp/documentation/desktop)

# Cool things for the cmd [more]
- Builtin Browser, never setup the burp certifact with your own browser every again!
	GOTO Project settings -> no sandbox for builtin browser


# FoxyProxy/Firefox proxy
Firefox menu -> Settings -> Network Settings click Settings
Select manual proxy configuration:
	HTTP proxy: 127.0.0.1 8080
	uncheck: Also use this proxy for FTP and HTTPS 
	delete: ANYTHING in the "No proxy for" field

## Burp Suite CA
To intercept and analyze HTTPS traffic, BS has Certificate Authority and uses it to issue on-th-fly certifactes for each website that we visit and pass through Burp.

http://burp -> CA Certificate 
save the file cacert.der to `/home/<user>/Downloads`
GOTO Certificate manager in Firefox -> Import it!

## Bypassing Proxy for (some) HTTPS Traffic

Proxy -> Options -> TLS Pass Through -> Add

Need pass through for:
- Targeting
- Required mutual authenication or HTTP Public Key Pinning
## Bypass intercepting HTTPS traffic by configurating to forward traffics towards websites without decrypting and re-encrypting them first.

## SOCKS Proxy in Burp
User option in Burp Suite -> SOCKS Proxy -> 127.0.0.1 & port number

## Too much data -> Add Scope to include/exclude
`Target -> Scope -> Target scope`, to add manually or 
right click and add under main `Target Site map` tab.

## How is the site structured -> Sitemap
`Target -> Site map` Click the `>` and view in tree form.
## "Bad Request This combination of host and port requires TLS" -> Read Url
Use https in url you fool!

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

## References

[Official Documentation](https://portswigger.net/burp/documentation/desktop)
[THM basics](https://tryhackme.com/room/burpsuitebasics)
[official-ps/blog/ssl-pass-through](https://portswigger.net/blog/ssl-pass-through-in-burp)
[cybrary](https://www.cybrary.it/blog/burp-suite-tutorial-part-2-essential-shortcuts-in-burp-suite-proxy-for-more/)
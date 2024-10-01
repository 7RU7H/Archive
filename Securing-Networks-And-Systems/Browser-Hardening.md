# Browser Hardening

Browser Hardening is difficult. The Browser has lots of vectors of exposure and is powerful tool in the hands of everyone. 

Problem scope
- Developers probably must compete across most devices and architectures
 - [[JavaScript]]
 - Many sites require credentials
 - Global incentivisation data harvesting - leads to tracking, browser fingerprinting, 


- Routing
	- [[DNS]], [[DoH]]
- Browsing
- Extensions
- Downloading
- Uploading
- Client-Side Rendering
	- Client Side attacks involve XML, JavaScript  from rendering Documents
- As a process on your machine
	- Memory corruption vulnerability
- As binary that uses libraries, drivers on your machine
	- [[Software-Supply-Chain-Attacks]] on dependencies 

Future concerns:
- AI Client-side integrations 



Alternate and referenced guides on Browser Hardening
- [brainfucksec.github.io Firefox Hardening Guide](https://brainfucksec.github.io/firefox-hardening-guide)


- Do you just want skip questions and use a one, just a popular browser? - Do so
- Do you mind Hardening Multiple Browsers?
	- It can be good to cultivate alternatives if the developers decide to implement something you do not like
	- Browser Containerisation functionality might not be for everyone
	- [[OPSEC]] of a different browser for compartmentalising activity
- Is Browser Privacy important to you?
	- [[Privacy]] just and probably only will have a link to [awesome-privacy/Lissy93](https://github.com/Lissy93/awesome-privacy?tab=readme-ov-file#browsers) (this will link to the Browsers section)
- Is the scope of work such that it requires a browser such that it needs to be containerised?
	- [[KASM-Workspaces]], there are also others - beware trading browser for docker misconfigurations  


Browsing Patterns of User(base)
- Consider yourself and whether and what links you [[click-the-link]]
- Browser Containerisation functionality or Different Browser for different things

[[DNS]]
- Prevent DNS Hijacking with [Wikipedia - DNS over HTTPS](https://en.wikipedia.org/wiki/DNS_over_HTTPS)





XML 

JavaScript
- [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/) can per site basis block JavaScript

Browser Software
- Patching your machine and the browser regularly
- Is JavaScript actually required for you browsing experience?
	- By prevent JavaScript from being interpreted on the client side you negate entire classes of vulnerabilities
- Browser Containerisation functionality

Plugins (including privacy plugins) can be malware, malicious and insidiously benign too
- [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/) is very powerful and popular
	- [YouTube Ippsec's uBlock Origin Blocking Content rule demo](https://www.youtube.com/watch?v=Qzb1j-L1n7o)

Local configuration

Credentials for anything
- [[Browser-Credential-Harvesting]] exists - do not store passwords in the browser, both remote and locally

#### Countering Browser Fingerprinting 


Cookies

Tracking CSS



The following is researched from various sources online.
- Minimalism - more means more unique (more privacy focus plugins)
	- Further from the default the more unique
- Considerable configuration
	- [[KASM-Workspaces]]
	- Configuration management and swap out
		- Having multiple almost similar configurations that you rotate every time you open the browser

[brainfucksec.github.io Firefox Hardening Guide](https://brainfucksec.github.io/firefox-hardening-guide) recommends Browser leak testing for measuring your Browser configuration's unique:
- [https://coveryourtracks.eff.org/](https://coveryourtracks.eff.org/)
	- PDF Guide on uniqueness  https://coveryourtracks.eff.org/static/browser-uniqueness.pdf
- [https://www.amiunique.org/](https://www.amiunique.org/)
	- [amiunique FAQ](https://www.amiunique.org/faq)
- [https://browserleaks.com/](https://browserleaks.com/)
- [https://arkenfox.github.io/TZP/tzp.html](https://arkenfox.github.io/TZP/tzp.html)

Further resources
[mozilla.org - Firefox protection against fingerprinting](https://support.mozilla.org/en-US/kb/firefox-protection-against-fingerprinting)




## References

[awesome-privacy/Lissy93](https://github.com/Lissy93/awesome-privacy?tab=readme-ov-file#browsers)
[brainfucksec.github.io Firefox Hardening Guide](https://brainfucksec.github.io/firefox-hardening-guide)
[https://coveryourtracks.eff.org/](https://coveryourtracks.eff.org/)
[https://www.amiunique.org/](https://www.amiunique.org/)
[https://browserleaks.com/](https://browserleaks.com/)
[https://arkenfox.github.io/TZP/tzp.html](https://arkenfox.github.io/TZP/tzp.html)
[YouTube Ippsec's uBlock Origin Blocking Content rule demo](https://www.youtube.com/watch?v=Qzb1j-L1n7o)
[https://coveryourtracks.eff.org/ PDF Guide on uniqueness](https://coveryourtracks.eff.org/static/browser-uniqueness.pdf)
[amiunique FAQ](https://www.amiunique.org/faq)
[mozilla.org - Firefox protection against fingerprinting](https://support.mozilla.org/en-US/kb/firefox-protection-against-fingerprinting)

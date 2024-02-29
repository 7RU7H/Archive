# Phishing Infrastructure

## Domain Name 
Register either an authentic-looking domain name or one that mimics the identity of another domain. 

- Expire Domains - Spam filters do not trust new domain names compared to historic data about one
- Typosquatting:
	- Misspelling: goggle.com Vs google.com
	- Additional Period: go.ogle.com Vs google.com
	- Switching numbers for letters: g00gle.com Vs google.com
	- Phrasing: googles.com Vs google.com
	- Additional Word: googleresults.com Vs google.com
- TLD Alternatives
- IDN Homograph Attack/Script Spoofing
	- Use non Latin chacerts a-z0-9 -> language-specific script of alphabet from other languages 
	- unicode U+0430 looks identical to U+0061


## SSL/TLS Certificates

Creating SSL/TLS certificates for your chosen domain name, equating to more authenticity. See [[SSL-TLS]]

## Email Server/Account 
Email server or register with an SMTP email provider. 

DNS Records: Setting up DNS Records such as SPF, DKIM, DMARC will improve the deliverability of your emails(to inbox instead of spam) 

Web Server: webservers or purchase web hosting to host your phishing websites. Adding SSL/TLS to the websites will give them an extra layer of authenticity. 

Analytics: Keeping analytics information is important when red teaming:
		keep track of the emails that have been sent, opened or clicked. 
		which users have supplied personal information or downloaded software from the server

Automation And Useful Software: Automate with:
	GoPhish - (Open-Source Phishing Framework) - getgophish.com
	SET - (Social Engineering Toolkit) - trustedsec.com

source:https://mediatemple.net/community/products/all/204643950/understanding-an-email-header


## References

[THM Red Team Phishing Room](https://tryhackme.com/room/phishingyl)
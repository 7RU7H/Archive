# Phishing Writing Phishing Emails

## How to write the good phish
Three ingredients: Sender Address, Subject matter, Content

#### The Sender's Address:

Ideally, the sender's address would be from a domain name that spoofs:
- Significant brand, known contact, coworker, friend or family they communicate with over social media
- Local business used by the target - the "You ordered a pizza let me in the building please"
- Business Suppliers
-  Looking at LinkedIn to find coworkers of the victim.


To find what brands or people a victim interacts with, you can employ OSINT (Open Source Intelligence) tactics. For example:
    Observe their social media account for any brands or friends they talk to.
- [[Search-Engine-Dorking]] names, locations and any traceable online data trail - written, audio or video content by individual
-  Business website suppliers or known contractual arrangements


####  The Subject:

You should set the subject to something quite urgent, worrying, or piques the victim's curiosity, so they do not ignore it and act on it quickly.
Examples of this could be:

1. Your account has been compromised.
1. Your package has been dispatched/shipped.
1. Staff payroll information (do not forward!)
1. The IT Administrator requires your password to access your account to retrieve corrupted data.
1. Your photos have been published.
 1. Your Account was found on list of compromised account pl4ease change your password 

#### The Content:
Research the impersonation: company and/or contact or co-worker
- Standard Email Template with Branding, logo's images, signoff
- Linguistic impersonation: lexical, syntactic

If you've set up a spoof website to harvest data or distribute malware, the links to this should be disguised using the anchor text, clickable link
Change it either to some text which says "Click Here" or changing it to a correct looking link that reflects the business you are spoofing, for example:
`<a href="http://spoofsite.thm">Click Here</a>`
`<a href="http://spoofsite.thm">https://onlinebank.bad</a>


## References

[THM Red Team Phishing Room](https://tryhackme.com/room/phishingyl)
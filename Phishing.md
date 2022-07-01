Phishing 101 

############
# Contents:
#
# How to write the good phish


# How to write the good phish
Three ingredients: Sender Address, Subject matter, Content

The Sender's Address:

Ideally, the sender's address would be from a domain name that spoofs:
	Significant brand, 
	Known contact
	Or a coworker. 

To find what brands or people a victim interacts with, you can employ OSINT (Open Source Intelligence) tactics. For example:
    Observe their social media account for any brands or friends they talk to.
    Searching Google for the victim's name and rough location for any reviews the victim may have left about local businesses or brands.
    Looking at the victim's business website to find suppliers.
    Looking at LinkedIn to find coworkers of the victim.

The Subject:

You should set the subject to something quite urgent, worrying, or piques the victim's curiosity, so they do not ignore it and act on it quickly.
Examples of this could be:

    Your account has been compromised.
    Your package has been dispatched/shipped.
    Staff payroll information (do not forward!)
    Your photos have been published. 

The Content:
Research the impersonation: company and/or contact or co-worker
	Standard Email Template with branding Logos, signoff
	Linguistic impersonation: lexical, syntactic

If you've set up a spoof website to harvest data or distribute malware, the links to this should be disguised using the anchor text, clickable link
Change it either to some text which says "Click Here" or changing it to a correct looking link that reflects the business you are spoofing, for example:
<a href="http://spoofsite.thm">Click Here</a>
<a href="http://spoofsite.thm">https://onlinebank.thm</a>


###  Good Phishing Infrastructure

Domain Name: register either an authentic-looking domain name or one that mimics the identity of another domain.
SSL/TLS Certificates: Creating SSL/TLS certificates for your chosen domain name, equating to more authenticity 
Email Server/Account: Email server or register with an SMTP email provider. 
DNS Records: Setting up DNS Records such as SPF, DKIM, DMARC will improve the deliverability of your emails(to inbox instead of spam) 
Web Server: webservers or purchase web hosting to host your phishing websites. Adding SSL/TLS to the websites will give them an extra layer of authenticity. 
Analytics: Keeping analytics information is important when red teaming:
		keep track of the emails that have been sent, opened or clicked. 
		which users have supplied personal information or downloaded software from the server
Automation And Useful Software: Automate with:
	GoPhish - (Open-Source Phishing Framework) - getgophish.com
	SET - (Social Engineering Toolkit) - trustedsec.com





source:https://mediatemple.net/community/products/all/204643950/understanding-an-email-header
How to analyze an email header

CAUTION:

It is important to know that when reading an email header every line can be forged, 
SO only the Received: lines that are created by your service or computer should be completely trusted.

From 		This displays who the message is from, 
		however, 
		this can be easily forged and can be the least reliable.

Subject 	This is what the sender placed as a topic of the email content.

Date		This shows the date and time the email message was composed.

To		This shows to whom the message was addressed, 
		but may not contain the recipient's address.

Return-Path	The email address for return mail. This is the same as "Reply-To:".

Envelope-To	This header shows that this email was delivered to the mailbox 
		of a subscriber whose email address is user@example.com.

Delivery Date	This shows the date and time at which the email was 
		received by your (mt) service or email client.

Received	The received is the most important part of the email header 
		and is usually the most reliable. They form a list of all the 
		servers/computers through which the message traveled in order to reach you.

The received lines are best read from bottom to top. 
The first "Received:" line is your own system or mail server. 
The last "Received:" line is where the mail originated. Each mail system has their own style of "Received:" line. A "Received:" line typically identifies the machine that received the mail and the machine from which the mail was received.

Dkim-Signature & Domainkey-Signature

These are related to domain keys which are currently not supported by (mt) Media Temple services. You can learn more about these by visiting: http://en.wikipedia.org/wiki/DomainKeys.

Message-id	A unique string assigned by the mail system when the message is first created. These can easily be forged.

Mime-Version

Multipurpose Internet Mail Extensions (MIME) is an Internet standard that extends the format of email. Please see http://en.wikipedia.org/wiki/MIME for more details.

Content-Type	Generally, this will tell you the format of the message, such as html or plaintext.

X-Spam-Status	Displays a spam score created by your service or mail client.

X-Spam-Level	Displays a spam score usually created by your service or mail client.

Message Body	This is the actual content of the email itself, written by the sender.

Finding the Original Sender

The easiest way for finding the original sender is by looking for the X-Originating-IP header. This header is important since it tells you the IP address of the computer that had sent the email. If you cannot find the X-Originating-IP header, then you will have to sift through the Received headers to find the sender's IP address. In the example above, the originating IP Address is 10.140.188.3.

Once the email sender's IP address is found, you can search for it at http://www.arin.net/. You should now be given results letting you know to which ISP (Internet Service Provider) or webhost the IP address belongs. Now, if you are tracking a spam email, you can send a complaint to the owner of the originating IP address. Be sure to include all the headers of the email when filing a complaint.

Spam - unsolicited junk emails sent out in bulk to a large number of recipients. The more malicious variant of Spam is known as MalSpam.
Phishing -  emails sent to a target(s) purporting to be from a trusted entity to lure individuals into providing sensitive information. 
Spear phishing - takes phishing a step further by targeting a specific individual(s) or organization seeking sensitive information.  
Whaling - is similar to spear phishing, but it's targeted specifically to C-Level high-position individuals (CEO, CFO, etc.), and the objective is the same. 
Smishing - takes phishing to mobile devices by targeting mobile users with specially crafted text messages. 
Vishing - is similar to smishing, but instead of using text messages for the social engineering attack, the attacks are based on voice calls. 

source:https://www.proofpoint.com/us/threat-reference/business-email-compromise
What is BEC?

Business email compromise (BEC) is a type of email cyber crime scam in which an attacker targets a business to defraud the company. Business email compromise is a large and growing problem that targets organizations of all sizes across every industry around the world. BEC scams have exposed organizations to billions of dollars in potential losses.

Email account compromise (EAC), or email account takeover, is a related threat that is accelerating in an era of cloud-based infrastructure. EAC is often associated with BEC because compromised accounts are used in a growing number of BEC-like scams (though EAC is also the basis of other kinds of cyber attacks).

BEC and EAC are difficult to detect and prevent, especially with legacy tools, point products and native cloud platform defenses.

Email Security – Defanging URLs

When sending the contents of an artifact within an email notification, any web and IP addresses are automatically “defanged” to prevent the user from inadvertently clicking a malicious link.
The following occurs when URLs are defanged:

    “http” is replaced with “hxxp”
    “ftp” is replaced with “fxp”
    Brackets are added to domain names; for example, www.example.com is replaced with www[.]example[.]com
    Brackets are added to the IP address; for example, 8.8.8.8 is replaced with 8[.]8[.]8[.]8

You may have a number of legitimate domains that you do not wish to be defanged. In this case, you can create a whitelist that allows the specific domains to remain untouched. To see the current setting of the whitelist, enter the following command:

sudo resutil configget –key whitelist_defang_domains

Use the following command to create the whitelist. For multiple domains, use a comma (,) as a separator.

sudo resutil configset –key whitelist_defang_domains -svalue ${domain}

The following example adds the example.com and example.org domains to the whitelist:

sudo resutil configset –key whitelist_defang_domains -svalue example.com,example.org


Analysis Collect

Sender email address
Sender IP address
Reverse lookup of the sender IP address
Email subject line
Recipient email address (this information might be in the CC/BCC field)
Date/time
X-Originating-IP from the X-HEADER = Custom headers!
Smtp.mailfrom/header.from
Reply-To
Content-Type 
Content-Disposition = Attachment? Embedded code?
Content-Transfer-Encoding = encryption used..
Any URL links (if an URL shortener service was used, then we'll need to obtain the real URL link)
The name of the attachment
The hash value of the attachment (hash type MD5 or SHA256, preferably the latter)


#### Tools ####

# Headers

Messageheader: https://toolbox.googleapps.com/apps/messageheader/analyzeheader
Message Header Analyzer: https://mha.azurewebsites.net/
Mailheader: mailheader.org

# IPs

IPinfo.io: https://ipinfo.io/


##
CAREFULLY ON SAFE MACHINE: right-click Copy Link Location
##
# URL scanners 

URLScan.io: https://urlscan.io/
Other URLscanners:
https://www.url2png.com/
https://www.wannabrowser.net/

# URL extractor
URL Extractor: https://www.convertcsv.com/url-extractor.htm
CyberChef -> Extract URLs

# URL reputation

Talos File Reputation: https://talosintelligence.com/talos_file_reputation
VirusTotal: https://www.virustotal.com/gui/

# Malware sandbox 

Any.Run: https://app.any.run/ 
Hybrid Analysis: https://www.hybrid-analysis.com/
https://www.joesecurity.org/ # Live Interaction, URL Analysis & AI based Phishing Detection, Yara and Sigma rules support, MITRE ATT&CK matrix, AI based malware detection, Mail Monitor, Threat Hunting & Intelligence, Automated User Behavior, Dynamic VBA/JS/JAR instrumentation, Execution Graphs, Localized Internet Anonymization and many more

# automated phishing analysis 
PhishTool: https://www.phishtool.com/

Techniques:
Attachments
Credential harvesting
HTML to impersonate a legitimate brand
Instill Urgency 
Link Manipulation
Pixel tracking
Recipient is BCCed 			#Blind Carbon Copy 
Spoofed email address 	
URL shortening services 

Fails:

Poor grammar and/or typos


unusual email recipient address
sender details don't match the sender's email address
subject matter to prompt interaction with haste
-> press button to cancel order
but in Email Hyperlinks: show that its nasty link.


tailour to appear to expectations of impersonated sender
tranking number -> is a nasty link.


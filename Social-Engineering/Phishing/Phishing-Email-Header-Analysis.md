# Phishing Email Header Analysis 

**CAUTION:**

It is important to know that when reading an email header every line can be forged, so only the **Received** lines that are created by your service or computer should be completely trusted.

**Beware handling malicious URLs and code!**


Information to collection:

- Sender email address
- Sender IP address
- Reverse lookup of the sender IP address
- Email subject line
- Recipient email address (this information might be in the CC/BCC field)
- Date/time
-  X-Originating-IP from the X-HEADER = Custom headers!
- Smtp.mailfrom/header.from
- Reply-To
- Content-Type 
- Content-Disposition = Attachment? Embedded code?
- Content-Transfer-Encoding = encryption used..
- Any URL links (if an URL shortener service was used, then we'll need to obtain the real URL link)
- The name of the attachment
- The hash value of the attachment (hash type MD5 or SHA256, preferably the latter)


Header | Description
--- | ---
From 	| 	Displays who the message is from this can be easily forged.
Subject  |	Sender set as the topic of the email content.
Date	| 	Date and time the email message was composed.
To  | This shows to whom the message was addressed to, but may not contain the recipient's address.
Return-Path  |	The email address for return mail. This is the same as "Reply-To:".
Envelope-To |	Display whom the email was delivered to the mailbox of a subscriber whose email address is user@example.com.
Delivery Date |	Date and time at which the email was received by your (mt) service or email client.
Received | Very important forms a list of all the servers/computers through which the message traveled in order to reach you.

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


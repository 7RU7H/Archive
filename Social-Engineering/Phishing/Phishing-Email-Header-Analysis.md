# Phishing Email Header Analysis 

## Introduction

Email analysis is the process of data extraction, to expose the email file details and analysis of email header information that contains the email's technical details. With analysis, determination of whether the email contains suspicious/abnormal data can conclude with the decision to perform actions of either filtering/quarantining or delivering the email. The two primary concerns:

-   **Security issues:** Identifying suspicious/abnormal/malicious patterns in emails.
-   **Performance issues:** Identifying delivery and delay issues in emails.

[[Type-]]

**CAUTION:**

It is important to know that when reading an email header every line can be forged, so only the **Received** lines that are created by your service or computer should be completely trusted.

**Beware handling malicious URLs and code!**


Information to collect:

- Sender email address - Do To and From have the same address?
- Sender IP address
- Reverse lookup of the sender IP address
- Email subject line
- Recipient email address (this information might be in the CC/BCC field) - is it a valid address?
- Domain Key and DKIM Signatures 
	- Email signature are provided by email services to identify and authenticate emails
	- These are related to domain keys which are currently not supported by (mt) Media Temple services. You can learn more about these by visiting: http://en.wikipedia.org/wiki/DomainKeys.
- Date/Time
- Message Body	
	- This is the actual content of the email itself, written by the sender.
- X-Originating-IP from the X-HEADER = Custom headers!
- X-Headers
- X-Received
- X-Spam Status
	- Displays a spam score created by your service or mail client.
- X-Spam-Level	
	- Displays a spam score usually created by your service or mail client.
- X-Mailer
- SPF - Server that was used to send the email - Smtp.mailfrom/header.from - Correct server?
- Return Path -  Reply-To -  - Do Reply-To and From have the same address?
- Message-ID - Any malformed values?
	- A unique string assigned by the mail system when the message is first created. These can easily be forged.
- MIME-Version
	- Multipurpose Internet Mail Extensions (MIME) is an Internet standard that extends the format of email. Please see http://en.wikipedia.org/wiki/MIME for more details.
- Content-Type 
	- Generally, this will tell you the format of the message, such as html or plaintext.
- Content-Disposition = Attachment? Embedded code?
- Content-Transfer-Encoding = encryption used..
- Any URL links (if an URL shortener service was used, then we'll need to obtain the real URL link)
- The name of the attachment - Malware?
- The hash value of the attachment (hash type MD5 or SHA256, preferably the latter) - Malware?
- Received 
	The received lines are best read from bottom to top. 
	- The first "Received:" line is your own system or mail server. 
	- The last "Received:" line is where the mail originated. Each mail system has their own style of "Received:" line. 
	- A "Received:" line typically identifies the machine that received the mail and the machine from which the mail was received.

## Tools

**Tool** | **Purpose**
--- | ---
**VirusTotal**  | A service that provides a cloud-based detection toolset and sandbox environment.  
**InQuest** | A service provides network and file analysis by using threat analytics.  
**IPinfo.io** | A service that provides detailed information about an IP address by focusing on geolocation data and service provider.
**Talos Reputation** | An IP reputation check service is provided by Cisco Talos.  
**Urlscan.io** | A service that analyses websites by simulating regular user behaviour.  
**Browserling** | A browser sandbox is used to test suspicious/malicious links.  
**Wannabrowser** | A browser sandbox is used to test suspicious/malicious links.

#### emlAnalyzer

```bash
emlAnalyzer [OPTION]... -i FILE

A cli script to analyze an E-Mail in the eml format for viewing the header,
extracting attachments etc.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        path to the eml-file (is required)
  --header              Shows the headers
  -x, --tracking        Shows content which is reloaded from external
                        resources in the HTML part
  -a, --attachments     Lists attachments
  --text                Shows plaintext
  --html                Shows HTML
  -s, --structure       Shows structure of the E-Mail
  -u, --url             Shows embedded links and urls in the html part
  -ea EXTRACT, --extract EXTRACT
                        Extracts the x-th attachment
  --extract-all         Extracts all attachments
  -o OUTPUT, --output OUTPUT
                        Path for the extracted attachment (default is filename
                        in working directory)
emlAnalyzer -i $path_to_email.eml --header --html -u --text --extract-all
```

#### emailrep

[https://emailrep.io/](https://emailrep.io/) can perform reputation check on the sender address and the address found in the return path.

#### VirusTotal
Use VirusTotal's use the `SEARCH` option to conduct hash-based file reputation analysis after uploading at [https://www.virustotal.com/gui/home/upload](https://www.virustotal.com/gui/home/upload)



## Finding the Original Sender


The easiest way for finding the original sender is by looking for the X-Originating-IP header. This header is important since it tells you the IP address of the computer that had sent the email. If you cannot find the X-Originating-IP header, then you will have to sift through the Received headers to find the sender's IP address. In the example above, the originating IP Address is 10.140.188.3.

Once the email sender's IP address is found, you can search for it at http://www.arin.net/. You should now be given results letting you know to which ISP (Internet Service Provider) or webhost the IP address belongs. Now, if you are tracking a spam email, you can send a complaint to the owner of the originating IP address. Be sure to include all the headers of the email when filing a complaint.

source:https://www.proofpoint.com/us/threat-reference/business-email-compromise

## Business Email Compromise

Business email compromise (BEC) is a type of email cyber crime scam in which an attacker targets a business to defraud the company. Business email compromise is a large and growing problem that targets organizations of all sizes across every industry around the world. BEC scams have exposed organizations to billions of dollars in potential losses.

Email account compromise (EAC), or email account takeover, is a related threat that is accelerating in an era of cloud-based infrastructure. EAC is often associated with BEC because compromised accounts are used in a growing number of BEC-like scams (though EAC is also the basis of other kinds of cyber attacks).

BEC and EAC are difficult to detect and prevent, especially with legacy tools, point products and native cloud platform defenses.

## Defanging URLs

When sending the contents of an artifact within an email notification, any web and IP addresses are automatically “defanged” to prevent the user from inadvertently clicking a malicious link.
The following occurs when URLs are defanged:

    “http” is replaced with “hxxp”
    “ftp” is replaced with “fxp”
    Brackets are added to domain names; for example, www.example.com is replaced with www[.]example[.]com
    Brackets are added to the IP address; for example, 8.8.8.8 is replaced with 8[.]8[.]8[.]8

You may have a number of legitimate domains that you do not wish to be defanged. In this case, you can create a whitelist that allows the specific domains to remain untouched. To see the current setting of the whitelist, enter the following command:

```bash
sudo resutil configget –key whitelist_defang_domains
# Use the following command to create the whitelist. For multiple domains, use a comma (,) as a separator.
sudo resutil configset –key whitelist_defang_domains -svalue ${domain}
# The following example adds the example.com and example.org domains to the whitelist:
sudo resutil configset –key whitelist_defang_domains -svalue example.com,example.org
```

## References


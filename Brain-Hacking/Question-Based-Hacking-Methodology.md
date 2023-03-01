
# Question Based Hacking Methodology



To ensure maintain it functional purose metholody will never contain - question X do Y? Just more Questions to be answered by you! If better format, technology exists to make this less of a list of questions the format should retain textual scriptablity and portablity.  An addition to questions is more supplimentary actionable cognitive enhancement of either a 



For more philsophical Hacking super dense and short article see [[Hacking-The-Thing]] 





What systems are online, but available
Who can connect
What is allowed to connect - type of connection 
What is connected to what
How is it connected
How are you connecting
What permissions do you have
How can use current level of access to get more access




Where can input be provided 
What can be requested

What does the output suggest?
- Error - information disclosure  

What is regular userland purpose
What is does it run
What is network level purpose of connections


## Terminology

Brief disclosure on terminology, if there is a better way I will replace it

#### Intel vs Information:

Intel - Human intelligence data - data made by humans 
Information - Machine information provided by querying machines

Intel - Alice is a Helpdesk operator, Bob requested a password reset 
Information - the user Alice has X SID that then indicates Administrative Group  




- Objectives

- Pre-Network Phase / OSINT

- REDO

	- External expose identification
		- Formatting for email and users?
	- What externally exposed infrastructure exists - Ports, Websites, DNS servers -> Subdomains? Email servers?
	- Domain Names
	- CIDR ranges 
	- Cloud providers
- External Network

- Web
	- Have you pressed `[CTRL + F12]` yet? - Browser `Inspect` does not show HTML encoded characters
	- Does the site provide text to scrap into wordlist?
	- Virtual hosting? 
		- Fuzzable - rate limits?
		- Potential OSINTable VHOST from merging or referenced? 
		- What does the VHOSTing indicate about the technological stack: Subdomains, Containization, Cloud?
			- How is then stacked - bottom up from entry point?
	- Webserver and Website Language
		- Clarify host OS version from webserver version? - Measure twice cut once!
		- Vulnerable Lanaguage?
		- Javascript?
			-  XSS?
				- What Input Validation?
					- Which characters?
						- URL encoded ip address in XSS payloads?
				- Have you tried multiple payloads to verify (non-)existence of XXS, then tools? 
			- Deserialization Attacks?
		- Vulnerable webserver version?
		- Webserver generic issues by type
			-  [[Apache-Tomcat]]
		- Vulnerable versioning? 
	- Have you caused and dorked the error messages? 
	- What request methods?
		 - Can you bypass with additional Headers?
	- Endpoints?
		- Fuzzed with Special chararcters on all end points - [[FFUF-Cheatsheet]]?
	- CMS 
	- Does the website use a database for storage?
	- Where can input be provided?
		- What input?
		- Where does the input go?
		- How is it processed?
		- Is there evidence of filtering and sanitization of input? 
	 - API?
		 - Is it mappable?
		 - Disclosure API Token?
	- Do any parameters call non-local resources?
		- Does the non local request have it only parameters
		- `ffuf -request search.req -request-proto http -w special-chars.txt -mc all` - which characters cause what issue that indicate what about the context? 
	- Error text 
		- What does the error mean? Just google it! 
	- How is data reflected back?
		- Did you fuzz for special bad characters?
		- XXS, SSTI, etc?
... 
- SQLI?
	- Can you create an Error and fix it?
	- Is the data returned a Boolean directly or indrectly?
	- Are Headers used in the back to store SQL data?
		- PHP: `X-Forward-For: 10.10.10.0.` to log IP addresses
	- If nothing is returned can you query the database to sleep()?
	- If there are multiple fields is there second order injection with `'\''` and `'"'` to generate a error, have do so for each?


- Web PrivEsc
- Have you performed scanning or manual enumeration authenicated?
- How is authenicated user data reflected on the page?
	- Framework? 
	- Database?
	- Session-related?

Application:

- Hardcoded credentials? 
- Special Character handling?
- Deserialization?
- Third party dependencies?
	- Vulnerable versions?
	- Abusable from contextual misconfiguration? 
 
Condense:
[[Haddix-Methodology]]
[[Web-App-Hacking-Methodology]]
[[Web-Hacking-Checklist]]

- Prior to breaching
	- RTFM and any reminders; reread the code?
		- Checked the shebang on the python exploit? - Trolly python2 developers 
	- Are there presuppositions that can be made before footholding a machine?
		- Security - Network and Host - Traffic-typoplogy and AMSI or Shell jails?  
		- OS?
	- Have you checked listeners, agents, tooling for your operatational errors? 
	- How does the application-to-gain-entry handle double and single quotes?
	- Have you followed the principle that *"Two is one and one is none"*?

- Breaching
	- Host OS and version?
		- Are we in a Container?
		- Are we in a Kubernetes Fleet?
			- Host's purpose in relation to the others?
		- Are we in a VM
		- Are we on bare metal?
	- `whoami /all` and variants are common alerts - but what user are we 	  
	- Service user in the event of footholding the machine?
	- Binaries avaliable?
	- Expected security?
	- Have you tried encoding the payload to counter string handling both client and server side
	- `www-data` and varients will not have user directory how will that affect subsequent chain
 
- Internal Network

- Active Directory
	- Are you Temporally Synced to the target Domain?
	- Is it really large and requires a [[Domain-Flyover]]
	- Have you got scope for [[Responder-Cheatsheet]] for [[LLMNR-Poisoning]] and [mitm6](https://github.com/dirkjanm/mitm6) - MITM those NTLM hashes.
		- Have they not cracked yet?
			- NTLM Relay Attack?
	- What do the protocol used and what information from those protocols can be queried to provide a mapping of intended networking and use of AD?
		- Are they vulnerable protocols?
			- Checked the authenicated ldap queries output for interesting fields? - [[LDAP-Recon]]
			- SMB version - [[SMB-Recon-Cheatsheet]]
			- [[RPC-Recon]]
		- Is what is shared and expected to be shared by AD or have humans disclosed information in shares?
			- Do the shares contain: shortcuts to executables, credentials, software, user and domain intel and information?	
	 - Recursively have with current context and reappraise Bloodhound, your objectives and the potential paths - [[Bloodhound-Guide]]? - `-c DCOnly` is quieter!
		1. How do I compromise credentials?
			1. Is the credential reused/defaults/weak/hardcoded?
				1. Have reused all credentials with [[Password-Attacks]]?
			2. ASREP-roast?
			3. Kerberoastable?
			4. Databases?
			5. Network Shares/File system artifacts?
			6. sMSA or [[gMSA-abuse]]?
			7. [[ACL-Abuse]]?
		3. What services can I access with those credentials?
			1. Have you mapped the network, with or without SharpHound?
			1. Is there evidence of network  requiring [[Proxies]] and [[Port-Redirection-And-Tunneling]]  
		4. How can I abuse my permissions to get more permissions and more credentials?
			1. How can you abuse the permissions allocated to the User or Group of current context?
		5. Is there alternate tool to the method of doing any previous step?


- Host Enumeration
	- Do scans or enumerated data have conflicting versioning and OS?
		- Containerisation - which is the container and which is the host?
- Lateral Movement
	- Password Reuse?






- Host
	- What security is on host?
		- Restricted Shell
		- AV
		- Are we in a container?
	- Is it a container?
		- What Container brand?
		- What is the network configuration for the container?
	 - Is it Virtualized?
		 - Virtualization Software/Hardware?
			 - Virtual Networking?
- What does a `ping`'s `TTL` field indicate?
	- Host OS?
	- Network Typology?
- What Ports are open?
	- Is there AD?
		- Domain Information?
		- Legacy Protocols?
	- Is there DNS? 
		1. Are there subdomains?
		2. Can you Zone Tranfer?
		3. Information disclosure?
		4. Connected to other DNS servers?
	- Accessible/Mountable File Shares?
		1. What is being shared?
			1. Hardcoded Credentials?
			2. Replaced Shortcuts?
			3. Documents that will openned by unprivileged users?
	- Are there custom ports or protocols?
	- Are any services running accessible with Default Credentials?  

- Post More Stealthier Shell
	- Did you make another persistence mechanism just in case?
	- Did you clean up the obvious?

- What is Network Typology?
	1. What is accessible? 
	2. What should legitmate traffic  
	3. Any Network Security?   
		1. What source and destination ports is legitmate traffic expect to be running on? 
		2. Local Encryption *"Standards"*?  
	1. Where are the databases?
		1. What language?
		2. Will they contain credentials?
		3. RCE-able - either vulnerable or built-in executablity?
		4. Default Credential?
	2. Are there legacy Hosts and Protocol inplace 
- What is the subnet's purpose?
	- What are the high priority Objective Host IPs, Hostnames?
	- Does it group legacy hosts?


- Email and Username Formats?
	

- What accounts are later objectives based on Company Role?

- What is CPU architecture and its implications?
- Have two is one - one is none? - Multiple shells for stability issues
- Are you able to run in memory?
	- If not have you a method of altering the file system records to cleanup and **set a reminder** that you have touched disk?
- Living Off the Land Binaries?
- Kernel Version
- User Hierarchy
	- Overextended Low Privilege User
- Group Hierarchy
	- Nesting?
		- Misconfiguration in the chain? 
- File System Permissions
	- How, where and what is current user allowed to do
	- Is the executable PATH variable controllable?
		- Modifiable
		- Pathing insecure/misconfiguration/fault 
	- Administrative Files
		1. Administrative Setup Files not cleaned up?
		2. Administrative Scripts
			1. Hardcoded Credentials
			2. Permissions
			3. Does script call external binaries, script, etc running as root/system at some point 
- Third Applications? 
	1. Does third-party application have installation management rights that affect the file system structure to cause misconfiguration?
	2. Version have an exploit?
	3. Permissions on local software libaries used, executable PATH variable? 
- What services are running?
	- What is running at high privileges?
		- Should system or root be running that service?
		- What is the file system tree surrounding the execution path?
		- What dlls is it using?
			- What is the file system tree surrounding a targetable dll
- Networking?
- What does the segmentation entail for access?
- What does access is potential gained from using [[Port-Redirection-And-Tunneling]] 
- If we domain or network joined what ports are exposed to localhost, but not remotehost?
	- Are there in-house usage of non-standard ports?
		- Port Redirection, Networking and Network Security considerations?
			- Avaliable services for redirection or can you drop a binary like Chisel?
	- Is Root/User hosting a network service on a port?

- In-House Applications
- In-House Scripting
	1. Hardcoded Credentials

Persistence 
- Scope?
	

- Have you cleaned up?
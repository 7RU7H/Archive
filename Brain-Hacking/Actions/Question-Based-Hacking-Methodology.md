
# Question Based Hacking Methodology



## Terminology

Brief disclosure on terminology, if there is a better way I will replace it

#### Intel vs Information:

Intel - Human intelligence data - data made by humans 
Information - Machine information provided by querying machines

Intel - Alice is a Helpdesk operator, Bob requested a password reset 
Information - the user Alice has X SID that then indicates Administrative Group  

#### False Positives and Negatives

[False Positives](https://www.cgisecurity.com/questions/falsepositive.shtml) - detected, but not vulnerable
[False Negatives](https://www.cgisecurity.com/questions/falsenegative.shtml) - not detected, but detection mechanism failed


- Consider how your problem is on OSI layer - Please Do Not Throw Away Sausage Pizza 

####  Objectives

...

#### Notes to tidy 

- Basics are fundamentals and forming questions are vital for answers, result, clues, etc
What
Why
Where
How
Who 


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


#### Question

- Are the people on the network [[OSINT]]able?
	- Is it in-scope and most professional way [[OSINT-People]]
	- Who to [[OSINT]]? 
		- Roles and social-contact-adjacent?
	- By technique? 
	- Do they accept documents for [[Phishing]]? 
	- Can we do [[Social-Engineering]] on a phone?
	- Pretext to do any of the above
		- Is a pretext form-able?
			- Is the enough information and correlation?
				- What is expected call or document format?
					- What do we need to forge a forgery? 
				- Can you pull it off?
					- Is something that you can actually do - [do not try to pretend to be a old women combining something unfitting to meta-context, which your audience would perceive as less than normal](https://www.youtube.com/watch?v=9_OIs49m56E)
			- ...then is the pretext fitting?

	
- Is infrastructure [[OSINT]]able?
	- Externally exposed identification
		- Formatting for email and users?
	- What externally exposed infrastructure exists - Ports, Websites, DNS servers -> Subdomains? Email servers?
	- Domain Names
	- CIDR ranges 
	- Cloud providers
- External Network
	- Strange/Custom ports?
		- What do common extractions with CLI tools suggest about this ports use? -  `curl`, `telnet`, `nc`

- Web
	- Have you pressed `[CTRL + F12]` yet? - Browser `Inspect` does not show HTML encoded characters
	- Does the site provide text to scrap into wordlist?
	- Virtual hosting? 
		- Fuzzable - rate limits?
		- Potential OSINTable VHOST from merging or referenced? 
		- What does the VHOSTing indicate about the technological stack: Subdomains, Containerisation, Cloud?
			- How is then stacked - bottom up from entry point?
	- WAF?
		- `If-None-Match` 
	- Web server and Website Language
		- Clarify host OS version from Web Server version? - Measure twice cut once!
		- Vulnerable Language?
		- Javascript? - modern browsers can debug especially useful blind exploit development
			-  XSS?
				- What Input Validation?
					- Which characters?
						- URL encoded IP address in XSS payloads?
				- Have you tried multiple payloads to verify (non-)existence of XSS, then tools? 
			- Deserialization Attacks?
		- Vulnerable webserver version?
		- Webserver generic issues by type
			-  [[Apache-Tomcat]]
		- Vulnerable versioning? 
	- Have you caused and dorked ([[Search-Engine-Dorking]]) the error messages? 
	- What request methods?
		 - Can you bypass with additional Headers?
	- Endpoints?
		- Fuzzed with Special characters on all end points - [[FFUF-Cheatsheet]]?
	- CMS 
	- Does the website use a database for storage?
	- Web server default Admin Login panels?
		- Default credentials?
		- Reused credentials?
		- Insecure credentials?
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
		- What data returns from the testing the parameter?
			- LFI? Can you read disk/memory?
			- RFI? Can you get remote resources? - Internal && External
			- SSRF? Can you request known resources - ports, files, webpages?
			- XSS? Can you execute javascript scripting?
			- SSTI? Can you exploit the template engines access to system?
			- (no)SQLI? Can you create error code enough to PoC interaction with database?  
			- CMDi? Can you execute with `& CMD` - windows  or `; CMD` - linux?
			- IDOR? Can you deserialize or decoded data; or modify data to change your object context?  
			- Error text 
				- What does the error mean? Just google it! 
			- How is data reflected back?
				- Did you fuzz for special bad characters?
				- XSS, SSTI, etc?
... 
- SQLI?
	- Can you create an Error and fix it?
	- Is the data returned a Boolean directly or indrectly?
	- Are Headers used in the back to store SQL data?
		- PHP: `X-Forward-For: 10.10.10.0.` to log IP addresses
	- If nothing is returned can you query the database to sleep()?
	- If there are multiple fields is there second order injection with `'\''` and `'"'` to generate a error, have do so for each?

- LFI?
	-  Add a `.` betwen `filename` and `.ext` for invalid file checks
	- Adding a `/` in the middle of `filename.ext` to check characters

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
	- Binaries available?
	- Expected security?
	- Have you tried encoding the payload to counter string handling both client and server side
	- `www-data` and variants will not have user directory how will that affect subsequent chain
 
- Internal Network

- Active Directory
	- Recursively while dealing with AD, Tools, your OS and you - have you configured correctly?:
		- Step -1): Are *you* mentally prepared and ready to deal with the issue abound... 
		- Step 0): is `/etc/hosts` configured `$DCipv4Address dc.$domain.$tld $domain.$tld` in this order!
		- Step 1): Continuously re-synced to the DC: `sudo ntpdate -s $targetDC.$domain.$tld` 
			- temporal synced to target domain controller required for [[Attacking-Kerberos]] or any [[Active-Directory-Kerberos-Authentication-Defined]] 
		- Step 2): Is Kinit configured properly?
		- Step 3): Do you need to **(re)**TGT after re-synced to the DC: go to Step 1)
		- Step 4): Are you running latest Tool versions!
	- Is it really large and requires a [[Domain-Flyover]]
	- Have you got scope for [[Responder-Cheatsheet]] for [[LLMNR-Poisoning]] and [mitm6](https://github.com/dirkjanm/mitm6) - MITM those NTLM hashes.
		- Have they not cracked yet?
			- NTLM Relay Attack?
	- What do the protocol used and what information from those protocols can be queried to provide a mapping of intended networking and use of AD?
		- Are they vulnerable protocols?
			- Checked the authenticated LDAP queries output for interesting fields? - [[LDAP-Recon]]
			- SMB version - [[SMB-Recon-Cheatsheet]]
			- [[RPC-Recon]]
		- Is what is shared and expected to be shared by AD or have humans disclosed information in shares?
			- Do the shares contain: shortcuts to executable, credentials, software, user and domain intel and information?	
	 - Recursively have with current context and reappraise Bloodhound, your objectives and the potential paths - [[Bloodhound-Guide]]? - `-c DCOnly` is quieter!
		1. How do I compromise credentials?
			1. Is the credential reused/defaults/weak/hardcoded?
				1. Have reused all credentials with [[Password-Attacks]]?
			2. ASREP-roast?
			3. Kerberoastable?
			4. Databases?
			5. Network Shares/File system artefacts?
			6. sMSA or [[gMSA-abuse]]?AD escalation and laterally movement, before Local Privilege Escalation is always a reduction in time to objective.
			7. [[ACL-Abuse]]?
		3. What services can I access with those credentials?
			1. Have you mapped the network, with or without SharpHound?
			1. Is there evidence of network  requiring [[Proxies]] and [[Port-Redirection-And-Tunnelling]]  
		4. How can I abuse my permissions to get more permissions and more credentials?
			1. How can you abuse the permissions allocated to the User or Group of current context?
		5. Is there alternate tool to the method of doing any previous step?
	- Foothold on a box - remember:
		- [[Active-Directory-Lateral-Movement]] and [[Active-Directory-Privilege-Escalation]] before Local Privilege Escalation is always a reduction in time to objective. 


- Host Enumeration
	- Do scans or enumerated data have conflicting versioning and OS?
		- Containerisation - which is the container and which is the host?
- Lateral Movement
	- Password Reuse?






- Host enumeration 
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
			1. Hard-coded Credentials?
			2. Replaced Shortcuts?
			3. Documents that will opened by unprivileged users?
	- Are there custom ports or protocols?
	- Are any services running accessible with Default Credentials?  

- Post More Stealthier Shell
	- Did you make another persistence mechanism just in case?
	- Did you clean up the obvious?

- What is Network Typology?
	1. What is accessible? 
	2. What should legitimate traffic  
	3. Any Network Security?   
		1. What source and destination ports is legitimate traffic expect to be running on? 
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


- Localhost enumeration and assess the need to Privilege Escalation
	- As operator are you?
		- Stopping, considering security mechanisms that maybe in place to alert SOC, IR, etc.
		- Are you meeting objective on a granular level with any action
		- Gaining situational awareness
		- Noting effectively 
			- Pathing affectively
			- Reducing information overload 
		- Meeting requirements of stealth or (non)-harmful activities
		- Assess the value of time in Privilege Escalating locally - should you laterally move?
	- Are we in the Cloud or On-premises
	- What security is on host?
		- Restricted Shell
		- AV
		 - Is the host Virtualised?
		 - Virtualisation Software/Hardware?
			- Are we in a container?
				- Is it a container or cluster?
			- Container/Pod image
			- What is the network configuration for the container(s)/cluster?
			- Virtual Networking?
	- What is CPU architecture and its implications?
	- Operating System?
		- [[Linux-Privilege-Escalation]]
		- [[Windows-Privilege-Escalation-Enumeration]] and [[Windows-Privilege-Escalation-Vectors]]
	- Have two is one - one is none? - Multiple shells for stability issues
	- Are you able to run in memory?
		- If not have you a method of altering the file system records to cleanup and **set a reminder** that you have touched disk?
	- Living Off the Land Binaries?
		- Custom and non-default additions including the below
			- Custom additions are potentially normal, what is normal usage look like to security? 
		- GTFOBins
		- [[Windows-Living-Off-The-Land]]
	- Kernel Version?  - and wait unless it Pwnkit and time saving situation
	- What services and applications are installed?
		- What services are running?
			- Why are they running - purpose of machine?
			- What is running at high privileges?
				- Should system or root be running that service?
				- What is the file system tree surrounding the execution path?
				- What DLLs is it using?
					- What is the file system tree surrounding a targetable DLL
		- Installed Packages and Versions
			- Third Applications? 
				1. Does third-party application have installation management rights that affect the file system structure to cause misconfiguration?
				2. Version have an exploit?
				3. Permissions on local software libraries used, executable PATH variable? 
	- User sessions - Who is current logged in? What users recently logged in?
		- How are is the user logged in?
			- What is the current time on  
			- In person
			- What network protocol - SSH, RDP? 
	- What users, admins, and groups exist on the system? 
		- User Hierarchy
			- Overextended Low Privilege User
		- Group Hierarchy
			- Nesting?
				- Misconfiguration in the chain? 
		- UAC and sudo-like privileges
			- User-by-user basis  
		- What password policies, if any, are enforced on the host? 
	- File System Permissions
		- What is readable?
		- What is writable?
		- What is executable?
		- How, where and what is current user allowed to do with the above can this be used to achieve objectives? 
			- By default
			- UAC, sePrivilegeTokens, SETUID and SETGID Permissions
		- Is the executable PATH variable controllable?
			- Modifiable
			- Pathing insecure/misconfiguration/fault 
		- Administrative Files
			1. Administrative Setup Files not cleaned up?
			2. Administrative Scripts
				1. Hardcoded Credentials
				2. Permissions
				3. Does script call external binaries, script, etc running as root/system at some point
		- Important files
			- What types of interesting information can we find in history, log, and backup files
				- Backup files - check access, permissions and what is normal 
				- Can we access the shell `_history` file for any users and can we uncover any thing interesting from their recorded command line history such as passwords?
			- Configuration files
				- Can contain credentials
			- Credential files
				- Shadow, SAM, SYSTEM hives
				- Hashes in files non secure locations 
					- `/etc/passwd` - embedded devices
					- User files
					- Configuration files
			- OS control files 
				- [[Windows-Registry]] control
				- `/etc/`, `/usr`, `/var`
			
		- User Files
			- Home directories 
			- External to home directory owned files
		- Environment Variables
			- PATH variable misconfigurations and traversal algorithm issues 
			- Container credentials 
			- Container Network information 
		- Scheduled tasks?
			- What does the task do and interact with **directing**, **subsequently** and as a **by-product-of-either**?
			- Are  able to hijack anything on the *entire chain*?
		- Networking?
			- What does the segmentation entail for access?
			- Current IP addressing information    
			- What sockets are in use?
			- What sockets are we able to control if any?
			- Anything interesting in the `/etc/hosts` file?
		       - Is the host joined to an Active Directory domain?
			- Are there any interesting network connections to other systems in the internal network or even outside the network?
			- What does access is potential gained from using [[Port-Redirection-And-Tunnelling]] 
			- If we domain or network joined what ports are exposed to localhost, but not remote host?
				- Are there in-house usage of non-standard ports?
					- Port Redirection, Networking and Network Security considerations?
						- Available services for redirection or can you drop a binary like Chisel?
				- Is Root/User hosting a network service on a port?
		- Drives and devices - See Important files
			- Unmounted File systems 
			- Additional drives
		- What is custom that we may be able to take advantage of?
			- In-House Applications
			- In-House Scripting
				1. Hardcoded Credentials







Persistence 
- Scope?
	

- Have you cleaned up?




## References

[https://www.cgisecurity.com/questions/falsepositive.shtml](https://www.cgisecurity.com/questions/falsepositive.shtml)
[https://www.cgisecurity.com/questions/falsenegative.shtml](https://www.cgisecurity.com/questions/falsenegative.shtml)
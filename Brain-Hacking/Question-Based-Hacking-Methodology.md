
# Question Based Hacking Methodology

For more philsophical Hacking super dense and short article see [[Hacking-The-Thing]] 

What systems are online, but available
Who can connect
What is allowed to connect - type of connection 
What is connected to what
How is it connected
What permissions do you have
How can use current level of access to get more access

Where can input be provided 
What can be reqquested

What does the output suggest?
- Error - information disclosure  

What is regular userland purpose
What is does it run
What is network level purpose of connections


- Objectives

- Web 

- Pre-Network Phase
	- External User interaction points - Website, email address
	- Domain Names
	- Email addresses
	- CIDR ranges 
	- Cloud providers
- External Network
- Internal Network
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
	- OS?
	- Network Typology?
- What Ports are open?
	- Is there AD?
		- Domain Information?
		- Legacy Protocols
	- If there is DNS 
		1. Are there subdomains?
		2. Can you Zone Tranfer?
		3. Information disclosure?
	- Accessible/Mountable File Shares?
		1. What is being shared?
			1. Hardcoded Credentials?
			2. Replaced Shortcuts?
			3. Documents that will openned by unprivileged users?
	- Are there custom ports or protocols?
	- Are any services running accessible with Default Credentials?  

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
- Third Applications
	1. Does third-party application have installation management rights that affect the file system structure to cause misconfiguration?
	2. Version have an exploit?
	3. Permissions on local software libaries used, executable PATH variable? 
- What services are running?
	- What is running at high privileges


- In-House Applications
- In-House Scripting
	1. Hardcoded Credentials
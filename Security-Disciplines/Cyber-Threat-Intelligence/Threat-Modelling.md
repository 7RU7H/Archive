# Threat Modelling

Sometimes the threat is yourself or those in your organisation, it is best to have the basics of security down first:
- No flat network typology
- No flat ACL hierarchy
- Segmentation of assets
	- If you have to run a very old vulnerable Windows Box segmented it and don't `psexec` in, walk to the machine.
- Unnecessary assets
- Good password policy
- Keep it simple with RBAC, avoid ABAC where possible and prevent exponential granularity combinations 

These should mitigate some of malicious insider threat

Organisation Optimisation:
- Well defined stakeholders
- Collaboration with different teams helps
- All-Your-Users-Are-An-Immune-System, not a technical debt mentality means that training them to spot the easy and know bad or my computer is doing a weird thing
- Attack Trees and a Playbooks that are usable in a crisis
- Use [[MITRE-ATT&CK]] and [[MITRE-ATT&CK-Navigator]]

Threat Modelling is modelling:
1. Identification 
	1. Defining the scope
	2. Asset identification
	3. Identify Threats
	- What functions do each systems and applications serve in the environment, identifying what systems and applications need to be secured?
		- If it has no purpose it is a security risk both as an human administrative oversight - both patching and defending
		- If is too useful, do not make your legitimate users subvert the security put in place to keep them and the assets safe.  
3. Prioritisation
	1. Analyse Vulnerabilities and Prioritise Risks
	- Conducting assessment of what vulnerabilities, weaknesses, flaws these systems have; Adversaries do so to exploit your systems
5. Actionable strategy to counter threats
	5. Develop and Implement Countermeasures
	6. Monitor and Evaluate
	- Create actionable strategies and defensive measures to secure, monitor, maintain systems, but your users are the simpler to exploit than a system:
		- Give external contractors specific email accounts   
		- Make it easy for users to do there job safely
		- Don't create and fight against systems that promote repetitive normality - make uses spam 2FA, Logins, doom-clicking (infinite click through - does not activate the attentive ration parts of the users brains) [[Coerced-Authentication]] exists
7. Actuating policy to prevent re-occurrence
	- Make policy that human then behave like water; channel your users to make the right decisions by default and not getting creative with how they subvert your policy:
		- I.E: Having a strong password policy that rotates every 4 months that leads to:
			- `Winter123!@#$`
			- Storing password on personal devices, paper, etc

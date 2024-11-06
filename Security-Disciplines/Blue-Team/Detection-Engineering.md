# Detection Engineering

Detection Engineering is the continuous process of creating, operating and maintaining threat intelligence analytics to identify malicious activity or misconfigurations in a environment.

Typology 
- Environment-based - Standardised normality and configuration based
	- Configuration detection
		- If environment is static it is strong and easy
		- If visibility is reduced, it is weakened
		- Requires a complete knowledge of all infrastructure in environment for full effectiveness
		- Configuration changes can result in high count of false positives
	- Modelling 
		- Provides no context of threat activity during investigation
		- If environment is static it is strong and easy
		- If modelling occurs while environment compromised, the model is compromise
		- If visibility is reduced, it is weakened
		- Requires a complete knowledge of all infrastructure in environment for full effectiveness
- Threat-based - adversarial activities of tactics, tools and procedures
	- Indicators - good indicators for whitelists and bad indicators for blacklists
		- Fast to create - but adversary has a rate of change too
		- Indicators raise specific threat context, but requires observation of the indicator
		- Can enrich data sources detection if processable in time, but indicator can expiry or timeline changes can lead to false detection
	- Threat behaviour detection
		- Although lot of data required it can withstand adversary's rate of change
		- Adaptable, but initial implement is difficult
		- Low false positives, but only detects threat behaviour
		- Integratable into defensive playbooks and remediation, but modifications are required if cross-industry context changes from source to destination in detection reuse.


## Detection As Code (DaC)

- Version control - [[SIEM-Solutions]] and [[EDR]] lack tracking for changes made to alerts and definitions
- Automation workflows
- Customisation
- Code Reuse
- Fosters collaboration
- Testable - It is easy to validate whether it detected or not

Workflow of Detection Engineering
1. Observe a suspicious or malicious behaviour
1. Model as code
2. Write test cases
3. Commit to version control
4. Deploy to staging and test
5. Deploy to production
6. Tune and update -> Commit to version control

## Detection methodologies


- Detection Gap Analysis
	- Reactive - assessing most recent internal incident reports and building detection mechanism based on findings 
	- Proactive - using the [[MITRE-ATT&CK]] and other frameworks to build detection mechanisms
- Data source Identification and Log Collection
	- Baseline Creation
		- High-Level: broad standards guided by specified security policy  
		- Technical: configuration standards outlining different system functions and the intended behaviours or activities
	- Log Collection
- Rule Writing
	- [[Snort]]
	- [[YARA]]
	- [[Sigma]]
- Deployment, Automation & Tuning


## Detection Engineering Frameworks

- [[MITRE-ATT&CK]] - found at [ATT&CK framework](https://attack.mitre.org/)
- CAR ([Cyber Analytics Repository](https://car.mitre.org/))
- Pyramid of Pain
- Cyber Kill Chains:
	- [[Varonis-Cyber-Kill-Chain]]
	- [[Unified-Kill-Chain]]
	- [[Lockhead-Martin-Cyber-Kill-Chain]]
- [Alerting and Detection Strategy Framework](https://github.com/palantir/alerting-detection-strategy-framework)
	1. Goal: Why has a detection?
	2. Categorisation: What type mapping to framework?
	3. Strategy Abstract: What role does the detection play within a great strategic context?
	4. Technical Context: What is the technical environment of the detection to be used?
	5. Blind Spots and Assumptions: What are known issues with a identification and detection? 
	6. False Positives: What are the known false positives?
	7. Validation: How after verification can we valid information?
		- Develop a plan that will produce a true-positive outcome.
		- Document the process of the plan.
		- From the testing environment, test and trigger an alert.
		- Validate the strategy that triggered the alert
	1. Priority: What should the alert level be in relation to other indicators and context of analysis and detection
	2. Response: How can a response be executed to prevent, reduce harm and remediate issues


#### Detection Maturity Level Model

[Ryan Stillions](http://ryanstillions.blogspot.com/2014/04/the-dml-model_21.html) brought forward the Detection Maturity Level (DML) model in 2014 as a way for an organisation to assess its maturity levels concerning its ability to ingest and utilise cyber threat intelligence in detecting adversary actions. Two main guiding principles:
- Measure the ability to detect and respond
- Without detection functions there is no opportunity for response functions
Four critical use cases for the model (from the original):
1. To provide a lexicon for more accessible communication of threat information.
2. To assess detection maturity against monitored threat actors.
3. To assess the maturity of security vendors and products in use.
4. To provide context to analysts by including the DML levels in Yara rules, Snort signatures and SIEM correlation rules.

Eight is the highest and zero the lowest
- DML-8 - Goals: Organisation can detect adversary's goals
- DML-7 - Strategy: Organisation can detect strategy and intentions
- DML-6 - Tactics: Organisation can detect tactics used by adversaries
- DML-5 - Techniques: Organisation can detect techniques used by adversaries
- DML-4 - Procedures: Organisation can detect  sequence of events from an adversary
- DML-3 - Tools: Detection at either the transfer phase or functionality and operation phase
- DML-2 - Host and Network Artefacts: Detection of Artefacts 
- DML-1 - Atomic Indicators: Detection of IP addresses and domains to detect threat
- DML-0 - No detection processes established

## References

[THM Introduction to Detection Engineering](https://tryhackme.com/room/introtodetectionengineering)
[ATT&CK framework](https://attack.mitre.org/)
[Cyber Analytics Repository](https://car.mitre.org/)
[Alerting and Detection Strategy Framework](https://github.com/palantir/alerting-detection-strategy-framework)
[Ryan Stillions - DML Model](http://ryanstillions.blogspot.com/2014/04/the-dml-model_21.html) 
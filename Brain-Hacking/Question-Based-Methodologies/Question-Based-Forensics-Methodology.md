# Question Based Forensics Methodology

Forensic activities are the attempt to result in a graph that is hyper-decriminative distinctive nodes and edges as sets of nodes and edges. 

Similar to gravity the the forensician task is to separate fields of connection that form as close to the actual events

It requires meta and adversarial knowledge of activities to solve complex chains of insight and perspective relative problems. 

It always has some implementation of timelining.

Often requires tangential, passive and very indirect sourcing of information as a reconnaissance activity, but analytical and operating with past information more than present information.

[[Reasoning-Typology]]
Abductive Reasoning - simplest explanation is most likely
Deductive Reasoning - premise with results which require both to be true
Inductive Reasoning - generalisations, principles applied to observations 

[[Rabbitholes]] exist 

*Homebrew* tooling that I am working on here and there that you should not be taken seriously as I have real experience other than struggling with CTFs:
[[Problem-Compass]], [[Problem-Microscope]]
#### True/False (Positives and Negatives) and the Null Space 

True Positives - Detected and is vulnerable
True Negatives - Found not to be vulnerable, but detection mechanism enumerated successfully
[False Positives](https://www.cgisecurity.com/questions/falsepositive.shtml) - detected, but not vulnerable
[False Negatives](https://www.cgisecurity.com/questions/falsenegative.shtml) - not detected, but detection mechanism failed

Null Space - 
- What do clues connected together within a hypothesis may indicate theory to be true or false
- Example from @MalwareJake: - Nuking the Log off the Event Logs, but there is still Log on Event and the system has not rebooted or shuck down
	- Find:
		- What is not there, but should be
		- What is there, but should not be
	- Consider how atypical the logic chain of events is a why it may have happened
	- Always collect clues and not opinions - collecting opinion lead nowhere, but clues a pieces of a puzzle leading somewhere

- Consider how your problem is on OSI layer - Please Do Not Throw Away Sausage Pizza 

#### Data is everything

Consider Data sets
- Baseline normal
- True-Negatives
- False-Positives
- Real world examples: open source known malicious; [[MITRE-ATT&CK]] framework, etc


How to not contaminate and store data? - Data Retention
How to effectively process data without alter the original Data Processing 
Informational Evaluation 


- Reasoning about information
	- [[Reasoning-Typology]]

#### Thought Process Considerations


If is not a some alien (we have had not alien communication ever - The universe is too young and would take so long to get here if there were we would be hundred of millions of years more advanced by the time they got here)...

> Reduce the scope of possibility and filter out analytical noise with big conditionals

...or APT level mind-boggler-existing-in-some-unknown-rootkit-parasitic-kernel-nether-realm then all protocols and services will use the standard utilities of the OS - the question is where would normal activity leave artefacts?

> Know the environment and how it works

[IOC can also mean - Intent, Opportunity, Capability](https://youtu.be/xuUMlNx72xI?feature=shared&t=266) 


Network Traffic Forensics
- If are struggle to express what you need to find in network traffic, never forget [[Wireshark]]'s - `Display Filter Expressions` to get a very specific expression per protocol [[Wireshark-Useful-Packet-Filters]]

## References

[Living in the Shadow of the Shadow Brokers - SANS DFIR Summit 2018](https://youtu.be/xuUMlNx72xI)
# Diamond Model

**The Diamond Model of Intrusion Analysis** was developed by cybersecurity professionals - Sergio Caltagirone, Andrew Pendergast, and Christopher Betz in 2013. See: [Whitepaper](https://www.activeresponse.org/wp-content/uploads/2013/07/diamond.pdf) *"the model establishes the basic atomic element of any intrusion activity,  the event, composed of four core features: adversary, infrastructure, capability, and victim. These features are edge-connected representing their underlying relationships and arranged in the shape of a diamond, giving the model its name: the Diamond Model"*

1. Adversary - attacker responsible for utilizing a capaability against a victim to achieve their intent
	- Operator hacking as a service 
	- Customer paying for the service that stands to benefit from activity conducted in the intrusion
1. Victim - target of an adversay
	- Victim Personae are people
	- Victim Assets are hardware, software and data
1. Capability - knownable skills, tools, techniques, organisational qualities, systemic properties.
	- Capability Capacity - all the vulnerbailities and misconfiguration that are exploitable/abusable 
	-  Adversarial Arsenal 
1. Infrastructure - typology:
	1. Type 1: Controlled and owned by the adversary
	2. Type 2:Controlled and owned by an intermediary
2. Event Meta Features
	1. Timestamps
	2. Phases
	3. Result
	4. Direction - event that colleralte to direction of the instrusion attack to util some result or failure
	5. Methodology 
	6. Resources
3. Social-Political Component - describes the needs and intent of the adversary
4. Technology Component - relationship between the core features: capability and infrastructure

Establishes the fundamental atomic element of any intrusion activity each are edge-connected representing their underlying relationships and arranged in the shape a diamond.

#### Article Authors Thoughts and Addition

1. Qualties and properties exist in model that is graph-based and is extendable 
2. Graphes implicitly are mirroring if conceptual dichotomy
3. That this means that model that does not contain the mirroring is not a complete model by definition that it does define the mirrored participant than as just a object, not a subject in its own actions that could aid or abet the attackers.
4. This may already be in the whitepaper, but I do not get paid to write this and it just seems very obvious such it is worth writing it down to remember.

There maybe real professional that hold these views and by some informational osmosis claim some authorship, but as far as I am concern any graph whether it is Bloodhound or something in number theory has special properties that entail implications for participants. Simple a graph based model of how attackers exist therefore is dichomtomised by how Victims exist. Also grpahs have objects have properties for example: just because CVE-XXXX-XXXX existes in a Victims architecture if the the affective potential actionability on the objective (exploi the vulnerability) is negatively operationalisable - they can't exploit it because that lack the ability to stealthily perform the exploit without compromising themselves in the process are they really capable? Therefore Capabilities are intutively measurable. Both Capability and Infrastructure are reflexive concepts, Blue team has Capabilities and Infrastructures yet to be compromised that can used to defend Victim Personae and Assets. For example:
1. Capability - knownable skills, tools, techniques, organisational qualities, systemic properties
	- Capability Capacity both - the affective potential actionability on objective operationalisable:
		- Capabilities of the Adversary 
			- ...
		- Capabilities of the Victim - the speed and efficiency of:
			- Incident Response 
			- Digital Forensics
			- Log management and retention
			- Security Principles
			- Adaptability under seige
			- Hold out time post compromise and counter offensive
			- Detection and response
1. Infrastructure
	1. Type 1:
		- Backup integrity
		- Defensive implementations
			- Honeypots
			- DMZs
			- Segmentation
	2. Type 2:
		 - Azure/AWS backbone network
		 


## References

[Whitepaper](https://www.activeresponse.org/wp-content/uploads/2013/07/diamond.pdf)
[THM room Diamond Model](https://tryhackme.com/room/diamondmodelrmuwwg42)

# Question Based OSINT Methodology



## Reasoning about information

[[Reasoning-Typology]]

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


Consider how your problem is on OSI layer - Please Do Not Throw Away Sausage Pizza 





[[Reasoning-Typology]]
Abductive Reasoning - simplest explanation is most likely
Deductive Reasoning - premise with results which require both to be true
Inductive Reasoning - generalisations, principles applied to observations 

[[Rabbitholes]] exist 

*Homebrew* tooling that I am working on here and there that you should not be taken seriously as I have real experience other than struggling with CTFs:
[[Problem-Compass]], [[Problem-Microscope]]


Effective [[Search-Engine-Dorking]]

Prompts and AI Chatbots a auxiliary way to condense historic searchable data, beware of the risks of AI usage and validity 



Gap analysis takes stock of the initial information that you have and then applies four simple questions to identify what to do next. This can be applied to bring structure and order to your OSINT research. The four questions are:
1. What do I know?
2. What does this mean?
3. What do I need to know?
4. How do I find out?


Fiction Account Creation
- https://thispersondoesnotexist.com
- https://thisresumedoesnotexist.com
- https://www.fakenamegenerator.com
- https://randomuser.me
- https://uiname.com
- https://www.dating-profile-generator.org.uk
- https://www.elfqrin.com/fakeid.php
- https://ww.behindthename.com/random/

Reverse Image Search

Calculate Photo Approximate Time of Day
- https://www.suncalc.org

Recent Satelite imagery


Password Resets
- Lack of Standardisation in implementation between sites, have you checked?
## References

[https://nixintel.info/osint/](https://nixintel.info/osint/)
[https://nixintel.info/osint/using-gap-analysis-for-smarter-osint-quiztime-4th-march-2020](https://nixintel.info/osint/using-gap-analysis-for-smarter-osint-quiztime-4th-march-2020)

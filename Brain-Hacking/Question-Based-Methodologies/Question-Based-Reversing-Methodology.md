# Question Based Reversing Methodology


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

- Consider how your problem is on OSI layer - Please Do Not Throw Away Sausage Pizza 




What are you looking for?
How can we extract it?

What is the flowchart?

Are you here to debug?
- Can we extract and isolate

Is it malware, if so then...?
- [[Obfuscation-Principles]]





Reversing
- Have tested a manual check or a tool with another type of check for the same output?
- Whats string data is exposed?
	- `Ghidra Search -> Strings`
	- `strings`
- How can you make it more readable to track what matters - Reading is not enough for Reversing, change the names
	- [[Ghidra-Cheatsheet]] `Right Click -> Covert` value to a format or encoding
- **Do not assume** the order of variables pushed to the stack, it depends on compilation and language - there is very limited information about this... have you tested and noted the ordering of pushes to memory or stack of variables,data, etc?
	- What is a total of all variables placed on the stack?
		-  [[Ghidra-Cheatsheet]] per function with `-0xSignedOffsetAsHex:NumberOfAVal`


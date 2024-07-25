# Question Based Pwning Methodology


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

WiRE
- How can I `Write` to ...?
- How can I `...is it a Rabbithole?`
- How can I `Read` from ...?\
- How can I `Execute` something else?

Is this template effective?

[[Reverse-Engineering]] with [[Question-Based-Reversing-Methodology]] 

Architectural Nuances and Idiomatic to chipset

Timing attacks

Side Channels

System Calls

Memory Protections
	[[ASLR]]
    [[RELRO]]
    [[Stack-Canaries]]
    [[NX]]
	[[PIE]]
    [[FORTIFY]]

Hooking



Pwning
- [[Tools/Binary-Exploitation-Tools/Pwntools|Pwntools]]
	- Are you using `Pwntools` effectively?
- Low hanging fruits?
	- Any interesting [[Binary-Exploitation-Enumeration]] through `strings` and metadata
- Have you run `ltrace ./binary`?
-  Using `ghidra` [[Ghidra-Cheatsheet]]?:
	- Do not be an idiot, `Ghidra -> Strings` click and click to find the functions that matter
	- Convert values in the `Ghidra` and use the tools

- [[Pwntools]]
- [corefile.pc](https://docs.pwntools.com/en/stable/elf/corefile.html#pwnlib.elf.corefile.Corefile.pc) for cross platform get eip
- A common error to not worry about, is the `pwn` `x.sendlineafter("string to send after", payload)` the correct string?
- Have you checked both how the local and remote version accept input as they may differ?!
- **Do not assume** the order of variables pushed to the stack, it depends on compilation and language - there is very limited information about this... have you tested and noted the ordering of pushes to memory or stack of variables,data, etc?
	- What is a total of all variables placed on the stack?
		-  [[Ghidra-Cheatsheet]] per function with `-0xSignedOffsetAsHex:NumberOfAVal`

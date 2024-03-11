# Question Based Reversing Methodology

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
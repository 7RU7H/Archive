# Question Based Pwning Methodology

Pwning
- [[Tools/Binary-Exploitation-Tools/Pwntools|Pwntools]]
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

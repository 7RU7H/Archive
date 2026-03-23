# Ghidra Cheatsheet

Features:
- Decompilation
- Disassembly
- Debugging
- Analysis - but you still have use your brain..

Function colouring - blue means linked function not in binary

Ghidra strings 
`Window -> Strings`; click 

`Right Click -> References -> Show references to address`

- house symbol in `ghidra` changes the base address, very useful [[ASLR]] and attaching to debuggers like a cheat engine

Virtual address of functions
`XREF[$INT_ID]:  FUN_$GhidraFunctionIDNumber:$VIRTUALADDRESSISHERE (R)` - the `(R)` is hyperlink internal to `Ghidra` to the Virtual Address 

## References

[THM Advanced Static Analysis](https://tryhackme.com/r/room/advancedstaticanalysis)
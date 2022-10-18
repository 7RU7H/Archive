# Intel Assembler Instructions To Know
## Issue of syntax

## 
Appended letter to the asm instruction denotes byte width:
Intel Data Type | Suffix | Size(bytes)
--- | --- | --- 
Byte | b  | 1
Word | w | 2
Double Word | l | 4
Quad Word | q | 8
Single Precision | s | 4
Double Precision | l | 8




-   `leaq source, destination`: this instruction sets destination to the address denoted by the expression in source
    
-   `addq source, destination`: destination = destination + source
    
-   `subq source, destination`: destination = destination - source
    
-   `imulq _source, destination_`: destination = destination * source
    
-   `salq source, destination`: destination = destination << source where << is the left bit shifting operator
    
-   `sarq source, destination`: destination = destination >> source where >> is the right bit shifting operator
    
-   `xorq source, destination`: destination = destination XOR source
    
-   `andq source, destination`: destination = destination & source
    
-   `orq source, destination`: destination = destination | source

## Jump Instructions
Jump Type | Description
--- | ---
jmp | Unconditional
je | Equal/Zero
jne | Not Equal/Not Zero
js | Negative
jns | Nonnegative
jg | Greater
jge | Greater or Equal
jl | Less
jle | Less or Equal
ja | Above(unsigned)
jb | Below(unsigned)



## References
[THM intro to x86-64](https://tryhackme.com/room/introtox8664)

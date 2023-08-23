# x86 Assembly

[Wikipedia]() *"**x86 assembly language** is the name for the family of [assembly languages](https://en.wikipedia.org/wiki/Assembly_language "Assembly language") which provide some level of [backward compatibility](https://en.wikipedia.org/wiki/Backward_compatibility "Backward compatibility") with CPUs back to the [Intel 8008](https://en.wikipedia.org/wiki/Intel_8008 "Intel 8008") microprocessor, which was launched in April 1972."*


Definitions:
- Opcodes (operation code) denotes an assembly instruction represented by a mnemonic combined with a one or more operands, translates to one or more bytes called an opcode. 
- Operands:
	- Immediate Operands - fixed values
	- Registers - can also be operands
	- Memory operands - (denoted by square brackets) reference memory locations

#### Instructions

`mov destination, source` - copy data from the source into the destination
```asm
mov eax, 0xaa ; move immediate operand into the eax register
mov eax, ebx ; move the value in the ebx register into eax
move eax, [0xdeadbeef] ; move the value at the memory location into eax register
```

`lea destination, source` - load effective address, copy the address of the source into the destination

`nop` - no operation, the instruction exchange the the value in eax with itself resulting in no operation. Used to wait out CPU cycles to prevent race condition

`shr destination, count` - shifts the destination by a number of positions right, the positions shifted out (to the left of resulting position) are flipped to zero
- The carry flag (CF) is used to augment the destination, as it is filled by the last bit overflowing the destination.
- Shift Instructions are used instead or multiplication and divisions by powers of two 
- `10000000` by 4 becomes `00001000`

`shl destination, count` - shifts the destination by a number of positions left, the positions shifted out (to the right of resulting position) are flipped to zero
- The carry flag (CF) is used to augment the destination, as it is filled by the last bit overflowing the destination.
- `00000001` by 4 becomes `00010000`

`ror destination, count` rotates the destination to the right  
- `01010000` rotated right by 1 becomes `00101000` 

`rol destination, count` rotates the destination to the right  
-  `00001010` rotated left by 1 becomes `00010100` 

## Flags

Flags are bits that are set in the Flags Register or `EFLAGS` register to represent a condition or result of the most recent arithmetic or logical  

|Flag|Abbreviation|Explanation|
|---|---|---|
|Carry|CF|Set when a carry-out or borrow is required from the most significant bit in an arithmetic operation. Also used for bit-wise shifting operations.|
|Parity|PF|Set if the least significant byte of the result contains an even number of 1 bits.|
|Auxiliary|AF|Set if a carry-out or borrow is required from bit 3 to bit 4 in an arithmetic operation (BCD arithmetic).|
|Zero|ZF|Set if the result of the operation is zero.|
|Sign|SF|Set if the result of the operation is negative (i.e., the most significant bit is 1).|
|Overflow|OF|Set if there's a signed arithmetic overflow (e.g., adding two positive numbers and getting a negative result or vice versa).|
|Direction|DF|Determines the direction for string processing instructions. If DF=0, the string is processed forward; if DF=1, the string is processed backward.|
|Interrupt Enable|IF|If set (1), it enables maskable hardware interrupts. If cleared (0), interrupts are disabled.|


## References

[THM x86 Assembly Room](https://tryhackme.com/room/x86assemblycrashcourse)
[Wikipedia Opcodes](https://en.wikipedia.org/wiki/Opcode)
[Wikipedia x86 assembly language](https://en.wikipedia.org/wiki/X86_assembly_language)
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

`call`
- How do arguments get passed to `call` instructions?
	- The calling convention is defined in detail in [System V Application Binary Interface—AMD64 Architecture Processor Supplement.](http://www.x86-64.org/documentation/abi.pdf)


[Wikipedia: x86 Instruction `test`](https://en.wikipedia.org/wiki/TEST_(x86_instruction) states the `test` [instruction](https://en.wikipedia.org/wiki/Instruction_(computing) "Instruction (computing)") performs a [bitwise AND](https://en.wikipedia.org/wiki/Bitwise_AND "Bitwise AND") on two [operands](https://en.wikipedia.org/wiki/Operand "Operand"). The [flags](https://en.wikipedia.org/wiki/FLAGS_register "FLAGS register") [`SF`](https://en.wikipedia.org/wiki/Sign_flag "Sign flag"), [`ZF`](https://en.wikipedia.org/wiki/Zero_flag "Zero flag"), [`PF`](https://en.wikipedia.org/wiki/Parity_flag "Parity flag") are modified while the result of the [AND](https://en.wikipedia.org/wiki/Bitwise_AND "Bitwise AND") is discarded.
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


#### Arithmetic Operations
```asm
add dst, value ; add value to the destination as the result  

; For Subtraction
; If destination is smaller subtraced value the carry flag (CF) is set
; Zero Flag (ZF) is set if result is zero
sub dst, value 

; For multiplication and division two registers are required 
; Low bits are stored in eax and the higher bits are stored edx 
; multiplies the value with eax and stores the result in edx:eax as a 64-bit value
mul valae

; divides a 64-bit value in edx:eax saving result in eax and remainder in edx
div value 

; ()crementation of a value in a register
inc eax ; increment by 1
dec eax ; decrement by 1
```

#### Logical Instructions
```asm
; Translate the hex into bits 
; Bitwise AND = { 1 and 1 = 1 || 0 and 1 = 0} 
and al, 0xXX 
; Bitwise OR = { 0 or 1 = 1 || 0 or 0 = 0 }
or al, 0xXX 
; Bitwise NOT inverts operand bits = { 00001111 -> 00001111 }
not al 
; Bitwise XOR 
; { 0xfc, 0x7c (eqv. 11111100 XOR 01111100) -> 10000000 } 
; { 0x7c, 0x7c = 00000000} XOR a register results in 0 
; XOR is used a more optimzed way to set a register to 00000000 than MOV 
xor al, 0xXX 
```

#### Conditionals

```asm
; TEST 
; bitwise AND, but sets the ZF if result is 0 
; used to check if an operand has a NULL value by testing against itself
; More optimal the comparing with value 0
test dst, src

; CMP
; compares 2 operands and set ZF or CF 
; dst - src = ZF | CF
cmp dst, src

```

#### Branching

Jump instructions

| **Instruction** | **Explanation** |
| ---- | ---- |
| `jz` | Jump if the ZF is set (ZF=1). |
| `jnz` | Jump if the ZF is not set (ZF=0). |
| `je` | Jump if equal. Often used after a CMP instruction. |
| `jne` | Jump if not equal. Often used after a CMP instruction. |
| `jg` | Jump if the destination is greater than the source operand. Performs signed comparison and is often used after a CMP instruction. |
| `jl` | Jump if the destination is lesser than the source operand. Performs signed comparison and is often used after a CMP instruction. |
| `jge` | Jump if greater than or equal to. Jumps if the destination operand is greater than or equal to the source operand. Similar to the above instructions. |
| `jle` | Jump if lesser than or equal to. Jumps if the destination operand is lesser than or equal to the source operand. Similar to the above instructions. |
| `ja` | Jump if above. Similar to jg, but performs an unsigned comparison. |
| `jb` | Jump if below. Similar to jl, but performs an unsigned comparison. |
| `jae` | Jump if above or equal to. Similar to the above instructions. |
| `jbe` | Jump if below or equal to. Similar to the above instructions. |
| `js`  | Jump if signed flag is set by an earlier instruction |

#### Function Calls
```asm
;
call location
```

#### Stack Calls
```
; Push a value from a source ONTO the stack 
push src

; `pusha` "push all words" pushes all 16 bit general purpose registers onto the stack: AX, BX, CX, DX, SI, DI, SP, BP
pusha

; `pushad` ` "push all double words" pushes all 32 bit general purpose registers onto the stack: EAX, EBX, ECX, EDX, ESI, EDI, ESP, EBP
pushad 

; Pop a value OFF the stack to a destination
pop dst

; `popa` "pop all words" pops the value sequentiall to all 16 bit general purpose registers from the top of the stack in THIS ORDER: DI, SI, BP, BX, DX, CX, AX
popa

; `popad` "pop all double words" pops the value sequentiall to all 32 bit general purpose registers from the top of the stack in THIS ORDER: EDI, ESI, EBP, EBX, EDX, ECX, EAX
; SP or ESP is also adjusted to point to the new top of the stack
popad 
```


## References

[THM x86 Assembly Room](https://tryhackme.com/room/x86assemblycrashcourse)
[Wikipedia Opcodes](https://en.wikipedia.org/wiki/Opcode)
[Wikipedia x86 assembly language](https://en.wikipedia.org/wiki/X86_assembly_language)
[THM x86 Architecture Overview Room](https://tryhackme.com/room/x8664arch)
[Wikipedia: x86 Instruction `test`](https://en.wikipedia.org/wiki/TEST_(x86_instruction) s
[System V Application Binary Interface—AMD64 Architecture Processor Supplement.](http://www.x86-64.org/documentation/abi.pdf)
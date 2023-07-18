# x86 Architecture

Is a [[CPU-Architecture]]

The CPU - *roughly*:
![](computerArchitecture.excalidraw.md)

Parts:
- Control Unit
- Arithmetic/Logic Unit
- Registers - *generally by type (all fit within bit width)* - either current or next as the last being store in the register:
	- Addresses - an address that points somewhere in memory or on the stack
	- Counters - for incrementation or decrementation 
	- Accumulator - (stores Results)
	- Instructions - stores instructions
	- Data 
- Cache - Fast memory but small place to store data within the CPU
- Buses (system or front-side bus)
	- Address bus -  sends ADDRESS of the instruction or data
	- Data bus - sends data between processor and the memory
	- Control bus - sends control signals such as: memory read, memory write
- RAM - Large block of memory to stores lots of data
- IO Device 
	- Keyboard, Mouse, Monitors, Disks, etc

[Von Nuemann Architecture](https://en.wikipedia.org/wiki/Von_Neumann_architecture) is just
```goat
					_________________________	
					[                       ]	
					[Central Processing Unit]
					[                       ]						
[Input Device] ->   [    [Control Unit]     ]  -> [Output Device]
					[[Arithmetic/Logic Unit]]
					[_______________________]
							|     ^
					  ______v_____|______
					 [    Memory Unit    ]
					 [___________________]
```


#### x86 Registers 

x64 | x86 | Description
--- | --- | ---
EAX | RAX | Accumulator Register - store results
EBX | RBC | Base Register - stores base address for referencing an offset
ECX | RCX | Counter Register - incrementation or decrementation retention
EDX | RDX | Data register - similar to the above used in multiplication and division 
ESP | RSP | Stack Pointer - point to the top the stack
EBP | RBP | Base Pointer - points to the base of the stack
ESI | RSI | Source Index Register - (for strings operations) used with the Data Segment (DS) register as an offset 
EDI | RDI | Destination Index Register - (for strings operations) used with the Extra Segment (ES) register as an offset.
EIP | RPI | Instruction Pointer - store the next instruction

[FLAGS Register](https://en.wikipedia.org/wiki/FLAGS_register) is a status register that contain a single state of set Status Flags for 32-bit systems it EFLAGS register:
- Zero Flag - ZF - result of last executed instruction is 0
- Carry Flag - CF - last executed instruction resulted in a number too big or too small for the destination
- Sign Flag - SF - result of an operation is negative or the most significant bit is set to 1
- Trap Flag - TF - indicates if the processor is in debugging mode (one instruction at a time) 

[x86 Segmentation](https://en.wikipedia.org/wiki/X86_memory_segmentation) is implementation of memory segmentation; Segment Registers are 16-bit registers that convert flat memory space into different segments for easier and more possible addressing:
- Code Segment - points to the Code section in the memory
- Data Segment - points to the program's Data section in the memory
- Stack Segment - points to the program's Stack in the memory
- Extra Segment - Programmer determined
- FS - use undefined by the hardware 
- Gs - use undefined by the hardware 

- Suffixes:
	- D stands for (Double|Long)-word (4 Bytes), 
	- W stands for Word (2 Bytes),
	- B stands for Byte (1 Byte). 
	- Without a suffix but relevant for a complete terminological diction: a Nibble is half of a Byte.

R8-R15 are 64- bit general purpose registers not present in 32-bit systems

#### Memory

- Stack - First-in-last-out section of memory where data is pushed on to the stack and popped after use, which entails control flow for the program as instruction-after-instruction is pushed then popped off the stack till programs termination.
	- Stack Frame
	- Stack Pointer points to the top of the stack and both increments and decrements 
	- Base Pointer points to the bottom of the stack and remains constant
	- Function Prologue:
		1. Arguments of a function are pushed to the stack before the function starts execution
		2. Return Address is pushed onto the stack
		3. Saved Based Pointer is pushed onto the stack
		4. Base pointer changed to current top of the Stack  
		5. Function then executes and the Stack pointer increments
	 - Function Epilogue:
		 - Old Base Pointer is popped off the stack and onto the Base Pointer when the function exits
		 - Return address is popped off to the Instruction Pointer
		 - Stack Pointer is rearranged to point to the top of the stack
- Code - contains the programs code
- Heap - a continuous two dimensional blob of memory of a set size that data is created and destroy during a programs execution
- Data - contains initialised data that is only constant


## References

[THM x86 Architecture Room](https://tryhackme.com/room/x8664arch)
[Wikipedia - Von Nuemann Architecture](https://en.wikipedia.org/wiki/Von_Neumann_architecture) 
[Computer Science Wiki - Architecture of the central processing unit (CPU)](https://computersciencewiki.org/index.php/Architecture_of_the_central_processing_unit_(CPU))
[Wikipedia FLAGS Register](https://en.wikipedia.org/wiki/FLAGS_register)
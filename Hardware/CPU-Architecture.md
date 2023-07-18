# CPU Architecture

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


## Endianess

Endianess is key to understanding that the most significant bit is located on either side of eight bits. **L**east for memory is **L**eftmost  **Least** significant, fortunately in English no matter the width.
```goat
LITTLE ENDIAN           0 1 0 1 0 1 0 1  <<THIS SIDE IS MOST IMPORTANT
                       ^LSB          MSB^    


BIG ENDIAN      THIS SIDE IS THE MOST IMPORTANT >> 1 0 1 0 1 0 1 0
                                                ^MSB            LSB^
```

## Registers

SI - IP Don't have corresponding higher and lower 8 bits
16 bit registers are below, `AH` would be higher 8 bits `AL` would be lower 8 bits

Register name | Purpose | Details
--- | --- | ---
AX | Accumulator | Arithmetical and logical instructions
BX | Base pointer | Base pointer for memory addresses
CX | Counter | Loop, shift, and rotation counter
DX | Data | I/O port addressing, multiplication, and division
SI | Source Index | Pointer addressing of data and source in string copy operations
DI | Destination Index | Pointer addressing of data and destination in string copy operations
BP | Base pointer | Pointer to top of stack when last function was called
SP | Stack pointer | Pointer to current height of the stack
IP | Instruction pointer | Pointer to the next code instruction to be executed


## References

[THM x86 Architecture Room](https://tryhackme.com/room/x8664arch)
[Wikipedia - Von Nuemann Architecture](https://en.wikipedia.org/wiki/Von_Neumann_architecture) 
[Computer Science Wiki - Architecture of the central processing unit (CPU)](https://computersciencewiki.org/index.php/Architecture_of_the_central_processing_unit_(CPU))



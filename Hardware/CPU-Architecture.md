# CPU Architecture


## Endianess

Endianess is key to understanding that the most significant bit is located on either side of eight bits. **L**east for memory is **L**eftmost  **Least** significant, fortunately in English no matter the width.
```
LITTLE ENDIAN           0 1 0 1 0 1 0 1  <<THIS SIDE IS MOST IMPORTANT
                        ^LSB       MSB^    


BIG ENDIAN      THIS SIDE IS THE MOST IMPORTANT >> 1 0 1 0 1 0 1 0
                                                   ^MSB       LSB^
```

## Register
SI - IP Don't have correspoinding higher and lower 8 bits
16 bit regiesters are below, `AH` would be higher 8 bits `AL` would be lower 8 bits
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






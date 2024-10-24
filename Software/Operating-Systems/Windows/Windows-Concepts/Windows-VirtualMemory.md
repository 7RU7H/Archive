# Windows Virtual Memory

Although this concept does not directly translate to Windows internals or concepts, it is crucial to understand. If understood correctly, it can be leveraged to aid in abusing Windows internals.

The theoretical maximum virtual address space is 4 GB on a 32-bit x86 system.
The theoretical maximum virtual address space is 256 TB on a 64-bit modern system.

This address space is split in half:
The lower half: `(0x00000000 - 0x7FFFFFFF)` is allocated to processes. 
The upper half: `(0x80000000 - 0xFFFFFFFF)`` is allocated to OS memory utilization. 

Administrators can alter this allocation layout for applications that require a larger address space through settings `((flag:)increaseUserVA)` or the AWE (Address Windowing Extensions).


## References

[THM Windows Internals Room](https://tryhackme.com/room/windowsinternals)
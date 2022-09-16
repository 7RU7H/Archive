# Windows Kernel 

Windows kernel will control all programs and processes and bridge all software and hardware interactions.An aplication cannot interact with the kernel or modify physical hardware and requires an interface. A windows processor has auser and kernel mode, the processor will switch between modes depending on access and request.

User mode	 |	Kernel Mode
--- | ---
No direct hardware access	 |	Direct hardware access
Creates a process in a private virtual address space |	Ran in a single shared virtual address space
Access to "owned memory locations"	 |	Access to entire physical memory

										
										
USER APPLICATION -> API (WIN32 API) ----switching_point---> system calls -> Kernel:(Physical Memory | Hardware)

## References

[THM Windows Internals Room](https://tryhackme.com/room/windowsinternals)
# Dynamic Link Libraries

## DLL Definition

Dynamic Link Libraries are files of functions, written in the same format as .exe files.  Windows Storage differs per architecture:
1. 64bit stored: System32 (contains the 64-bit (really really it does)
2. SysWOW64 (contains the 32 bit) (confusingly)


HAL.DLL: Hardware abstraction layer is the a kernel mode library file 
	- Not used by ANY user mmode programs

NTDLL.DLL: allows user mode programs to call the Windows Native API, (last resort or only option like at startup)

KERNNEL32.DLL: allows apps to call Win32 API for memory management, io, etc. Impliments much of the NTDLL functionality

USER32.DLL: call upon objects of user interface

ADVAPI32.DLL: call upon security features, registry manipulation



DLLs can be loaded in a program using load-time dynamic linking or run-time dynamic linking.
With load-time-dynamic linking:
	DLL function are called by the application; linking provided by header .h and import libraries .lib
With run-time dynamic linking:
	A function either LoadLibrary or LodaLibraryEx is used to load the DLL at run time
	Once loaded, GetProcAddress is required to identify the exported DLL function to call

In malicious code, threat actors will often use run-time dynamic linking more than load-time dynamic linking. This is because a malicious program may need to transfer files between memory regions, and transferring a single DLL is more manageable than importing using other file requirements.

DLL search order

Unsafe | Safer
--- | ---
Current Directory | Directory Applicqtion is loaded 
Directory Applicqtion is loaded | System32
System32 | 16 bit system file: Windows\System 
16 system file: Windows\System | C:\Windows
C:\Windows | Current Directory
%PATH% | %PATH%



## References

[THM Windows Internals Room](https://tryhackme.com/room/windowsinternals)
# Portable Executable format

Windows Executable file format, also PE (Portable Executable), is a datastructure ihold information for files to organize executable file code on a disk so that various Windows components can load this code into memory and executed it based on the parsed file information found in the PE. The PE defines the information about executables and stored data and the structure of how the data is stored and executed.
https://docs.microsoft.com/en-us/windows/win32/debug/pe-format	

- file.exe Contains:
	- Header(PE Format)
		- DOS Header
			- DOS Header defines the type of file 
			- MZ DOS header defines the file format 
			- DOS stub is a program run by default at the start printing a compatibility message.	
		- PE Header
			- PE File Header defines the format of the file, contains the signature, image file header and other information headers, PE is visable in the hex dump by the "PE" stub.
		- Image Optional Header - has a deceiving name, although still important
			- This header is optional in the sense that some files (specifically, object files) do not have it. For image files, this header is required.The optional header magic number determines whether an image is a PE32 or PE32+ executable.	
		- Data Dictionaries
			- Data Dictionaries are part of the image optional header, their purpose is to point to image data directory structure.
		- Section Table
			- Section Table defines the avaliable sections and information in the image
	- Sections(contents)
		- Code
		- Imports
		- Data

Contents of the data of the file:

Section | Purpose
--- | ---
.text | Contains executable code and entry point
.data  | Contains initialized data (strings, variables, etc.)
.bss | holds uninitialized data
.rdata | Contains read-only data
.edata | Contains exportable objects and related table information
.idata | Contains imported object and related table information
.reloc | Contains relocation information
.rsrc | Contains application resources (images, etc.)
.debug | Contains debug information  

## Role in AntiVirus Evasion

1. Packing and unpacking requires structural understanding and awareness
2. Malware analysts and AV software analyze .exe files based on information in the PE Header and Sections
3. Appropriate shellcode storage locations

## Tools

[PE-Bear](https://github.com/hasherezade/pe-bear-releases) *is a freeware reversing tool for PE files. Its objective is to deliver fast and flexible “first view” for malware analysts, stable and capable to handle malformed PE files.*


## References

[THM Windows Internals Room](https://tryhackme.com/room/windowsinternals)
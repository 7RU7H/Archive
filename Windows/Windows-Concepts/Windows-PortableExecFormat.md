# Portable executable format

Defines the information abnout executables and stored data and the structure of how the data is stored.
https://docs.microsoft.com/en-us/windows/win32/debug/pe-format	

   ____________________file.exe__________________
   |						|
Header:  Sections(contents)
(PE Format)
DOS Header				Code
PE Header				Imports
Optional Header				Data
Data Dictionaries
Section Table

DOS Header
MZ DOS header file format as .exe
DOS stub is a program run by default at the start printing a compatibility message.		

PE File Header
Defines the format file contains the signature, image file header and ofther information headers
PE is visable in the hex dump by the "PE" stub

Image Optional Header
This header is optional in the sense that some files (specifically, object files) do not have it. For image files, this header is required.The optional header magic number determines whether an image is a PE32 or PE32+ executable.

Data Dictionaries
DDs are part of the image optional header, their purpose is to point to image data directory structure.

Section Table
Defines the avaliable sections and information in the image, sections store:
Contents of file, code, imports, data

Contents of the data of the file:

Section | Purpose
--- | ---
.text | Contains executable code and entry point
.data  | Contains initialized data (strings, variables, etc.)
.rdata or .idata | Contains imports (Windows API) and DLLs.
.reloc | Contains relocation information
.rsrc | Contains application resources (images, etc.)
.debug | Contains debug information  



## References

[THM Windows Internals Room](https://tryhackme.com/room/windowsinternals)
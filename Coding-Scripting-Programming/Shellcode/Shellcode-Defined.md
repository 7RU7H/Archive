Shellcode is a set a machine code instruction made to make a vulnerable program run shellcode intended instruction not the vulnerable application's. It is written in Assembly Langauge ans translated into hexidecimal operational codes. Shellcode is injected into a process and executed vulnerable software or program. When writing [[Antivirus-Evasion-Shellcode]] the unque and custom wins. Either Assembly, C programming or `shellcraft` with [[Pwntools]] are required along with knowledge of CPU architectures and the operating systems the target shellcode to run on.


Syscalls (System Calls) are function that a program requests the kernel to perform either create, read, update, delete (CRUD), but also more specific contextual function like load and exit. 

Complete reference of available 64-bits Linux syscalls [https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)


## Shellcode Links

Linux 32bit `/bin/sh` x86 https://packetstormsecurity.com/files/115010/Linux-x86-execve-bin-sh-Shellcode.html

Windows x86 WinExec("cmd.exe",0) shellcode https://packetstormsecurity.com/files/137384/Windows-x86-WinExec-cmd.exe-0-Shellcode.html


## References

[https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)
[packetstormsecurity](x86 https://packetstormsecurity.com/files/)
[THM AV evasion shellcode](https://tryhackme.com/room/avevasionshellcode)
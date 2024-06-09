# Windows Memory Forensics


Windows uses not just RAM to manage volatile memory.

Concepts and Terminology:
- Page
	- A fixed-sized block of physical memory which an Operating System assigns and has upper-bound amount of. Default size is 4Kb
- RAM (Random Access Memory)
	- Memory is RAM!
	- Stores data 
- `pagefile.sys` as an extension to the RAM on the file system
	- Located at `C:\pagefile.sys`
	- Configuration in Registry found: 
		-  `SYSTEM Hive` : `Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management` 
	- [[FTK-Imager]] can be used to extract the `pagefile.sys`
	- `strings.exe C:\pagefile.sys > pagefile.strings`
	- `bulk_extractor.exe -o output .\pagefile.sys` - [bulk_extractor GitHub](https://github.com/simsong/bulk_extractor) [simsong GitHub](https://github.com/simsong) - **Authorial opinion**: very fast, very nice! 
		- [[Kali]] - [bulk-extractor for Kali](https://www.kali.org/tools/bulk-extractor/)
	- For some living off the land without `strings.exe` as a DFIR person [REF](https://superuser.com/questions/124081/is-there-a-windows-equivalent-of-the-unix-strings-command) `more < FILE_PATH.exe | findstr "."` 
- `hiberfil.sys` Microsoft can converts the RAM content into a hibernation file `hiberfil.sys`
#### Tooling

[[Volatility3]]

[[FTK-Imager]] can be used to extract the `pagefile.sys`

## References

[superuser - No strings.exe no problem](https://superuser.com/questions/124081/is-there-a-windows-equivalent-of-the-unix-strings-command)
[THM Analysing Volatile Memory (Windows)](https://tryhackme.com/r/room/analysingvolatilememory)
[simsong GitHub](https://github.com/simsong)
[bulk_extractor GitHub](https://github.com/simsong/bulk_extractor) 
[bulk-extractor for Kali](https://www.kali.org/tools/bulk-extractor/)
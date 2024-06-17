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
	- Located normally `C:\hiberfil.sys` 
		- Contains the follow non-exhaustive list:
		- The memory snapshot of the RAM at the time of hibernation.
		- Provide information about the user activities.
		- Running processes.
		- Network connections.
		- Recently opened files.
	- [[FTK-Imager]] can be used to extract the `hiberfil.sys` file
	- [[HibernationRecon]] can be used to decompress the `hiberfil.sys` file 
	- Then [[Volatility3]] or 2 to extract information from memory dump

#### Memory dumps

[Overview of memory dump file options for Windows - learn.microsoft.com ](https://learn.microsoft.com/en-us/troubleshoot/windows-server/performance/memory-dump-file-options)

Configuration options for Memory dumping:
`Control Panel` -> `System and Security` -> `System` -> `Advanced System Properties` -> `Settings` -> `Startup and Recovery settings` -> Drop down selection
- By default dumps to `%SystemRoot%\MEMORY.DMP`

Registry Key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl`:
- CrashDumpEnabled REG_DWORD 0x0 = None
- CrashDumpEnabled REG_DWORD 0x1 = Complete memory dump
- CrashDumpEnabled REG_DWORD 0x2 = Kernel memory dump
- CrashDumpEnabled REG_DWORD 0x3 = Small memory dump (64 KB)
- CrashDumpEnabled REG_DWORD 0x7 = [Automatic memory dump](https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/automatic-memory-dump)
Additional registry values for CrashControl:
- 0x0 = Disabled
- 0x1 = Enabled
- AutoReboot REG_DWORD 0x1
- DumpFile REG_EXPAND_SZ `%SystemRoot%\Memory.dmp`
- LogEvent REG_DWORD 0x1
- MinidumpDir REG_EXPAND_SZ `%SystemRoot%\Minidump`
- Overwrite REG_DWORD 0x1
- SendAlert REG_DWORD 0x1


Drop options Options explanation from [THM Analysing Volatile Memory (Windows)](https://tryhackme.com/r/room/analysingvolatilememory):

|Dump type  | Information |
|---|---|
| Small memory dump  |This option creates a small memory dump file (minidump) containing minimal information about the system state during the crash.|
|Kernel Memory Dump  |This option creates a dump file that contains all the kernel memory contents at the time of the crash. Kernel memory dumps can be significantly larger than small memory dumps.|
|Complete Memory Dump  |This option creates a dump file that contains all the contents of the physical memory (RAM) at the time of the crash. Complete memory dumps are the largest type of dump files.|
|Automatic memory dump  |This option is similar to the kernel memory dump but is automatically triggered when Windows detects a system crash. The size of the dump file is dynamically adjusted based on the amount of RAM installed in the system, ensuring enough space is available to capture the necessary information.|
|Active Memory Dump  |This option contains the memory dump of the active users and kernel modes.|



#### Tooling

[[Volatility3]]

[[FTK-Imager]] can be used to extract the `pagefile.sys`

## References

[superuser - No strings.exe no problem](https://superuser.com/questions/124081/is-there-a-windows-equivalent-of-the-unix-strings-command)
[THM Analysing Volatile Memory (Windows)](https://tryhackme.com/r/room/analysingvolatilememory)
[simsong GitHub](https://github.com/simsong)
[bulk_extractor GitHub](https://github.com/simsong/bulk_extractor) 
[bulk-extractor for Kali](https://www.kali.org/tools/bulk-extractor/)
[Overview of memory dump file options for Windows learn.microsoft.com ](https://learn.microsoft.com/en-us/troubleshoot/windows-server/performance/memory-dump-file-options)
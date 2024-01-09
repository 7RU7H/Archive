# Volatility3

[Volatility3](https://github.com/volatilityfoundation/volatility3) developers describe the Volatility framework: *"Volatility is the world's most widely used framework for extracting digital artifacts from volatile memory (RAM) samples. The extraction techniques are performed completely independent of the system being investigated but offer visibility into the runtime state of the system."*

The Volatility covered in this article will be `python3`, there are ten plus year of resources for the original. As of 2024 with the further shift from `python2` and the `setup.py` deprecated it is best to assume I will not cover Volatility(2).   

The Volatility distribution is available from: [http://www.volatilityfoundation.org](http://www.volatilityfoundation.org/)

The development branch from [Github](https://github.com/volatilityfoundation/volatility3)

Some useful dependencies:
[Yara-Python From VirusTotal](https://github.com/VirusTotal/yara-python) - The Python interface for [[YARA]]
[Capstone Engine](https://www.capstone-engine.org/download.html) - is a lightweight multi-platform, multi-architecture disassembly framework.

For collecting samples for analysis consider review the options in the article [[Memory-Extraction]]

## Plugins

Plugins are the tools for differing your typical analytical lenses with Volatility. They do not substitute for exploratory questioning as methodology, only enhance the potential for finding better answers. 

- [Community plugins for Volatility3](https://github.com/volatilityfoundation/community3) - contains Volatility3 plugins developed and maintained by the community.

Previous Volatility versions would require manual identification of OS profile - OS and its build version. Volatility3 will automatically identify the host and build of the memory file, but you need to specify the operating system prior to specifying the plugin to be used for example:
- `windows.info`, `linux.info` and `mac.info`.

## Cheatsheet

#### REMEMBER TO DOWNLOAD THE SYMBOLS TABLES!

[Documentation](https://volatility3.readthedocs.io/en/latest/volatility3.plugins.html) and Initial Assimilation from [Andrea Fortuna](https://github.com/andreafortuna)

```bash
python3 vol.py -h # Help information
python3 vol.py -v # Verbosity
python3 vol.py -f /file/path/dump.vmem # Load a memory dump to analyse 
python3 vol.py -p /file/path/plugin # Load a plugin 
python3 vol.py -o /file/path/output # Output file path 
```

Consider reading these:

https://eforensicsmag.com/finding-advanced-malware-using-volatility/


callbacks - `.callbacks` - Lists kernel callbacks and notification routines.

cmdscan - `.cmdscan` - searches the memory of csrss.exe on XP/2003/Vista/2008 and conhost.exe on Windows 7

consoles - `.consoles` - finds commands that attackers typed into cmd.exe or executed via backdoors. However, instead of scanning for `COMMAND_HISTORY`, this plugin scans for `CONSOLE_INFORMATION`

dlldump - `.dlldump` - extract a DLL from a process’s memory space and dump it to disk for analysis

dlllist - `.dlllist` - list all DLLs associated with processes at the time of extraction

driverirp - `.driverirp`  - List IRPs for drivers in a particular windows memory image.

driverscan - `.driverscan` - scan drivers present of the system at the time extraction - identify files that were missed or hidden by this plugin - use brain for what is *not* there... 

enumfunc - `enumfunc` - numerates imported and exported functions from processes, dlls, and kernel drivers.

envars - `.envars` - display a process’s environment variable

evtlogs - `.evtlogs` - extracts and parses binary event logs from memory
- `--save-evt` to dump raw event logs

filescan - `filescan` - Scans for file objects present in a particular windows memory image.

getsids - `.getsids` - get process Security Identifiers

handles - `.handles` - Lists process open handles.

idt - `.idt` - Checks if the Interrupt-Descriptor Table (IDT) has been altered  
imageinfo - `.info` - takes the provided memory dump and assign it a list of the best possible OS profiles - its a suggestion

iehistory - `iehistory` - recovers fragments of IE history index.dat cache files

kdbgscan - `kdbgscan` - scans the KDBGHeader signature linked to Volatility profiles

kpcrscan - `kpcrscan` - scan for potential KPCR structures - [Andreas Fortuna](https://andreafortuna.org/2017/06/25/volatility-my-own-cheatsheet-part-1-image-identification/): *If the `KdVersionBlock` is not null, then it may be possible to find the machine's KDBG address via the KPCR. In fact, the backup method of finding KDBG used by plugins such as pslist is to leverage `kpcrscan` and then call the `KPCR.get_kdbg()` API function.*

malfind - `.malfind` -  hunt for code injection - scans heap to identify executable bit set to `RWE` or `RX` 

memmap - `.Memmap` - shows you exactly which pages are memory resident, given a specific process DTB (or kernel DTB if you use this plugin on the Idle or System process)
```bash
-f $image -o /tmp windows.memmap.Memmap --pid $suspiciousPID --dump 
strings *.dmp | grep -i "user-agent"
```

memdump - `memdump` -  extract all memory resident pages in a process

modscan - `.modscan` - Scans for modules present in a particular windows memory image.

modules `.modules` - dump list of loaded kernel modules

netstat  - `.netstat` -  identify network connectsion present at time of extraction
- Note: `windows.netstat` can be very unstable, particularly around old Windows builds - it maybe preferable to use kali official - https://tools.kali.org/forensics/bulk-extractor

procdump - `.procdump` - dump a process’s executable
- Use `--memory` to include slack space between the PE sections that aren't page aligned.
- pass the `--unsafe` or `-u` flags to bypass certain sanity checks used when parsing the PE header

psdispscan - `.psdispscan` - enumerates processes by scanning for `DISPATCHER_HEADER` instead of pool tags

pslist - `.pslist` - basic way of listing processes

psscan - `.psscan` - find data structures that match `_EPROCES` - find unlinked process from the process list 

pstree - `.pstree` - list process based on parent PID 
https://gleeda.blogspot.com/2010/12/identifying-memory-images.html

ssdt - `.ssdt` - search for System Service Descriptor Table (SSDT) hooking has legimate uses, but malware will hook this table to modify pointers to point to locations the malware controls 

vacdump - `.vacdump` - extract the range of pages described by a VAD node

vadinfo - `.vadinfo` - VAD is [B Dolan-Gavitt](https://www.sciencedirect.com/science/article/pii/S1742287607000503) Virtual Address Descriptor tree is used by the Windows memory manager to describe memory ranges used by a process - [Andreas Fortuna](https://andreafortuna.org/2017/07/10/volatility-my-own-cheatsheet-part-3-process-memory/):
-   The address of the MMVAD structure in kernel memory
-   The starting and ending virtual addresses in process memory that the MMVAD structure pertains to
-   The VAD Tag
-   The VAD flags, control flags, etc
-   The name of the memory mapped file (if one exists)
-   The memory protection constant (permissions). Note there is a difference between the original protection and current protection. The original protection is derived from the flProtect parameter to VirtualAlloc. For example you can reserve memory (MEM_RESERVE) with protection PAGE_NOACCESS (original protection). Later, you can call VirtualAlloc again to commit (MEM_COMMIT) and specify PAGE_READWRITE (becomes current protection). The vadinfo command shows the original protection only. Thus, just because you see PAGE_NOACCESS here, it doesn’t mean code in the region cannot be read, written, or executed.

Additional information on VAD: https://www.dfrws.org/sites/default/files/session-files/paper-the_vad_tree_-_a_process-eye_view_of_physical_memory.pdf

vadtree - `.vadtree` - display the VAD nodes in a visual tree form

vadwalk - `.vadwalk` - inspect a process’s VAD nodes in table form

verinfo - `verinfo` - display the version information embedded in PE files

yarascan - `.yarascan` - compare the memory file against YARA rules


### ! Not covered in Volatility3

apihooks - `.apihooks` (apparently is on the to-do) - https://github.com/volatilityfoundation/volatility3/issues/686
moddump - `.moddump`

## References

[Capstone Engine](https://www.capstone-engine.org/download.html)
[volatility3 Documentation](https://volatility3.readthedocs.io/en/latest/volatility3.plugins.html)
[http://www.volatilityfoundation.org](http://www.volatilityfoundation.org/)
[Yara-Python From VirusTotal](https://github.com/VirusTotal/yara-python) 
[Python3 Volatility Dev Branch Github](https://github.com/volatilityfoundation/volatility3)
[Community plugins for Volatility3](https://github.com/volatilityfoundation/community3)
[Incident Response & Computer Forensics](https://www.oreilly.com/library/view/incident-response/9780071798686/index.html)
[Finding Kernel Global Variables Blog](https://moyix.blogspot.com/2008/04/finding-kernel-global-variables-in.html)
[Identifying Memory Images](https://gleeda.blogspot.com/2010/12/identifying-memory-images.html)
[somedieyoung Vol and Wannacry blog](https://medium.com/ax1al/volatility-wannacry-5845957948b6)
[mnin The mis-leading 'Active' in PsActiveProcessHEad and ActiveProcessLinks ](https://mnin.blogspot.com/2011/03/mis-leading-active-in.html)
[The VAD Tree - B Dolan-Gavitt](https://www.sciencedirect.com/science/article/pii/S1742287607000503)
[The Art of Memory Forensics: Detecting Malware and Threats in Windows, Linux, and Mac Memory](https://www.wiley.com/en-gb/The+Art+of+Memory+Forensics:+Detecting+Malware+and+Threats+in+Windows,+Linux,+and+Mac+Memory-p-9781118825099)
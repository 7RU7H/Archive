# Windows Registry Forensics

For more information locally on Windows Registry and its hives see [[Windows-Registry]] page; the Registry Hives are located `C:\Windows\System32\Config`.
## Data Acquisition

#### Live Acquisition

Live Acquisition is acquisition completed on a running system, It leaves artefacts of the act Acquisition and is used to save time. By the Live this means:
- Windows OS is loaded into memory
- Registry hive files are locked on disk, requiring special tooling
- `CurrentControlSet` key is loaded, which denote the active configuration of the live system

 Issues:
 - Data artefacts are created from Live Acquisition
 - Potential **overwriting of potentially crucial data!** 
	 - [[FTK-Imager]] will add an entry to all the registry keys that keep track of program execution
 
#### Cold Acquisition

Cold Acquisition is acquisition completed on a system not running. A image of the disk is used instead of the original disk to maintain the integrity of the original evidence to prove the evidence was not tampered and results are then reproducible. 
1. A full disk image is acquired with the use of a write blocker. 
2. The disk image is hashed 
3. The disk image is copied
4. Forensic analysis is applied to on the copy of the original disk image - [[FTK-Imager]] and [[Autopsy]] can perform both steps below simultaneously:
	1. Mount the image using image mounting software
	2. Extract data from the mounted image

##### Data Acquisition

**Beware** for live acquisition data collected contains changes that are still not written in the registry hive, but have been made.

For live system disk acquisition with [[FTK-Imager]]:
`File` -> `Add Evidence Item` select `Logical Drive`

For cold system disk acquisition:
`File` -> `Add Evidence Item` select `Image File`

For live system registry acquisition:
Option 1:
1. Click `Obtain Protected Files` option in [[FTK-Imager]] 
	- Looks like yellow cube, with two black protruding lines with four dots in the shape of a diamond (its supposed to look like a safe)
2. This option will not acquire all the registry hives:
	- Amcache hive (program execution information)
Option 2:
Navigate to desired file system location of a registry hive and export the required files with `Export Files`

## References

[THM Expediting Registry Analysis Room](https://tryhackme.com/r/room/expregistryforensics)
[THM Forensics Room 1](https://tryhackme.com/room/windowsforensics1)

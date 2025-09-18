# MacOS DFIR

# MacOS DFIR

Challenges
- Some disks are soldered to motherboard
- Hardware encryption 
	- T2-based chips, Apple stores the encryption key of the SSD in a secure enclave separate from the CPU
- FileVault encryption
- File Disk Access 
	- Change with `Settings -> Privacy & Security -> Full Disk Access`
- System Integrity Protection
	- disable with `csrutil disable`

```bash
csrutil disable


```

To mount an APFS formatted drive on a Linux system use: [apfs-fuse GitHub](https://github.com/sgan81/apfs-fuse)
```bash
# List all volumes
apfsutil $macdisk.img

# Mount with apfs-fuse
apfs-fuse mac-disk.img $dirToMountTo

```


MacOS DFIR -  [Kernelcon - Digital Forensic Investigation with Sarah Edwards](https://www.youtube.com/watch?v=ZJOd1DZ4nsM)
```bash
# Checks remote access for her ease
history -c
# Find weird directories, commands

# Check proceses
ps aux | grep $Naming

# Check daemons, LaunchAgents - look for odd .plist
# Cross check with a clean system for ease of identifying weirdness
cd /System/Library/LaunchAgents/
cd /System/Library/LaunchDaemons/
# `plutil` Check the syntax of property list files, or convert a plist file from one format to another
# MRT is the malware Removal tool - example only
plutil -p com.apple.MRTd.plist
# from the dictionary output check the ProgramArguments 

# Although mentioned try different encodings
strings $binary
```
[plutil](https://www.unix.com/man-page/osx/1/plutil/)

```bash

# Manage disks
diskutil
diskutil apfs
diskutil apfs list # list APFS volumes

cd 
ls 
 
```

## References

[Kernelcon - Digital Forensic Investigation with Sarah Edwards](https://www.youtube.com/watch?v=ZJOd1DZ4nsM)
[plutil documentation](https://www.unix.com/man-page/osx/1/plutil/)
[THM MacOS Forensics Basics](https://tryhackme.com/room/macosforensicsbasics)
# FTK Imager

[FTK Imager](https://www.exterro.com/ftk-imager) is a [[Digital-Forensics]] tool that allows forensic specialists whom have acquired computer data to then perform analysis without affecting the original evidence, preserving its authenticity, integrity, and validity for presentation during a trial in a court of law. It is premium software. 
- UI Features: 
	- Evidence Tree Pane which displays a hierarchical view of the added evidence sources?
	- File List Pane
		- Corrupted file - 0 file size
		- Obfuscated - conflicting file  extension and header information
		- Deleted files marked with an `X`
	- Viewer Pane to show file contents
- Forensic Features:
	- Detect Encryption

- `File > Verify Drive/Image` to obtain its MD5 and SHA1 hashes.

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

[FTK Imager](https://www.exterro.com/ftk-imager) 
[THM Advent of Cyber2023](https://tryhackme.com/room/adventofcyber2023)
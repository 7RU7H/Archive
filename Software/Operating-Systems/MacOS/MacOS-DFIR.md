# MacOS DFIR

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


## References
 [Kernelcon - Digital Forensic Investigation with Sarah Edwards](https://www.youtube.com/watch?v=ZJOd1DZ4nsM)
[plutil documentation](https://www.unix.com/man-page/osx/1/plutil/)
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

#### Tooling

Community tooling exists for a reason.

To mount an APFS formatted drive on a Linux system use: [apfs-fuse GitHub](https://github.com/sgan81/apfs-fuse)
[DB Browser for SQLite](https://sqlitebrowser.org/) 


[THM references: mac4n6 for DB query, but there is a lot of information here](https://www.mac4n6.com/blog/2018/8/5/knowledge-is-power-using-the-knowledgecdb-database-on-macos-and-ios-to-determine-precise-user-and-application-usage?rq=knowledgec)
[APOLLO](https://github.com/mac4n6/APOLLO) for meta information and information about what to extract from the databases 

[plistutil](https://github.com/libimobiledevice/libplist) for plist parsing

[mac_apt](https://github.com/ydkhatri/mac_apt) for artefact processing that can output to CSV, JSON and other format conversion

[Mandiant's Unified Logs Parser](https://github.com/mandiant/macos-UnifiedLogs) utility for log parsing (can convert to CSV and JSON)

`log` with [predicate](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Predicates/Articles/pSyntax.html) flag for filtering

[[CyberChef]] for epoch conversion and other things: `https://cyberchef.io/#recipe=From_UNIX_Timestamp('Seconds (s)')`
#### Cheatsheet


```bash
# Manage disks
diskutil
diskutil apfs
diskutil apfs list # list APFS volumes

# List all volumes for volume number
apfsutil $macdisk.img

# Mount with apfs-fuse
apfs-fuse -v $volumeNumber mac-disk.img $dirToMountTo

# OS version - System Volume
cat /System/Library/CoreServices/SystemVersion.plist
# Mac Serial Number is found either (use sqlite DB browser):
/private/var/folders/*/$DARWIN_USER_DIR/C/locationd/consolidated.db /private/var/folders/*/$DARWIN_USER_DIR/C/locationd/cache_encryptedA.db
# Installation date
stat -x /private/var/db/.AppleSetupDone # just `stat` no flags on linux 
plistutil -p /private/var/db/softwareupdate/journal.plist

# Timezone enumeration involves following the symlink 
ls -la /etc/localtime
# or parsing
plistutil -p /Library/Preferences/.GlobalPreferences.plist
# Check if location services are active
plistutil -p /Library/Preferences/com.apple.timezone.auto.plist



#  Generally it is best to use a tool to parse plist files
# Apple tool
plutil -p $file.plist
# or Community tool
plistutil /System/Library/CoreServices/SystemVersion.plist


# Use db brower sqlite for database files

# Use APOLLO to find information about what to extract from Databases 
python3 apollo.py extract -osql_json -pyolo -vyolo modules tmp_apollo

# System Logs (apple system logs) are stored
ls -la /private/var/log/asl/
ls/private/var/log/system.log
# Unifed logs
/private/var/db/diagnostics/*.tracev3
/private/var/db/uuidtext.

# On a live MacOS system use:
open -a Console /private/var/log/asl/<log>.asl

# Zgrep for boot up and shutdown times (LIVE)
zgrep BOOT_TIME system.log*
zgrep SHUTDOWN_TIME system.log.*
# Use cyberchef for epoch conversion https://cyberchef.io/#recipe=From_UNIX_Timestamp('Seconds (s)')
 

# Mandiant's ULP
./unifiedlog_parser -h
# -> `loginwindow` for screen lock, unlock, and other login-related information

# On live systems we can use
log show --last 1m
# Filter logs with --predicate
# Filter for AirDrop Discoverable status
log show --predicate 'subsystem=="com.apple.sharing" and category=="AirDrop" and eventMessage contains "Discoverable"'
# Filter for logins
log show --info --predicate 'eventMessage contains "com.apple.system.loginwindow" and eventMessage contains "SessionAgentNotificationCenter"' 


# Network interfaces
/Library/Preferences/SystemConfiguration/NetworkInterfaces.plist
# DHCP settings (file.plist per interface!) en0 is builtin
/private/var/db/dhcpclient/leases/en0.plist
# Wireless
/Library/Preferences/com.apple.wifi.known-networks.plist

log show --info --predicate 'senderImagePath contains "IPConfiguration" and (eventMessage contains "SSID" or eventMessage contains "Lease" or eventMessage contains "network changed")'

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



## References

[Kernelcon - Digital Forensic Investigation with Sarah Edwards](https://www.youtube.com/watch?v=ZJOd1DZ4nsM)
[plutil documentation](https://www.unix.com/man-page/osx/1/plutil/)
[THM MacOS Forensics Basics](https://tryhackme.com/room/macosforensicsbasics)
[THM MacOS Forensic Artefacts](https://tryhackme.com/room/macosforensicsartefacts)
[apfs-fuse GitHub](https://github.com/sgan81/apfs-fuse)
[DB Browser for SQLite](https://sqlitebrowser.org/) 
[THM references: mac4n6 for DB query, but there is a lot of information here](https://www.mac4n6.com/blog/2018/8/5/knowledge-is-power-using-the-knowledgecdb-database-on-macos-and-ios-to-determine-precise-user-and-application-usage?rq=knowledgec)
[APOLLO](https://github.com/mac4n6/APOLLO) 
[plistutil](https://github.com/libimobiledevice/libplist) 
[mac_apt](https://github.com/ydkhatri/mac_apt) 
[Mandiant's Unified Logs Parser](https://github.com/mandiant/macos-UnifiedLogs)
[`log`predicate](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Predicates/Articles/pSyntax.html) 
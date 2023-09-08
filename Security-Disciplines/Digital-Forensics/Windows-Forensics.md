# Windows Forensics

Tools are not analysis, but a means to collect and marshal data.
- [[Autopsy]]
- [[Regshot]]
- [[Eric-Zimmerman-Tools]]
- [[Sysinternals]]
- [[Kape]]
- [FTK Imager](https://www.exterro.com/ftk-imager) 

##  System Information 

OS Version:
`SOFTWARE\Microsoft\Windows NT\CurrentVersion`

Current Control set:
- `HKLM\SYSTEM\CurrentControlSet`
- `SYSTEM\Select\Current`
- `SYSTEM\Select\LastKnownGood`

Computer Name:
`SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName`

Time Zone Information:
`SYSTEM\CurrentControlSet\Control\TimeZoneInformation`

Network Interfaces and Past Networks:
`SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces`

Autostart Programs (Autoruns):
- `NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\Run`
- `NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\RunOnce`
- `SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce`
- `SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer\Run`
- `SOFTWARE\Microsoft\Windows\CurrentVersion\Run`

## Accounts

SAM hive and user information:
`SAM\Domains\Account\Users`

## Registry


For a cheatsheet and short explanations of Hives and Keys see [[Windows-Registry]]. Bear in mind in attempting to copy the registry hives from `%WINDIR%\System32\Config` you will not be able, as it is a restricted file. Use:
- [[Kape]]
- [[Autopsy]]
- [FTK Imager](https://www.exterro.com/ftk-imager) is similar to Autopsy

After extraction:
- [AccessData's Registry Viewer](https://accessdata.com/product-download/registry-viewer-2-0-0) has a similar user interface to the Windows Registry Editor - load one hive at a time and it can't take the transaction logs into account.
- [RegRipper](https://github.com/keydet89/RegRipper3.0) no transaction logs - but good for information deobfuscation
- [Eric Zimmerman tools](https://ericzimmerman.github.io/#!index.md) - [[Eric-Zimmerman-Tools]], Registry Explorer
	- Point Registry Explorer to the .LOG1 and .LOG2 files with the same filename as the registry hive to automatically integrate the transaction logs and create a 'clean' hive. 

Registry hives are located :
- `C:\Windows\System32\Config`
	- **DEFAULT** (mounted on `HKEY_USERS\DEFAULT`)
	- **SAM** (mounted on `HKEY_LOCAL_MACHINE\SAM`) - `C:\Windows\System32\Config`
	- **SECURITY** (mounted on `HKEY_LOCAL_MACHINE\Security`)
	- **SOFTWARE** (mounted on `HKEY_LOCAL_MACHINE\Software`)
	- **SYSTEM** (mounted on `HKEY_LOCAL_MACHINE\System`)
	- User profile related is stored `C:\Users\<username>\`
		- **NTUSER.DAT** (mounted on `HKEY_CURRENT_USER` when a user logs in)
				`C:\Users\<username>\`
		- **USRCLASS.DAT** (mounted on `HKEY_CURRENT_USER\Software\CLASSES`)
			- `USRCLASS.DAT` hive is located in the directory `C:\Users\<username>\AppData\Local\Microsoft\Windows`

## File Systems

For both FAT and NTFS file systems  [[Windows-File-System]]

Shortcut file for each file opened either locally or remotely containing information about its usage.
Shortcut file locations:
`C:\Users\<username>\AppData\Roaming\Microsoft\Windows\Recent\`
`C:\Users\<username>\AppData\Roaming\Microsoft\Office\Recent\`

LECmd.exex to parse shortcut files
`LECmd.exe -f <path-to-shortcut-files> --csv <path-to-save-csv>`

Recent Files:
`NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs`

Internet Explorer / Edge History
`C:\Users\<username>\AppData\Local\Microsoft\Windows\WebCache\WebCacheV*.dat`

Office Recent Files:
`NTUSER.DAT\Software\Microsoft\Office\VERSION`
`NTUSER.DAT\Software\Microsoft\Office\VERSION\UserMRU\LiveID_####\FileMRU`

ShellBags:
- `3USRCLASS.DAT\Local Settings\Software\Microsoft\Windows\Shell\Bags`
- `USRCLASS.DAT\Local Settings\Software\Microsoft\Windows\Shell\BagMRU`
- `NTUSER.DAT\Software\Microsoft\Windows\Shell\BagMRU`
- `NTUSER.DAT\Software\Microsoft\Windows\Shell\Bags`

Open/Save and LastVisited Dialog MRUs:
- `NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePIDlMRU`
- `NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRU`

Windows Explorer Address/Search Bars:
- `NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths`
- `NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\Explorer\WordWheelQuery`


## File Recovery

[[Autopsy]]

## Evidence of Execution

UserAssist:
`NTUSER.DAT\Software\Microsoft\Windows\Currentversion\Explorer\UserAssist\{GUID}\Count`

ShimCache:
`SYSTEM\CurrentControlSet\Control\Session Manager\AppCompatCache`

AmCache:
`Amcache.hve\Root\File\{Volume GUID}\`

BAM/DAM:
- `SYSTEM\CurrentControlSet\Services\bam\UserSettings\{SID}
- `SYSTEM\CurrentControlSet\Services\dam\UserSettings\{SID}

Program usage information is stored and loaded from:
`C:\Windows\Prefetch`

Prefetch Parser (PECmd.exe) to parse a File
`PECmd.exe -f <path-to-Prefetch-files> --csv <path-to-save-csv>`

Prefetch Parser (PECmd.exe) to parse Directory
`PECmd.exe -d <path-to-Prefetch-directory> --csv <path-to-save-csv>`

Windows 10 Timeline can be found:
`C:\Users\<username>\AppData\Local\ConnectedDevicesPlatform\{randomfolder}\ActivitiesCache.db`

WxTCmd.exe for parsing Windows 10 Timeline
`WxTCmd.exe -f <path-to-timeline-file> --csv <path-to-save-csv>`

Jumplist locations
`C:\Users\<username>\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations`

Parse Jumplists using JLECmd.exe:
`JLECmd.exe -f <path-to-Jumplist-file> --csv <path-to-save-csv>`

## External Devices/USB devices

Setup information is stored in:
`C:\Windows\inf\setupapi.dev.log`

Device identification:
`SYSTEM\CurrentControlSet\Enum\USBSTOR`
`SYSTEM\CurrentControlSet\Enum\USB`
First/Last Times:
`SYSTEM\CurrentControlSet\Enum\USBSTOR\Ven_Prod_Version\USBSerial#\Properties\83da6326-97a6-4088-9453-a19231573b29}\####``
- `Oo64=first connection`
- `0066=last connection`
- `0067=last removal`

USB device Volume Name:
`SOFTWARE\Microsoft\Windows Portable Devices\Devices`


## References

[Eric ZimmermanGithub.io](https://ericzimmerman.github.io/#!index.md)
[THM Windows Froensic Room 2](https://tryhackme.com/room/windowsforensics2)
[THM Windows Forensics Room 1](https://tryhackme.com/room/windowsforensics1)
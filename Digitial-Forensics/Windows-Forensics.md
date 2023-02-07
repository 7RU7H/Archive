
## Registry

For a cheatsheet and short explainations of Hives and Keys see [[Windows-Registry]]. Bear in mind in attempting to copy the registry hives from `%WINDIR%\System32\Config` you will not be able, as it is a restricted file. Use:
- [[KAPE]]
- [[Autopsy]]
- [FTK Imager](https://www.exterro.com/ftk-imager) is similar to Autopsy

After extraction:
- [AccessData's Registry Viewer](https://accessdata.com/product-download/registry-viewer-2-0-0) has a similar user interface to the Windows Registry Editor - load one hive at a time and it can't take the transaction logs into account.
- [RegRipper](https://github.com/keydet89/RegRipper3.0) no transaction logs
- [Eric Zimmerman tools](https://ericzimmerman.github.io/#!index.md)

## File Systems

For both FAT and NTFS file systems  [[Windows-File-System]]

Shortcut file for each file opened either locally or remotely containing information about its usage.
Shortcut file locations:
`C:\Users\<username>\AppData\Roaming\Microsoft\Windows\Recent\`
`C:\Users\<username>\AppData\Roaming\Microsoft\Office\Recent\`

LECmd.exex to parse shortcut files
`LECmd.exe -f <path-to-shortcut-files> --csv <path-to-save-csv>`

I/E/Edge History
`C:\Users\<username>\AppData\Local\Microsoft\Windows\WebCache\WebCacheV*.dat`


## File Recovery

[[Autopsy]]

## Evidence of Execution

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


## References

[Eric ZimmermanGithub.io](https://ericzimmerman.github.io/#!index.md)
[THM Windows Froensic Room 2](https://tryhackme.com/room/windowsforensics2)
[THM Forensics Room 1](https://tryhackme.com/room/windowsforensics1)

# Eric Zimmerman Tools

[Eric Zimmerman's tools](https://ericzimmerman.github.io/#!index.md) are commonly used in [[Windows-Forensics]]

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

Shortcut file locations:
`C:\Users\<username>\AppData\Roaming\Microsoft\Windows\Recent\`
`C:\Users\<username>\AppData\Roaming\Microsoft\Office\Recent\`

LECmd.exex to parse shortcut files
`LECmd.exe -f <path-to-shortcut-files> --csv <path-to-save-csv>`

Registry Explorer


## References

[Eric ZimmermanGithub.io](https://ericzimmerman.github.io/#!index.md)
[THM Windows Froensic Room 2](https://tryhackme.com/room/windowsforensics2)
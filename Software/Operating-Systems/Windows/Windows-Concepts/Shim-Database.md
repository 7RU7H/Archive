# Shim Database

[pentestlab.blog](https://pentestlab.blog/methodologies/red-teaming/persistence/)  *"Microsoft in order to resolve the problem with legacy applications that are no compatible with newer Windows operating systems released the application compatibility toolkit (ACT). This software enables system administrators and developers to create fix packages for installed applications. The toolkit is part of the Windows [Assessment and Deployment Kit](https://docs.microsoft.com/en-gb/windows-hardware/get-started/adk-install) (ADK) and its usage requires administrator level privileges."*

Shim database is database as compatibility feature as [MITRE Application Shimming T1546](https://attack.mitre.org/techniques/T1546/011/) explains (mirrored here) : 
>For example, the application shimming feature allows developers to apply fixes to applications (without rewriting code) that were created for Windows XP so that it will work with Windows 10*" 
  Within the framework, shims are created to act as a buffer between the program (or more specifically, the Import Address Table) and the Windows OS. When a program is executed, the shim cache is referenced to determine if the program requires the use of the shim database (.sdb). If so, the shim database uses hooking to redirect the code as necessary in order to communicate with the OS.
  A list of all shims currently installed by the default Windows installer (sdbinst.exe) is kept in:
> - `%WINDIR%\AppPatch\sysmain.sdb` and
> - `hklm\software\microsoft\windows nt\currentversion\appcompatflags\installedsdb`
  Custom databases are stored in: 
 - `%WINDIR%\AppPatch\custom & %WINDIR%\AppPatch\AppPatch64\Custom` and
 > - `hklm\software\microsoft\windows nt\currentversion\appcompatflags\custom`
>To keep shims secure, Windows designed them to run in user mode so they cannot modify the kernel and you must have administrator privileges to install a shim. However, certain shims can be used to [Bypass User Account Control](https://attack.mitre.org/techniques/T1548/002) (UAC and RedirectEXE), inject DLLs into processes (InjectDLL), disable Data Execution Prevention (DisableNX) and Structure Exception Handling (DisableSEH), and intercept memory addresses (GetProcAddress).
>Utilizing these shims may allow an adversary to perform several malicious acts such as elevate privileges, install backdoors, disable defenses like Windows Defender, etc. [[2]](http://files.brucon.org/2015/Tomczak_and_Ballenthin_Shims_for_the_Win.pdf) Shims can also be abused to establish persistence by continuously being invoked by affected programs.*


[Eric Zimmerman](https://ericzimmerman.github.io/#!index.md)'s SDBExplorer or alternatively [Evil-E's sdb-explorer](https://github.com/evil-e/sdb-explorer)

[learn.microsoft - Windows Shim Database Types](https://learn.microsoft.com/en-us/windows/win32/devnotes/shim-database-types)

| Constant/value                                | Description                                                                        |
| --------------------------------------------- | ---------------------------------------------------------------------------------- |
| **SDB_DATABASE_MAIN**<br><br>0x80000000       | The main database. If this flag is not present, the database is a custom database. |
| **SDB_DATABASE_SHIM**<br><br>0x00010000       | The database contains application entries to be shimmed.                           |
| **SDB_DATABASE_MSI**<br><br>0x00020000        | The database contains MSI entries.                                                 |
| **SDB_DATABASE_DRIVERS**<br><br>0x00040000    | The database contains driver block entries.                                        |
| **SDB_DATABASE_DETAILS**<br><br>0x00080000    | The database contains Apphelp details.                                             |
| **SDB_DATABASE_SP_DETAILS**<br><br>0x00100000 | The database contains SP Apphelp details.                                          |
| **SDB_DATABASE_RESOURCE**<br><br>0x00200000   | The resource DLL contains Apphelp details.                                         |
| **SDB_DATABASE_TYPE_MASK**<br><br>0xF02F0000  | A mask used to extract main database information.                                  |
| **SDB_DATABASE_MAIN_SHIM**                    | SDB_DATABASE_SHIM \| SDB_DATABASE_MSI \| SDB_DATABASE_MAIN                         |
| **SDB_DATABASE_MAIN_MSI**                     | SDB_DATABASE_MSI \| SDB_DATABASE_MAIN                                              |
| **SDB_DATABASE_MAIN_DRIVERS**                 | SDB_DATABASE_DRIVERS \| SDB_DATABASE_MAIN                                          |
| **SDB_DATABASE_MAIN_DETAILS**                 | SDB_DATABASE_DETAILS \| SDB_DATABASE_MAIN                                          |
| **SDB_DATABASE_MAIN_SP_DETAILS**              | SDB_DATABASE_SP_DETAILS \| SDB_DATABASE_MAIN                                       |
| **SDB_DATABASE_MAIN_RESOURCE**                | SDB_DATABASE_RESOURCE \| SDB_DATABASE_MAIN                                         |

Windows API has 51 functions with C/C++ like [learn.microsoft sdbopendatabase()](https://learn.microsoft.com/en-us/windows/win32/devnotes/sdbopendatabase) for CRUDinog shim database - you could also make a custom one.
```cpp
PDB WINAPI SdbOpenDatabase(
  _In_ LPCTSTR   pwszPath,
  _In_ PATH_TYPE eType
);
```
## References

[pentestlab.blog](https://pentestlab.blog/methodologies/red-teaming/persistence/) 
[learn.microsoft - Windows Shim Database Types](https://learn.microsoft.com/en-us/windows/win32/devnotes/shim-database-types)
[learn.microsoft sdbopendatabase](https://learn.microsoft.com/en-us/windows/win32/devnotes/sdbopendatabase)
[MITRE Application Shimming T1546](https://attack.mitre.org/techniques/T1546/011/)
[Eric Zimmerman](https://ericzimmerman.github.io/#!index.md)
[Evil-E's sdb-explorer](https://github.com/evil-e/sdb-explorer)
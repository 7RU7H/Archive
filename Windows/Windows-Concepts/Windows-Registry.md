# Windows Registry 


If you want to grab a copy the registry hives from `%WINDIR%\System32\Config`, you cannot because it is a restricted file. Use:
- [[Kape]]
- [[Autopsy]]
- [FTK Imager](https://www.exterro.com/ftk-imager) is similar to Autopsy

After extraction:
- [AccessData's Registry Viewer](https://accessdata.com/product-download/registry-viewer-2-0-0) has a similar user interface to the Windows Registry Editor - load one hive at a time and it can't take the transaction logs into account.
- [RegRipper](https://github.com/keydet89/RegRipper3.0) no transaction logs
- [Eric Zimmerman tools](https://ericzimmerman.github.io/#!index.md)


## Key Properties

REG_SZrepresents a single null terminated string

Run OR RunOnce

## Key Layout
Root keys:
    HKEY_CURRENT_USER
		Root of all configuration information for the current user - HKCU
		Environment # user environment variables
    HKEY_HKEY_USERS
		Contains all the actively loaded user profiles on the computer - HKU
			Registry hive 	Supporting files
			`HKEY_CURRENT_CONFIG`	System, System.alt, System.log, System.sav
			`HKEY_CURRENT_USER` 	Ntuser.dat, Ntuser.dat.log
			`HKEY_LOCAL_MACHINE\SAM` 	Sam, Sam.log, Sam.sav
			`HKEY_LOCAL_MACHINE\Security` 	Security, Security.log, Security.sav
			`HKEY_LOCAL_MACHINE\Software` 	Software, Software.log, Software.sav
			`HKEY_LOCAL_MACHINE\System` 	System, System.alt, System.log, System.sav
			`HKEY_USERS\.DEFAULT` 	Default, Default.log, Default.sav
		HKCU is a subkey of HKU
    HKEY_LOCAL_MACHINE
		Configuration information of the local machine - HKLM
		`\SYSTEM\CurrentControlSet\Control\Session Manager\Environment`	System environment variables
    HKEY_CLASSES_ROOT
		`Subkey HKLM\Software` - HKCR, stores information program execution:
		From Windows 2000 `HKCU\Software\Classes would override the defaults of HKLM\Software\Classes`
		HKCR merges a view of the registry from both sources and back compatible with earlier windoes versions
		Be considerate of the parent/child structuring when store keys where exeisting keys enter the search chain
   HKEY_CURRENT_CONFIG
		Contains information about the hardware profile that is used by the local computer at system startup.
   HKEY_PERFORMANCE_DATA
		Stores information related to system performance, THE DATA associated with this key is reference by registry functions   

Predefined keys: HKEY_CLASSES_ROOT, HKEY_CURRENT_CONFIG, HKEY_CURRENT_USER, HKEY_CURRENT_USER_LOCAL_SETTINGS, HKEY_LOCAL_MACHINE, HKEY_PERFORMANCE_DATA, HKEY_PERFORMANCE_NLSTEXT, HKEY_PERFORMANCE_TEXT, HKEY_USERS

Registry Functions

Function |	Description
--- | --- 
GetSystemRegistryQuota  |	Retrieves the current size of the registry and the maximum size that the registry is allowed to attain on the system.
RegCloseKey  |	Closes a handle to the specified registry key.
RegConnectRegistry |	Establishes a connection to a predefined registry handle on another computer.
RegCopyTree |	Copies the specified registry key, along with its values and subkeys, to the specified destination key.
RegCreateKeyEx |	Creates the specified registry key.
RegCreateKeyTransacted |	Creates the specified registry key and associates it with a transaction.
RegDeleteKey |	Deletes a subkey and its values.
RegDeleteKeyEx |	Deletes a subkey and its values from the specified platform-specific view of the registry.
RegDeleteKeyTransacted |	Deletes a subkey and its values from the specified platform-specific view of the registry as a transacted operation.
RegDeleteKeyValue |	Removes the specified value from the specified registry key and subkey.
RegDeleteTree |	Deletes the subkeys and values of the specified key recursively.
RegDeleteValue |	Removes a named value from the specified registry key.
RegDisablePredefinedCache |	Disables handle caching for the predefined registry handle for HKEY_CURRENT_USER for the current process.
RegDisablePredefinedCacheEx |	Disables handle caching for all predefined registry handles for the current process.
RegDisableReflectionKey |	Disables registry reflection for the specified key.
RegEnableReflectionKey |	Enables registry reflection for the specified disabled key.
RegEnumKeyEx |	Enumerates the subkeys of the specified open registry key.
RegEnumValue |	Enumerates the values for the specified open registry key.
RegFlushKey |	Writes all attributes of the specified open registry key into the registry.
RegGetKeySecurity |	Retrieves a copy of the security descriptor protecting the specified open registry key.
RegGetValue |	Retrieves the type and data for the specified registry value.
RegLoadKey |	Creates a subkey under HKEY_USERS or HKEY_LOCAL_MACHINE and stores registration information from a specified file into that subkey.
RegLoadMUIString |	Loads the specified string from the specified key and subkey.
RegNotifyChangeKeyValue |	Notifies the caller about changes to the attributes or contents of a specified registry key.
RegOpenCurrentUser |	Retrieves a handle to the HKEY_CURRENT_USER key for the user the current thread is impersonating.
RegOpenKeyEx |	Opens the specified registry key.
RegOpenKeyTransacted |	Opens the specified registry key and associates it with a transaction.
RegOpenUserClassesRoot |	Retrieves a handle to the HKEY_CLASSES_ROOT key for the specified user.
RegOverridePredefKey |	Maps a predefined registry key to a specified registry key.
RegQueryInfoKey |	Retrieves information about the specified registry key.
RegQueryMultipleValues |	Retrieves the type and data for a list of value names associated with an open registry key.
RegQueryReflectionKey |	Determines whether reflection has been disabled or enabled for the specified key.
RegQueryValueEx |	Retrieves the type and data for a specified value name associated with an open registry key.
RegReplaceKey |	Replaces the file backing a registry key and all its subkeys with another file.
RegRestoreKey |	Reads the registry information in a specified file and copies it over the specified key.
RegSaveKey |	Saves the specified key and all of its subkeys and values to a new file.
RegSaveKeyEx |	Saves the specified key and all of its subkeys and values to a new file. You can specify the format for the saved key or hive.
RegSetKeyValue |	Sets the data for the specified value in the specified registry key and subkey.
RegSetKeySecurity |	Sets the security of an open registry key.
RegSetValueEx |	Sets the data and type of a specified value under a registry key.
RegUnLoadKey |	Unloads the specified registry key and its subkeys from the registry.

By default, there are four Run and RunOnce keys, which live under HKEY_LOCAL_MACHINE and HKEY_CURRENT_USER:
```cmd
HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run 
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run 
HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\RunOnce 
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce
```
MAC address:
```
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\ {4D36E972-E325-11CE-BFC1-08002BE10318}
IP address:
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces
```

Accessing Registry Hives(offline):
	
A majority are stored: `C:\Windows\System32\Config`

Hive | Mounting 
--- | ---
DEFAULT |	(mounted on HKEY_USERS\DEFAULT)
SAM |	(mounted on HKEY_LOCAL_MACHINE\SAM)
SECURITY |	(mounted on HKEY_LOCAL_MACHINE\Security)
SOFTWARE |	(mounted on HKEY_LOCAL_MACHINE\Software)
SYSTEM  |	mounted on HKEY_LOCAL_MACHINE\System)

Hives containing user information both of these files are hidden files

.DAT | Mounted | File system location
--- | --- | ---
NTUSER.DAT | (mounted on HKEY_CURRENT_USER when a user logs in) | Located: C:\Users\<username>\
USRCLASS.DAT | (mounted on HKEY_CURRENT_USER\Software\CLASSES) |  Located: C:\Users\<username>\AppData\Local\Microsoft\Windows

The Amcache Hive:
Windows creates this hive to save information on programs that were recently run on the system. Stores additional data related to program executions.
```powershell
C:\Windows\AppCompat\Programs\Amcache.hve
Amcache.hve\Root\File\{Volume GUID}\ //last executed programs
```

Current Control Set:
Hive contains the machines configuration data used for controlling system startup are called
Control Sets
```
SYSTEM\ControlSet001
SYSTEM\ControlSet002
```
To detirmine the current control set for the most accurate system information is registry:
```powershell
SYSTEM\Select\Current
# The "last known good" configurations:
SYSTEM\Select\LastKnownGood
```

Volatile Control Set when machine is live: `CurrentControlSet = HKLM\SYSTEM\CurrentControlSet`

Account RIDs
```
SAM\Domains\Account\Users\Names
```
User Account Creation:
```powershell
SAM\Domains\Accounts\User\{HEX}\$letter
```
Computer name:
```powershell
SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName
SYSTEM\ControlSet001\Control\ComputerName\ComputerName  
```
Time zone information:
```powershell
SYSTEM\CurrentControlSet\Control\TimeZoneInformation
```
Command related
```powershell
# Commands executed
SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU
# Excution totals
SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\UserAssist
```
Binaries Executed
```powershell
NTUSER.DAT\Software\Microsoft\Windows\Currentversion\Explorer\UserAssist\{GUID}\Count
```

Network related 
```powershell
# Network interfaces 
SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces
# Past networks:
SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\Unmanaged
SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\Managed
# Network connections
SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles
# Last Assign DHCP IP
HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces
```
Autoruns:
```powershell
NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\Run
NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\RunOnce
SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce
SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer\Run
SOFTWARE\Microsoft\Windows\CurrentVersion\Run
```
Services:
```powershell
SYSTEM\CurrentControlSet\Services
```
SAM hive:
```powershell
SAM\Domains\Account\Users
```
Recent Files:
```powershell
NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs
NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs\.by-some-file-extension
```
Recent Office Files:
```powershell
NTUSER.DAT\Software\Microsoft\Office\VERSION
NTUSER.DAT\Software\Microsoft\Office\15.0\Word
NTUSER.DAT\Software\Microsoft\Office\VERSION\UserMRU\LiveID_####\FileMRU
```
File Shares
```
SYSTEM\ControlSet001\SErvices\LanmanSErver\Shares
```

Shellbags:
```powershell
USRCLASS.DAT\Local Settings\Software\Microsoft\Windows\Shell\Bags
USRCLASS.DAT\Local Settings\Software\Microsoft\Windows\Shell\BagMRU
NTUSER.DAT\Software\Microsoft\Windows\Shell\BagMRU
NTUSER.DAT\Software\Microsoft\Windows\Shell\Bags
```
Open/Save and LastVisited Dialog MRUs:
```powershell
NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePIDlMRU
NTUSER.DAT\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRU
```
UserAssist:
```powershell
NTUSER.DAT\Software\Microsoft\Windows\Currentversion\Explorer\UserAssist\{GUID}\Count
```
ShimCache keeps track of application compatibility with the OS and all launched on machine
Also called AppCompatCache:

```powershell
SYSTEM\CurrentControlSet\Control\Session Manager\AppCompatCache
```

Command to parse the Shimcache:
```powershell
AppCompatCacheParser.exe --csv <path to save output> -f <path to SYSTEM hive for data parsing> -c <control set to parse>
```

BAM/DAM - Background activity monitor, Desktop activity monitor
```powershell
SYSTEM\CurrentControlSet\Services\bam\UserSettings\{SID}
SYSTEM\CurrentControlSet\Services\dam\UserSettings\{SID}
```

Device Identification:
```powershell
SYSTEM\CurrentControlSet\Enum\USBSTOR
SYSTEM\CurrentControlSet\Enum\USB
	First/Last Times:
SYSTEM\CurrentControlSet\Enum\USBSTOR\Ven_Prod_Version\USBSerial#\Properties\{83da6326-97a6-4088-9453-a19231573b29}\####
```

USB device Volume Name:
```powershell
SOFTWARE\Microsoft\Windows Portable Devices\Devices
```


## References

[THM Forensics Room 1](https://tryhackme.com/room/windowsforensics1)
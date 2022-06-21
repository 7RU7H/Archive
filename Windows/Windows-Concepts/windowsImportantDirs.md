# Directories
```batch
    \PerfLogs: Stores Windows performance logs, note that it maybe empty on a default configuration of Windows.

    \Program Files: This directory is found on both 32-bit and 64-bit versions on Windows. 
	On 32-bit editions, this is the only Program Files directory available, and it stores 32-bit programs. 
	On 64-bit versions of Windows, this directory stores 64-bit programs.

    \Program Files (x86): This directory can be found on 64-bit editions of Windows and stores 32-bit versions of programs.

    \ProgramData: This is a hidden directory that contains program data that is expected to be accessed by computer programs regardless of the logged in user account.

    \Users: Every user who has logged in to the OS at least once will have a subdirectory created under their name in this directory.

    \Users\Public: This is a subdirecotry of \Users<\fp> and contains user data. It can be accessed by all users, and is used to share files among them. It can also be accessed across the network from valid user accounts with remote access permissions.

    \Users\[UserName]\AppData: This is a hidden subdirectory of \Users. It stores application data and settings for every user. 
		\AppData contains three additional subfolders, namely \Roaming, \Local, and LocalLow. 
			\Roaming is used for network-based logins for roaming profiles and synchronizes the user's data when they log in to the computer. The Windows per-user temporary directory, 
			\Temp, can be found here under \Local.

    \Windows: This stores the main Windows installation and contains files related to the OS itself.

    \System, \System32, and \SysWOW64: These directories store dynamic-link library (DLL)4 files that execute the core features of Windows and the Windows API. The nomenclature for these directories can by a bit confusing. 
			\System stores 16-bit DLLs and is usually empty on 64-bit editions of Windows because 16-bit applications cannot run on 64-bit OSs. 
			\System32 stores either 32-bit or 64-bit DLL files, depending on whether a 32-bit or 64-bit edition of Windows is running. 
			\SysWOW64 is found only on 64-bit editions of Windows, and despite its name, stores 32-bit DLLs.
```

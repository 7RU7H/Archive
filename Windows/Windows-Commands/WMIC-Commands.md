# WMIC Commands

```wmic
wmic /?
wmic context                                            display the state of all the global switches in windows
wmic bios get serialnumber                              as stated
wmic bios get version                                   as stated
wmic qfe list                                           hotfixID listing
wmic product get name                                   ALL installed application in Windows
wmic product get name,version /format:csv 		List all installed products and version
wmic qfe list | find /c /v ""                           Count the number of Installed Updates in windows
wmic cpu get numberofcore                               as stated
wmic process where ExecutablePath='C:\\...\\*.exe       fill in path to find Process of a system32 or other .exe
wmic /node:IP /user:/password:computersystem get username 

wmic qfe list                                           LIST patch history!!!
wmic qfe get Caption,Description,HotFixId,InstalledOn           Patch level!

wmic ntevent where (message like "%explorer%") list brief CHECK ALL INTERNET EXPLORER LOGS

wmic csproduct get name                                 	get product system id

wmic process list                                       	as stated 
wmic process where (processid=PROCID_HERE) get parentprocessid	get parent process
wmic product get name,version					..
wmic process where "name='*.exe'" get ProcessID ExecutablePath
#THE ABOVE is list all executable paths of a running process
wmic process get ProcessID,ExecutablePath,parentprocessid, ..	as stated

wmic os get version                                     as stated
wmic port get name                                      get I/O ports!


#Detect antivirus 
wmic /namespace:\\root\securitycenter[] path antivirusproduct
```

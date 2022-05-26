# cmd.exe - cli

```powershell
$driveletter:		change drive!

echo use the streams > file.txt:<stream> 	create secondary data stream, use dir /R to see alternate data streams
		     < file.txt:<stream>	pass the stream of file.txt to ..

certutil -hashfile file <digest name e.g. sha256>


systeminfo

noun query	A useful verb to inquire as to info of the previous noun
noun delete	delete functionality relating to the noun
noun export	

help | /?	help and shortcut
ver		version
cmd 		Starts a new instance of the Windows command interpreter.
exit 		Quits the cmd.exe program (command interpreter).
net		On non domain-controller, is used to perform operations on Groups, users, account policies, shares, and so on.

time		TIME!?!
cd 		Displays the name of or changes the current directory.
cls 		Clears the screen.
copy 		Copies one or more files to another location.
robocopy	similar to copy but with network interuption support

icacls		Modify File or Folder permissions
	/grant|deny username:(F)  # Fullcontrol, see /? for more permission types
	/T	Execute recursively on all subfolders
	/C	Force continue despite errros
	/L	Execute on the Symbolic Link itself`

dir 		Displays a list of files and subdirectories in a directory.
	/A		hidden
	/T:W/C/A 	last written/created/accessed
	/S		subdirectories
	/r		alternate streams 

tree		Graph of Directories
	/F	To see files
forfiles	Selects a file (or set of files) and executes a command on that file. This is helpful for batch jobs.

echo 		Displays messages, or turns command echoing on or off.
	echo 2> Create an empty file

move 		Moves one or more files from one directory to another directory; 
	C:\src\* \dst

erase 		Deletes one or more files.
del 		Deletes one or more files.

find 		Searches for a text string in a file or files. 		

findstr 	Searches for strings in files.
	/s	Recursive
	/m 	paths of files
	/c:""	literal string


mkdir 		Creates a directory.
mklink		Make a symbolic linking hard(/h)or soft(shortcuts)
more 		Displays output one screen at a time.
ren 		Renames a file or files.
rmdir 		Removes a directory.
type 		Displays the contents of a text file.
runas		
	/user:Administrator "cmd"
fc		file compare


reg		interact with registry
regedit		gui for registry 

fsutil		tasks related to file allcation table(FAT) and NTFS file system, reparse points, sparse files, dismounting of volumes.
	fsinfo
		drives
		drivetype
		volumeinfo	

set		Displays stored environment variables
set VAR		To temporarily change the value of environment variables in the current shell
        	PATH=C:\YourFavouritePrivEscDir # for Hijack Execution Flow
        		# change PATH to friendly directory and drop malicious .exe, call the legitimate exe but it run the closest searched PATH variable
setx    	To permanently change value by modifying the register.
		Similar but requires new command prompt, then run set.
	/S	remotes system, /u [domain]\user /p password
	/M	make variable system wide
setx /M PATH "%PATH%;<your-new-path # trunication occurs %PATH%, concatenation of SYSTEM+ USER  values; add that to the 2nd arg of setx
setx PATH ~PATH~ # use the search path defined in the PATH environment

setx [/s <computer> [/u [<domain>\]<user name> [/p [<password>]]]] /f <filename> {[<variable>] {/a <X>,<Y> | /r <X>,<Y> <String>} [/m] | /x} [/d <delimiters>]
		
Environment Variable 	Purpose
PATH 			Holds the search path for executable files
USERNAME 		Shows the currently logged on user
TEMP 			Returns the default temporary storage directory(ies)
USERPROFILE 		Holds the profile location of the current user

tasksch
    /Create        	Creates a new scheduled task.
    /Delete      	Deletes the scheduled task(s).
    /Query      	Displays all scheduled tasks.
    /Change    		Changes the properties of scheduled task.
    /Run     		Runs the scheduled task on demand.
    /End     	 	Stops the currently running scheduled task.
    /ShowSid	        Shows the security identifier corresponding to a scheduled 

tasklist # NOTE THAT PARENT PROCESS ENUMERATION IS BEST DONE WITH WMIC OR POWERSHELL
	/FI		Filter by criteria
	/SVC		Services hosted by each process
	/S		Remote system specify
	/M		List all or specified task using the given exe/dll
	/V		Verbose SHOWS USERS
	/V /FI "IMAGENAME eq TASKNAME.EXE" # find user running the process 
	/fi "USERNAME eq NT AUTHORITY\SYSTEM" /fi "STATUS eq running" # All proccess under SYSTEM

# sc
sc query		Shows current state service, certian codes specific service
sc qc 			Shows if autoastart enabled, dependencies, binary path name
sc start
sc stop
sc config <svc> *=	Set configuration of a service see /? for type of configuration changes avaliable

taskkill 
	/PID int


# Checksum a file
Certutil -hashfile \FULLPATH\ [EncryptionMethod]
```

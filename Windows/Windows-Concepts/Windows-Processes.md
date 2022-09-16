# Windows Processes

[From](https://docs.microsoft.com/en-us/windows/win32/procthread/about-processes-and-threads): *"Each process provides the resources needed to execute a program. A process has a virtual address space, executable code, open handles to system objects, a security context, a unique process identifier, environment variables, a priority class, minimum and maximum working set sizes, and at least one thread of execution."*

Remember to consider modern CPUs and [[Threading]]

## Process Component Purposes
Process Component 	|	Purpose
--- | ---
Private Virtual Address Space | Virtual memory addresses that the process is allocated.
Executable Program	 | Defines code and data stored in the virtual address space.
Open Handles | Defines handles to system resources accessible to the process.
Security Context | The access token defines the user, security groups, privileges, and other security information.
Process ID | Unique numerical identifier of the process.
Threads | Section of a process scheduled for execution.

## Depiction of a process in memory
Component | Purpose
--- | ---
Code | Code to be executed by the process.
Global Variables | Stored variables.
Process Heap | Defines the heap where data is stored.
Process Resources | Defines further resources of the process.
Environment Block | Data structure to define process information.

## Threads
Component |  Purpose
--- | ---
Stack  | All data relevant and specific to the thread (exceptions, procedure calls, etc.)
Thread Local Storage | Pointers for allocating storage to a unique data environment
Stack Argument | Unique value assigned to each thread
Context Structure | Holds machine register values maintained by the kernel

## cmd:tasklist
Exe | Description 
--- | ---
smss.exe | Session Manager responsible for mapping out virtual address space
winlogon.exe | Windows Logon is responsible loading and authenticating profiles
csrss.exe | Client server runtime process, begins shutdown sequence when terminated
wininit.exe | Windows Startup is responsible for triggering a crucial set of User mode applictions run to maintain a system's stability and functionality
explorer.exe  | Renders most of Windows GUI shell, userinit.exe exit as explorer.exe is started
MsMpEng | Microsoft Defender

reference:https://andreafortuna.org/2017/06/15/standard-windows-processes-a-brief-reference/

WINDOWS 7 WINDOWS 10 is at the bottom as to changes
dle and System

    Created by ntoskrnl.exe via the process manager function, which creates and terminates processes and threads.
    No visible parent processes
    System has a static PID of 4
    System creates smss.exe
    There should only be one system process running

SMSS — Session Manager

    First user mode process
    Parent process is System
    Base Priority of 11
    Username: NT AUTHORITY\SYSTEM
    Performs delayed file delete/rename changes
    Loads known dlls
    Runs from \%systemroot%\System32\smss.exe
    Creates session 0 (OS services)
    Creates session 1 (User session)
    Creates csrss and winlogon then exits, which is why they have no parent process and they both have session ids of 1
    Runs within session 0
    Only one smss.exe process should be running at one time. The second smss.exe process exits, so you will only see the one running in session 0.
    There can be more sessions if more users are logged on to the system. 0 and 1 are for a single user logged onto the system.

CSRSS.EXE — Client/Server Run

    Windows subsystem process.
    Base Priority of 13
    \%SystemRoot%\system32\csrss.exe
    Username: NT AUTHORITY\SYSTEM
    Creates/Deletes processes and threads, Temp files, etc.
    In XP its used to draw text based console windows. Under Windows 7, the conhost process now does that functionality. For example, cmd.exe
    One csrss process per session
    Its name is often used by malware to hide on systems (CSSRS.EXE, CSRSSS.EXE, etc.)
    Runs within session 0

WININIT.EXE — Windows Initialization Process

    Parent to services.exe (SCM), lsass.exe and lsm.exe
    Created by smss.exe, but since smss.exe exits there is no parent to WININIT.
    Base Priority of 13
    Username: NT AUTHORITY\SYSTEM
    \%SystemRoot%\system32\wininit.exe
    Performs user-mode initialization tasks
    Creates \%windir%\temp
    Runs within session 0

SERVICES.EXE — Service Control Manager

    Child to WININIT.EXE
    Parent to services such at svchost.exe, dllhost.exe, taskhost.exe, spoolsv.exe, etc. Services are defined in SYSTEMCurrentControlSetServices
    \%SystemRoot%\System32\wininit.exe
    Username: NT AUTHORITY\SYSTEM
    Base Priority of 9
    Loads a database of services into memory
    Runs within session 0
    There should only be one services.exe process running

LSASS.EXE — Local Security Authority

    Child to WININIT.EXE
    Only one lsass.exe process
    %SystemRoot%\System32\lsass.exe
    Responsible for local security policy to include managing users allowed to login, password policies, writing to the security event log, etc.
    Often targeted by malware as a means to dump passwords. Also mimicked by malware to hide on a system (lass.exe, lssass.exe, lsasss.exe, etc.). These “fake” names will not be a children of wininit.exe.
    Base Priority of 9
    Username: NT AUTHORITY\SYSTEM
    Runs within session 0
    It should not have child processes

SVCHOST.EXE — Service Hosting Process

    Multiple instances of svchost.exe can/do exist/run
    %SystemRoot%\System32\svchost.exe
    Username: Should only be one of three options: NT AUTHORITY\SYSTEM, LOCAL SERVICE, or NETWORK SERVICE
    Should always have a parent of services.exe
    Base Priority of 8
    Often mimicked (scvhost, svch0st, etc.) When they are mimicked they will not be running as children to services.exe.
    Command Line: svchost.exe -k <name>
    -k <name> values should exist within the Software\Microsoft\Windows NT\CurrentVersion\Svchost registry key
    Often times when malware uses the actual svchost.exe to load their malicious service they will not include -k command line parameters and be running under a username that does not match on of the three listed in bullet 3.
    They should all be running within session 0

LSM.EXE — Load Session Manager Service

    Manages the state of terminal server sessions on the local machine. Sends the requests to smss.exe to start new sessions.
    Child to wininit.exe
    It should not have child processes
    Receives logon/off, shell start and termination, connect/disconnects from a session, and lock/unlock desktop
    %systemroot%\System32\lsm.exe
    Base Priority of 8
    Username: NT AUTHORITY\SYSTEM
    Runs within session 0

WINLOGON.EXE — Windows Logon Process

    No parent process
    Could have a child process of LogonUI if smartcard, etc. are used to authenticate
    LogonUI will terminate once the user enters their password. Once password is entered the verification is sent over to LSASS and it’s verified via Active Directory or SAM (the registry hive SAM), which stores local users and group information.
    Base Priority of 13
    Runs within session one
    Handles interactive user logons/logoffs when SAS keystroke combination is entered (Ctrl+Alt+Delete)
    Loads Userinit within Software\Microsoft\Windows NT\CurrentVersion\Winlogon
    The userinit value in the registry should be: Userinit.exe, (note the comma). Malware will sometimes add additional values to this key, which will load malware upon successful logons.
    Userinit.exe exits once it runs so you wont see this process running when you look.
    Userinit initializes the user environment. This includes running GPOs and logon scripts.
    Will run Shell value located at Software\Microsoft\Windows NT\CurrentVersion\Winlogon within the registry. The value of shell should be Explorer.exe. Malware will also use this sometimes to execute malware by adding values.
    Since Userinit exists this is also why Explorer.exe doesn’t have a parent process.

Explorer.exe — AKA Windows Explorer

    No parent process since Userinit.exe exits
    The value “Explorer.exe” is stored in shell value within the registry. The registry location is here: Software\Microsoft\Windows NT\CurrentVersion\Winlogon\Shell
    Base Priority of 8
    Username: The logged on user account.
    %Systemroot%\Explorer.exe
    This will contain multiple child processes.
    Some of you might know this better as, “Windows Explorer”
    This process is often targeted by malware. Malware will often times inject this process. One indication of this is if Explorer.exe is connecting out to the internet. There are other indicators, but that’s another post. We are keeping it simple here.

Great, but Windows 10?

However, this (great!) list needs some upgrades after the release of Windows 10.
So, you can find some useful information on this post on forensicsfocus.com:

Some highlights:

    System still has the PID 4 and is the parent of the Windows Session Manager. I will also mention that it still resides at %systemroot%\system32.
    All services are started from executable files from their former locations
    There are still two Client Server Runtime Processes (csrss.exe), one of which has the same parent as wininit.exe from an ended smss.exe process.
    The super-process winit.exe spawns services.exe, lsass.exe and the invisible lsm.exe process to start the Local Session Manager. Starting from Windows 8, lsm.exe is started inside a Service Host process from svchost.exe from the command line %systemroot%\system32\svchost.exe -k DcomLaunch.
    The WinLogon Service, which is responsible for Interactive Logons on a Windows Operating System, remains where it has always been for Session 1 and is started for every interactive user session.
    Microsoft has renamed the Host Process for Windows Tasks again. In Windows 7 it was named taskhost.exe, in Windows 8 it was called taskhostex.exe and the new name is taskhostw.exe in Windows 10.
    The primary purpose, serving as a generic “Host Process”, remains unchanged, as does the location in %systemroot%\system32.
    The Console Windows Host conhost.exe has been running as a child of cmd.exe since Windows 8, and not as a child of csrss.exe as it was in Windows 7. The executable file for Pathping is a child of cmd.exe in the same way conhost.exe is. There is no longer any separation of conhost.exe under the user’s own Client Server Runtime Service csrss.exe and the cmd.exe process under explorer.exe.

The new Microsoft Edge web browser, the successor of Internet Explorer. Microsoft Edge starts four processes:

    Two processes named MicrosoftEdgeCP.exe, started from C:\Windows\SystemApps with the permission of the current user. Microsoft Edge starts with two of them for the first visible tab inside the browser window. Both are child processes of RuntimeBroker.exe, which is a child of svchost.exe, the Host Process for Windows Services. Runtime Broker starts automatically with the Operating System.
    A new MicrosoftEdge process is started under the Runtime Broker Service for every new tab that is opened by the browser. Microsoft is also introducing the new path %systemroot%\SystemApps and starting a web browser as a sub-child of svchost.exe, which breaks traditions in the process design.
    Directly spawned from svchost.exe is the process MicrosoftEdge.exe (without “CP” at the end of the file name). This is the main browser application process. And again, the executable file is saved in a subfolder of C:\Windows\SystemApps.
    The Host Process svchost.exe starts a fourth executable file called browser_broker.exe.
    This time Microsoft is following its own design traditions and has stored the file in the well-known path %systemroot%\system32.



## References

[THM Windows Internals Room](https://tryhackme.com/room/windowsinternals)
[Win32 about-processes-and-threads documentation](https://docs.microsoft.com/en-us/windows/win32/procthread/about-processes-and-threads)

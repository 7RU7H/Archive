# Azure Administration Microsoft Entra ID 

Azure Active Directory renamed on to Microsoft Entra ID as on July 2023.

[Microsoft Entra ID  (once Azure AD)](https://learn.microsoft.com/en-us/azure/active-directory/) is Microsoft's multi-tenant cloud-based directory and identity management service. AD and AD Cloud are just local and remote variants of AD, both are in use today and connectable with Hybrid Cloud. 

A very helpful explanation from [John Savill](https://www.youtube.com/watch?v=JIjijcXoQt4): Entra is a entrance (like a door) to entire features cloud with identity to protect everything behind that entrance.
Active Directory is not Microsoft Entra ID formerly known as Azure AD: 
- Microsoft Entra ID is flat, Active Directory domains are trees and forest 
- Domain controllers are deployed only when required for compatibility for Domain Services

See [[Active-Directory]] for on-premise AD definitions and descriptions. It is the principle Identity and Access management service. Authorise and authenticate to multiple sources: 
- On-Premise AD, Internal resources and apps located on your corporate network
- Web-Application - IpD - google login 
- External resources like Microsoft 365, the Azure portal, and SaaS applications.
- Cloud apps developed for your organisation.
- Flat - No OUs or GPOs
 
Internal Resources | External  Resources
--- | --- 
Application within your internal network | Microsoft Office 365
Access to on-premises workstations | Azure Portal
... | SaaS Application

![](azureadexample.png)

#### Microsoft Entra ID  Editions

![](azureadeditions.png)

Tiers:
- Microsoft Entra ID Free
- Microsoft Entra ID Microsoft 365 Apps
- Microsoft Entra ID Premium P1 
- Microsoft Entra ID Premium P2

See [Microsoft Entra ID pricing](https://www.microsoft.com/en-gb/security/business/microsoft-entra-pricing?rtc=1)

#### Features

Microsoft espoused features
![1000](azureadfeatures.png)

Considerations:
- SSO for accessibility for consistent UX experience to cloud or on-premise resources for users.
- Secure remote access - centralized authorization management, MFA2
- Advanced Data protection
- Cost reduction and self -service options


#### Terminology and Concepts

Microsoft Entra ID  concept | Description
--- | ---
Identity | is an object that can be authenticated 
Account | is an identity that has data associated with it 
Microsoft Entra ID  account | is an identity that's created through Microsoft Entra ID  or another Microsoft cloud service  
Microsoft Entra Tenant | is a single dedicated and trusted instance of Azure AD
Microsoft Entra subscription | is used to pay for Azure cloud services 
Domain |  logical group, AD requires DNS managing domain-joined hosts
Domain Controller  | Server that manages the DNS, Service Authorization, Storage and Cross Domain related interactions  
Domain computer | Domain joined host
AD Object |  Objects are Users, Groups, Machines, Files, Policies - at the most granular level
Group Policy Objects (GPO) | Virtual collection of Policy settings 
Organization Units (OU) | Objects that are collection of attributes that can be organized 
Directory Service | Runs on a DC providing methods for storing data and managing availability.

##### Important distinctions between Microsoft Entra ID  and AD Directory Service

Tenants represents an organisation in Microsoft Entra ID - distinct and separate from other Microsoft Entra ID  tenants.

Microsoft Entra ID  includes federation service

AD DS is primarily a directory service, while Microsoft Entra ID  is a full identity solution.

Microsoft Entra ID  is based on HTTP and HTTPS protocols with REST API
- Microsoft Entra ID  tenants can't be queried by using LDAP. Microsoft Entra ID  uses the REST API over HTTP and HTTPS.
 - it doesn't use Kerberos authentication.

Microsoft Entra ID  users and groups are created in a flat structure. There are no organisational units (OUs) or group policy objects (GPOs).

You manage only users, groups, and policies - unless you deploy AD DS.

#### Microsoft Entra ID  Domain Services 

Microsoft Entra ID Domain Services - some AD domain services are not available in the cloud.
Microsoft Entra ID  Directory Domain Services provides managed domain services such as:
- Domain Joins
- Group policies
- LDAP
- Kerberos

#### Microsoft Entra ID Connect

Microsoft Entra ID Connect is hybrid service to connect on-premise to Azure Account

Password hash synchronization - sync on-premise AD with Cloud AD
Pass-through authentication - sign-on with the same password for local and cloud AD
Federation integration - hybrid environment for local AD FS infrastructure - certificate renewal
Synchronisation - syncing data 
Health Monitoring - monitoring in Azure Portal

#### Microsoft Entra ID Join

Microsoft Entra ID enables single sign-on (SSO) to devices, applications, and services from anywhere. Securing is vital for compliance!
Microsoft Entra ID  join - for device joining:
Features:
- SSO, Enterprise State roaming, MS Store for business access, Windows Hello, Access restrictions, access to on-premise 
- Requires:
	- Connection
	- Register - register to manage
	- Join - extension of registering a device and changes the local state of the device to enable sign-in from organisational account instead of personal 
 - Potential combination of registration with other solutions

![](azureadbenefitsofazureadjoin.png)

[Implement Microsoft Entra ID join - Training | Microsoft Learn](https://learn.microsoft.com/en-us/training/modules/configure-azure-active-directory/6-implement-active-directory-join)

#### Microsoft Entra ID

Users 
- Identity for a person 
	- Users, Guest Users, Service Account
Groups 
- Owners and members; assignable and joinable!
Assigning Access rights 
- Direct, Group, Rule-based, External authority assignment
External Identities 
- allows external parties access your apps and resources with trust signin like:
	- Google and Facebook logins. Share, develop Microsoft Entra ID  apps for other tenants, developt white-label apps for consumers and customers Microsoft Entra ID  B2C. 
Tenant 
- Logical division of organization in Azure 
	- instance of AD in Azure
	- Business to business, Business to consumer


#### Microsoft Entra ID - SSPR feature

Microsoft Entra ID **self-service password reset** (SSPR) feature - no helpdesk (more secure and efficient). Deploy SSPR with password writeback by using [Microsoft Entra ID  Connect](https://learn.microsoft.com/en-us/azure/active-directory/authentication/tutorial-enable-sspr-writeback) or [cloud sync](https://learn.microsoft.com/en-us/azure/active-directory/authentication/tutorial-enable-cloud-sync-sspr-writeback).
- Requires:
	- Global Administrator privileges to manage SSPR options
	- valid license to use SSPR.
- SSPR Security group limit users with SSPR privileges

[This is how it works:](https://learn.microsoft.com/en-us/azure/active-directory/authentication/concept-sspr-howitworks)
When a users access the SSPR portal, the Azure platform considers the following factors:
- How should the page be localised?
- Is the user account valid?
- What organisation does the user belong to?
- Where is the user's password managed?

You can require a minimum number of authentication methods; methods Available
![](azuressprmethods.png)
For Administration account - strong MFA policy, no reuse, rotate - no security question to prevent weak answers and [[OSINT]]. Users only registered when they have the met the number required methods needed for SSPR.

Configure SSPR (self-service-password-reset)
`Microsoft Entra ID -> Passwords -> Properties - SSPR enabled (None/Selectec/All)`

#### Azure User and Group Accounts

Types of Account:
- Cloud identity - user account defined only in Azure AD
- Directory-synchronized identity - defined on premise sync-ed to Microsoft Entra ID with Microsoft Entra Connect
- Guest User - defined outside of Azure.

Typological Considerations: 
- Where account is defined
- Support for external contributors with Guest accounts 
- Combination of user accounts.
User Creation Considerations
- User profile data - set by Users
- restore option for deleted accounts
- gathered account data for analysis and improve infrastructure
- Bulk creation?
	- Naming Conventions!
	- Inital passwords - randomise and prompt for change (NO DEFAULTS)
	- Strategize to miminize error 
Group Considerations
- Access Rights
	- **Assigned** - specific users can have unique permissions
	- **Dynamic User** - automatically add and remove group member
	- **Dynamic device** - (security groups only) automatically add and remove devices in security groups.
Administrative Unit Considerations - admin role scoping
- Constrain Scope permissions boundaries to locale 
- Management tools
- Role Requirements in Azure Portal

Account restoration must occur 30 day from deletion 

- Access rights through signle user or group assignment
	- **Direct assignment**: Assign a user the required access rights by directly assigning a role that has those access rights.
	- **Group assignment**: Assign a group the required access rights, and members of the group will inherit those rights.
	- **Rule-based assignment**: Use rules to determine a group membership based on user or device properties.

For Temporary Guest users use: `Microsoft Entra ID  B2B` -  you don't take on the responsibility of managing and authenticating the credentials and identities of partners. Some organisations will use federations for on-premise resource authenication - avaliability is dependent of on-premise (security? - some of the big hacks of 2022 were malicious abuse of contractor access, beware) 


## Azure Portal Motions 

Manage Tenants
`Search Microsoft Entra ID  -> Manage tenants`
Create a Tenant
`All Services -> Microsoft Entra ID  -> Manage Tenants -> Create`
Configure Tenant
`Create a Tenant -> Configuration -> Name -> Review and Create -> Create`

License Management
`Search Microsoft Entra ID  -> Microsoft Entra ID  -> Licenses`
To assign a  license
`All Products -> Assign`

#### Create a Users, Groups and Manage Them  

Remember that you filter be tenant!

Microsoft Entra ID  
`Overview -> Users -> Create`

Creation User
`Search Users -> New Users -> New user`
Invite User - For Temporary Guest users use: `Microsoft Entra ID  B2B`
`Search Users -> New Users -> Invite`
Configure guest users:
- add to `Groups`
- Access to apps `Manage -> Enterprise applications -> Docusign` (or whatever Digital signing software) 

Edit User settings
`Search Microsoft Entra ID  -> Microsoft Entra ID  -> User Settings`
User Management
`Search Microsoft Entra ID  -> Microsoft Entra ID  -> Users`
Create/Invite
`Search Microsoft Entra ID  -> Microsoft Entra ID  -> Users -> New Users -> New user`
Assign Roles
``Search Microsoft Entra ID  -> Users -> Assigned Roles`
Enable Account
`Users -> $username -> Settings -> [Tick/Untick] Account enabled`
Guest user can be added with Creating and then Inviting
`Search Microsoft Entra ID  -> Microsoft Entra ID  -> Users -> New Users -> New user`
`Overview -> Users -> New User -> Invite External`
- remember to add to groups and anything else.

Bulk additions, deletion and invitation use a .cvs with SOME of the fields

Name | Username | Initial Password | Block Sign in | Firstname | Lastname 
--- | --- | --- | ---
John Doe | jdoe | password123! | No | John | Doe

Bulk Operations
`Search -> Users -> Bulk operations -> Create/invite/delete` 

Manage Groups
`Search Groups - > Groups -> New group/Download groups
Create Group
`Search Microsoft Entra ID  -> Groups -> New Group`
- `Membership type* -> Assign/Dynamic(User/Device)`
To make a dynamic group dynamic:
- `Add Dynamic Query Rule-> Select a Property, Operator and Value`
Deleted Groups
`Search Groups - > Groups -> Deleted groups`

#### Authentication and Authorisation

Enabling various types of MFA per user, bulk assignment is in the per-user MFA window 
`Users -> Per-user MFA`
Additional options - Where the important stuff is
`Per-Users MFA -> Server Settings` (Not obvious - displays as `users server settings`)
Remember to `enforce`! 

Password reset
`Overview -> Password Reset`
Properties - Self Service password resets
Authentication Methods
Registration - Require users to register when signing in
Notifications - Notification when and on resets
Customisation - Customise Helpdesk link
On-Premise Integration - As stated
Administrator Policy - Admin password reset policy.

## Azure CLI 

```powershell
# Create a new user
az ad user create
# Delete a user
az ad user delete
```

## Powershell

```powershell
# Create a new user
New-AzureADUser
# Remove a user
Remove-AzADUser 
```

Bulk user and member creation:
```powershell
$invitations = import-csv c:\bulkinvite\invitations.csv

$messageInfo = New-Object Microsoft.Open.MSGraph.Model.InvitedUserMessageInfo

$messageInfo.customizedMessageBody = "Hello. You are invited to the Contoso organization."

foreach ($email in $invitations)
   {New-AzureADMSInvitation `
      -InvitedUserEmailAddress $email.InvitedUserEmailAddress `
      -InvitedUserDisplayName $email.Name `
      -InviteRedirectUrl https://myapps.microsoft.com `
      -InvitedUserMessageInfo $messageInfo `
      -SendInvitationMessage $true
   }
```

## References

[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[Microsoft Entra ID pricing](https://azure.microsoft.com/pricing/details/active-directory) 
[Implement Microsoft Entra ID join - Training | Microsoft Learn](https://learn.microsoft.com/en-us/training/modules/configure-azure-active-directory/6-implement-active-directory-join)
[John Savill is always great](https://www.youtube.com/watch?v=JIjijcXoQt4)
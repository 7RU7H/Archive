# Azure AD Administration

[Azure Active Directory (Azure AD)](https://learn.microsoft.com/en-us/azure/active-directory/) is Microsoft's multi-tenant cloud-based directory and identity management service. AD and AD Cloud are just local and remote variants of AD, both are in use today and connectable with Hyrid Cloud. See [[Active-Directory-Defined]] for on-premise AD definitions and descriptions. It is the principle Identity and Access management service. Authorize and authenicate to multiple sources: 
- On-Premise AD, Internal resources and apps located on your corporate network
- Web-Application - IpD - google login 
- External resources like Microsoft 365, the Azure portal, and SaaS applications.
- Cloud apps developed for your organization.

Internal Resources | External  Resources
--- | --- 
Application within your internal network | Microsoft Office 365
Access to on-premises workstations | Azure Portal
... | SaaS Application

![](azureadexample.png)

#### Azure AD Editions

![](azureadeditions.png)

Teirs:
Azure Active Directory Free
Azure Active Directory Microsoft 365 Apps
Azure Active Directory Premium P1
Azure Active Directory Premium P2

See [Azure Active Directory pricing](https://azure.microsoft.com/pricing/details/active-directory)

#### Features

Microsoft espoused features
![1000](azureadfeatures.png)

Considerations:
- SSO for accessiblity for consistent UX experience to cloud or on-premise resources for users.
- Secure remote access - centralized authorization management, MFA2
- Advanced Data protection
- Cost reduction and self -service options


#### Terminology and Concepts

Azure AD concept | Description
--- | ---
Identity | is an object that can be authenticated 
Account | is an identity that has data associated with it 
Azure AD account | is an identity that's created through Azure AD or another Microsoft cloud service  
Azure Tenant | is a single dedicated and trusted instance of Azure AD
Azure subscription | is used to pay for Azure cloud services 
Domain |  logical group, AD requires DNS managing domain-joined hosts
Domain Controller  | Server that manages the DNS, Service Authorization, Storage and Cross Domain related interactions  
Domain computer | Domain joined host
AD Object |  Objects are Users, Groups, Machines, Files, Policies - at the most granular level
Group Policy Objects (GPO) | Virtual collection of Policy settings 
Organization Units (OU) | Objects that are collection of attributes that can be organized 
Directory Service | Runs on a DC providing methods for storing data and managing availability.

##### Important distinctions between Azure AD and AD Directory Service

Tenants represents an organization in Azure Active Directory - distinct and separate from other Azure AD tenants.

Azure AD includes federation service

AD DS is primarily a directory service, while Azure AD is a full identity solution.

Azure AD is based on HTTP and HTTPS protocols with REST API
- Azure AD tenants can't be queried by using LDAP. Azure AD uses the REST API over HTTP and HTTPS.
 - it doesn't use Kerberos authentication.

Azure AD users and groups are created in a flat structure. There are no organizational units (OUs) or group policy objects (GPOs).

You manage only users, groups, and policies - unless you deploy AD DS.

#### Azure AD Domain Services 

Azure AD  Domain Services - some AD domain services are not available in the cloud - 
Azure AD Directory Domain Services provides managed domain services such as:
- Domain Joins
- Group policies
- LDAP
- Kerberos

#### Azure AD Connect

Azure AD Connect is hybrid service to connect on-premise to Azure Account

Password hash synchronization - sync on-premise AD with Cloud AD
Pass-through authenication - sign-on with the same password for local and cloud AD
Federation integration - hybrid environment for local AD FS infrastucture - certificate renewal
Synchronization - syncing data 
Health Monitoring - monitoring in Azure Portal

#### Azure AD join

Azure Active Directory enables single sign-on (SSO) to devices, applications, and services from anywhere. Securing is vital for compliance!
Azure AD join - for device joining:
Features:
- SSO, Enterprise State roaming, MS Store for business access, Windows Hello, Access restrictions, access to on-premise 
- Requires:
	- Connection
	- Register - register to manage
	- Join - extension of registering a device and changes the local state of the device to enable sign-in from organizational account instead of personal 
 - Potential combination of registration with other solutions

![](azureadbenefitsofazureadjoin.png)

[Implement Azure Active Directory join - Training | Microsoft Learn](https://learn.microsoft.com/en-us/training/modules/configure-azure-active-directory/6-implement-active-directory-join)

#### Azure AD

Users 
- Identity for a person 
	- Users, Guest Users, Service Account
Groups 
- Owners and members; assignable and joinable!
Assigning Access rights 
- Direct, Group, Rule-based, External authority assignment
External Identities 
- allows external parties access your apps and resources with trust signin like:
	- Google and Facebook logins. Share, develop Azure AD apps for other tenants, developt white-label apps for consumers and customers Azure AD B2C. 
Tenant 
- Logical division of organization in Azure 
	- instance of AD in Azure
	- Business to business, Business to consumer



#### Azure AD SSPR feature

Azure Active Directory **self-service password reset** (SSPR) feature - no helpdesk (more secure and efficient). Deploy SSPR with password writeback by using [Azure AD Connect](https://learn.microsoft.com/en-us/azure/active-directory/authentication/tutorial-enable-sspr-writeback) or [cloud sync](https://learn.microsoft.com/en-us/azure/active-directory/authentication/tutorial-enable-cloud-sync-sspr-writeback).
- Requires:
	- Global Administrator privileges to manage SSPR options
	- valid license to use SSPR.
- SSPR Security group limit users with SSPR privileges


[It is works:](https://learn.microsoft.com/en-us/azure/active-directory/authentication/concept-sspr-howitworks)
When a users access the SSPR portal, the Azure platform considers the following factors:
- How should the page be localized?
- Is the user account valid?
- What organization does the user belong to?
- Where is the user's password managed?

You can require a minimum number of authenication methods; methods Avaliable
![](azuressprmethods.png)
For Administration account - strong MFA policy, no reuse, rotate - no security question to prevent weak answers and [[OSINT]]. Users only registered when they have the met the number required methods needed for SSPR.

Configure SSPR (self-service-password-reset)
`Azure Active Directory -> Passwords -> Properties - SSPR enabled (None/Selectec/All)`

#### Azure User and Group Accounts

Types of Account:
- Cloud identity - user account defined only in Azure AD
- Directory-synchronized identity - defined on premise sync-ed to Azure AD with Azure AD Connect
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

For Temporary Guest users use: `Azure AD B2B` -  you don't take on the responsibility of managing and authenticating the credentials and identities of partners. Some organisations will use federations for on-premise resource authenication - avaliability is dependent of on-premise (security? - some of the big hacks of 2022 were malicious abuse of contractor access, beware) 


## Azure Portal Motions 

Manage Tenants
`Search Azure AD -> Manage tenants`
Create a Tenant
`All Services -> Azure AD -> Manage Tenants -> Create`
Configure Tenant
`Create a Tenant -> Configuration -> Name -> Review and CReate -> Create`

License Management
`Search Azure AD -> Azure AD -> Licenses`
To assigna  license
`All Products -> Assign`

#### Create a Users, Groups and Manage Them  

Remember that you filter be tenant!

Azure AD 
`Overview -> Users -> Create`

Creation User
`Search Users -> New Users -> New user`
Invite User - For Temporary Guest users use: `Azure AD B2B`
`Search Users -> New Users -> Invite`
Configure guest users:
- add to `Groups`
- Access to apps `Manage -> Enterprise applications -> Docusign` (or whatever Digital signing software) 

Edit User settings
`Search Azure AD -> Azure AD -> User Settings`
User Management
`Search Azure AD -> Azure AD -> Users`
Create/Invite
`Search Azure AD -> Azure AD -> Users -> New Users -> New user`
Assign Roles
``Search Azure AD -> Users -> Assigned Roles`
Enable Account
`Users -> $username -> Settings -> [Tick/Untick] Account enabled`
Guest user can be added with Creating and then Inviting
`Search Azure AD -> Azure AD -> Users -> New Users -> New user`
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
`Search Azure AD -> Groups -> New Group`
- `Membership type* -> Assign/Dynamic(User/Device)`
To make a dynamic group dynamic:
- `Add Dynamic Query Rule-> Select a Property, Operator and Value`
Deleted Groups
`Search Groups - > Groups -> Deleted groups`

#### Authenication and Authorization

Enabling various types of MFA per user, bulk assignment is in the per-user MFA window 
`Users -> Per-user MFA`
Additional options - Where the important stuff is
`Per-Users MFA -> Server Settings` (Not obvious - displays as `users server settings`)
Remember to `enforce`! 

Password reset
`Overview -> Password Reset`
Properties - Self Service password resets
Authenication Methods
Registation - Require users to register when signing in
Notifiications - Notification when and on resets
Customization - Customize Helpdesk link
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
wEPDwUKMTI3ODM5MzQ0Mg9kFgICAw8WAh4HZW5jdHlwZQUTbXVsdGlwYXJ0L2Zvcm0tZGF0YWRkWOy0CDxpPqG7BtAdOq8rOXuncl8=```

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
[Azure Active Directory pricing](https://azure.microsoft.com/pricing/details/active-directory) 
[Implement Azure Active Directory join - Training | Microsoft Learn](https://learn.microsoft.com/en-us/training/modules/configure-azure-active-directory/6-implement-active-directory-join)
# Azure AD Administration

AD and AD Cloud are just local and remote variants of AD, both are in use today and connectable with Hyrid Cloud. See [[Active-Directory-Defined]] for on-premise AD definitions and descriptions.

Identity and Access management service

Authorize and authenicate to multiple sources: 
- On-Premise AD -
- Web-Application - IpD - google login 
- Office 365  or Azure Microsoft

Internal Resources | External  Resources
--- | --- 
Application within your internal network | Microsoft Office 365
Access to on-premises workstations | Azure Portal
... | SaaS Application

Azure AD Editions:
1. Free -  MFA, Single Sign On, basic Security and Usage Reports, User Management
2. Office 365 Apps -  Company Branding, SLA, Two-Sync between On-Premise and Cloud
3. Premium 1 -  Hybrid Architecture Advanced Group Access, Conditional Access
4. Premium 2 - Identity protection and governace

Domain - logical group, AD requires DNS managing domain-joined hosts
Domain Controller - Server that manages the DNS, Service Authorization, Storage and Cross Domain related interactions  
Domain computer - Domain joined host
AD Object - Objects are Users, Groups, Machines, Files, Policies - at the most granular level
Group Policy Objects (GPO) -  Virtual collection of Policy settings 
Organization Units (OU) - Objects that are collection of attributes that can be organized 
Directory Service - Runs on a DC providing methods for storing data and managing availability.

Tenants represents an organiization in Azure Active Directory - distinct and separate from other Azure AD tenants.

Azure AD Directory Domain Services - some AD domain services are not available in the cloud - 
Azure AD Directory Domain Services provides managed domain services such as:
- Domain Joins
- Group policies
- LDAP
- Kerberos

Azure AD Connect is hybrid service to connect on-premise to Azure Account

Password hash synchronization - sync local AD with Cloud AD
Pass-through authenication - sign-on with the same password for local and cloud AD
Federation integration - hybrid environment for local AD FS infrastucture - certificate renewal
Synchronization - syncing data 
Health Monitoring - monitoring in Azure Portal

Azure AD

Users - Identity for a person - Users, Guest Users, Service Account
Groups - Owners and members; assignable and joinable!
Assigning Access rights - Direct, Group, Rule-based, External authority assignment
External Identities - allows external parties access your apps and resources with trust signin like - Google and Facebook logins. Share, develop Azure AD apps for other tenants, developt white-label apps for consumers and customers Azure AD B2C. 
Tenant - Logical division of organization in Azure - instance of AD in Azure - Business to business, Business to consumer

#### Create a Tenant

Create
`All Services -> Azure AD -> Manage Tenants -> Create`
Configure Tenant
`Create a Tenant -> Configuration -> Name -> Review and CReate -> Create`

#### Create a User 

Azure AD 
`Overview -> Users -> Create`

Guest user can be added with:
`Overview -> Users -> New User -> Invite External`

Bulk additions, deletion and invitation use a .cvs with SOME of the fields
Name | Username | Initial Password | Block Sign in | Firstname | Lastname 
--- | --- | --- | ---
John Doe | jdoe | password123! | No | John | Doe

`Bulk Operations -> Create/invite/delete` 

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
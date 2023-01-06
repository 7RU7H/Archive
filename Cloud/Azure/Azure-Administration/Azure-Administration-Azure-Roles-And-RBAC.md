# Azure Administration - Azure Roles and RBAC

#### Azure AD Roles

Azure AD roles are used to manage Azure AD resources in a directory such as:
- create units
- edit units
- assign adminstrative roles to others
- reset user passwords
- manage user licenses
- manage domains
Built-In Azure AD Roles:
- Global Administrator - Full access to everything
- User Administrator - Full access to creat and manage users
- Billing Administrator - Make purchases, maneg subscriptions and support tickets

Regarding [[Azure-Administration-AD-Administration]], do not use Classic subcription Roles use either RBAC or [Azure AD Administrator roles](https://learn.microsoft.com/en-us/azure/active-directory/roles/permissions-reference):
![1000](azurerolerbacandadminroles.png)
Azure AD Roles are used to manage resources in Azure AD
Azure RBAC role provide more granular access management for Azure resources.

#### Differentiation 

Azure Policies vs. Azure Roles (RBAC)
Azure Polices | Azure Roles
--- | ---
Ensure compliance of resources | Control access to resources
Does not restrict actions | Manages User actions at different scopes - does restict on Azure Resources

Azure AD Roles vs. Azure Roles (RBAC)
Azure AD Roles | Azure Roles
--- | ---
Controls access of AD resources | Control access to Azure resources

- By default, Azure Roles and Azure AD do not span Azure and Azure AD
- By default, the Global Administrator does not have access to Azure resources
- Global Administrator must be grant access to Azure resource if granted the User Access Administrator role

#### RBAC

Role-based access control (RBAC) is a mechanism that can help you manage who can access your Azure resources. RBAC lets you determine what operations specific users can do on specific resources, and control what areas of a resource each user can access.

Fundamental Roles of Azure RBAC
![](azurefundamentalrbacroles.png)

RBAC core concepts:
![1000](azurerbaccoreconcepts.png)

Considerations:
- job role vs resposibitilies, work scenarios - taskes - and miminum requriement necessary 
- Scope of permissions
- Builtin is better most of the time than custom - custom creates security overhead!
- Assignments are also Deny not just allow - a deny assignment attaches a set of deny actions to a user, group, or service principal at a particular scope for the purpose of denying access.

#### Role Creation

Beware - [Azure role definitions](https://learn.microsoft.com/en-us/azure/role-based-access-control/role-definitions) - Property names will change whether its: 
- Azure Powershell 
```powershell
Name
Id
IsCustom
Description
Actions []
NotActions []
DataActions []
NotDataActions []
AssignableScopes []
```
or Azure CLI
```csharp
roleName
name
type
description
actions []
notActions []
dataActions []
notDataActions []
assignableScopes []
```
Note use of `/*/`  are wildcards!

List of [built-in role definitions](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles) -  [custom roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/custom-roles)

[Assign Azure roles using Azure PowerShell](https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-powershell)

Considerations:
- Use [built-in role definitions](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles) or [custom roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/custom-roles)
- Limit access scope
- Controlling data modification - apply tight access control for only specific scenarios  
- Applying deny assignments -  a deny assignment attaches a set of deny actions to a user, group, or service principal at a particular scope for the purpose of denying access.

 A custom role definition includes the allowed operations, such as read, write, and delete for Azure resources. The custom role definition also includes the scope of these permissions.

## Role Assignment

Role assignment is for scope access control, which is revokable and inheritable with intent to assign suitable role to requestor. 
-  Security principals supported: user, group, service principal.
- Six built-in roles are implemented, and two custom roles are defined: `Reader Support Tickets` and `Virtual Machine Operator`.
	- Builtin `Contributor` has permissions:
		- `Actions`
		- `NotActions`

## Workflows

Implement management groups 
`Search Management groups -> Management groups`
Setup Azure AD permissions for Implementing Management Groups
`Search Azure ->  Azure Active Directory -> Properties -> Access management for Azure Resources` - Refresh in `Management Groups`
From `Management Groups` - Requires Management group ID and Display name
Create a `Management Group`
`Search Management groups -> Management groups -> <insert Management group ID and Display name> 
Add a management group to a subscription
`Search Management groups -> Management groups -> $Management_group -> Subscriptions`  - Subscription ID is in `Overview`

Custom RBAC role creation:
`Upload a $customRole.json file`  - replace fields reqiure prior to upload!
`Open CloudCLI` to upload
```powershell
New-AzRoleDefinition -InputFile $file
```
Assign roles
`Management Groups -> Access Control (IAM) -> Add -> Search <role keyword> ->  + Select members`


## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[Azure role definitions](https://learn.microsoft.com/en-us/azure/role-based-access-control/role-definitions)
[Assign Azure roles using Azure PowerShell](https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-powershell)
[Built-in role definitions](https://learn.microsoft.com/en-us/azure/role-based-access-control/built-in-roles)
[Custom roles](https://learn.microsoft.com/en-us/azure/role-based-access-control/custom-roles)
[Azure AD Administrator roles](https://learn.microsoft.com/en-us/azure/active-directory/roles/permissions-reference):
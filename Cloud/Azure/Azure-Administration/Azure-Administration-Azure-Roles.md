# Azure Administration - Azure Roles

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

#### Azure Policies vs. Azure Roles (RBAC)

Azure Polices | Azure Roles
--- | ---
Ensure compliance of resources | Control access to resources
Does not restrict actions | Manages User actions at different scopes - does restict on Azure Resources

#### Azure AD Roles vs. Azure Roles (RBAC)

Azure AD Roles | Azure Roles
--- | ---
Controls access of AD resources | Control access to Azure resources

- By default, Azure Roles and Azure AD do not span Azure and Azure AD
- By default, the Global Administrator does not have access to Azure resources
- Global Administrator must be grant access to Azure resource if granted the User Access Administrator role

[Assign Azure roles using Azure PowerShell](https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-powershell)

## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[Azure role definitions](https://learn.microsoft.com/en-us/azure/role-based-access-control/role-definitions)
[Assign Azure roles using Azure PowerShell](https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-powershell)

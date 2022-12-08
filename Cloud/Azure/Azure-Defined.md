# Azure Defined 

Shared responsibility - Microsoft and Tenet

On premises we would responsible for every layer where with the Cloud as Inferstructure as a Service.
Azure is responsible for:
- Hypervisor
- Network
- Storage
- Compute
Customer is then responsible for - VM and VM Scale Sets
- Runtime
- App
- Data
- OS

Platform as a Service
- Azure is resposible for everything except the App and the Data
	- Azure Container, Kuberneties, Logical Apps, Functions
Software as a Service - Office 365 - Provides the business function. 


[Interactive map Resource Map](https://infrastructuremap.microsoft.com/explore) - Use 2D for fast load times

#### Regions

Regions are groups of close groups of physical locations. This used and segmented part of the globe due to:
- Meet data soveignty requirements
- Disaster Recovery
- Region cover to customer base
- Commercial Regions

Pairing is Geopolitical borders, except Brazil South see: [Azure Cross Replication Regions](https://learn.microsoft.com/en-us/azure/reliability/cross-region-replication-azure). Pairings stager updates, if there is problem it does affect other zones.Exposed as availability zones that contain bulding with power cooling and network, services can be distributed over multiple building.
- Three availability zones map to one subscription - AZ1, AZ2, AZ3 
- No consistency between region
- Some Zone redundant it spans all the zones
- Zonal is specific availability zone. 

VM cannot span zones, Zonal VMs that can provide the same service

#### Authenication and Authorization

Azure Active Directory is a Cloud identity provider [[Active-Directory-Defined]],  the Authentication protocols used in Azure include:
- Open ID connect
- SAML
- WS-Fed
- OAUTH2

We want Multi-Factor Authenication as it currently most secure. Whereas for Authorization we use Role Base Access Control (RBAC) with Conditional Access. RBAC is based on Conditional Access from Azure AD and add requirements of authenication. Role Based Access Control:
- A Role is a set of actions - Owner, Contributor, Reader; some are subsets of actions
- Roles are given to an Identity - user and group at particular scopes.

A condition can be imposed base on the role of the object  interacting with it. Resources can be granted from Azure Conditional Access. Azure will trust Azure AD Tenet as well as cloud application. Companies generally have there own AD with users, groups and we use Azure AD connect to synchronize, it the Cloud Equivilent to DC-Syncing.

#### Governance and Management Groups

Azure is self service instead request to on premises IT operations. Inheritance of a Governace type can be a applied to AAD at level required for securing and accessiability of resources as set of management groups. 

Role Assignment

- Policy about guardrails, controls and audit Asset actuation - for location and how asset can perform an action.
- Audit mode can track for compliance, correct issues if deploy incorrectly
- Initiatives can apply bulk policies like NIST SP 800  

Budget - Costing 

## Subscriptions


A subscription is base unit of Azure interaction and an agreement between Microsoft and customer. [Azure subscription limits and quotas - Azure Resource Manager | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits)
Different subscription can be used for structural reasons. RBAC, Policy and Budget can be applied to eac.


#### Azure Resource Manager

Management suite for Azure.

- Resources are created in a resource group in subscription, but can not be nested, have inheritance
- Resource groups are not a connective boundary.
- Resource groups have a comon lifecycle.

Made of resource that defined in resource providers.
```powershell
Get-AzResourceProvider -ProviderNamespace MICROSOFT.COMPUTE | ft resourcetypes
```


Portal is visual good, but CloudShell is Powershell and Bash are included in the Portal.

ARM JSON Templating for provisioning - creation. A declarative set for configuration and properties can set within section of a template. Bulk creation of VM could defined in a template to make nth number of machines if declared in this template. It can used very generally across concept domains, AD to Git Respo

Transpiles from human readable [Bicep file](https://github.com/Azure/bicep), *Bicep is a Domain Specific Language (DSL) for deploying Azure resources declaratively. It aims to drastically simplify the authoring experience with a cleaner syntax, improved type safety, and better support for modularity and code re-use.*


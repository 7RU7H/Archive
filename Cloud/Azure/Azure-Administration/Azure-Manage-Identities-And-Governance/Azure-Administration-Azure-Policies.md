# Azure Policies

[Azure Policy](https://azure.microsoft.com/services/azure-policy/) is a service in Azure that enables you to create, assign, and manage policies to control or audit your resources. Organisations that use multiple subscriptions need a way to efficiently manage access, policies, and compliance. [Azure management groups](https://learn.microsoft.com/en-us/azure/governance/management-groups/overview) provide a level of scope and control above your subscriptions. Azure Policies enforce organisational standards and assess compliance at-scale Policies - do not restrict access they only observe for compliance. 

Governance is about enforcement of rules and ensuring proper functioning to standards. 
- Policies  - WHAT 
- RBAC - WHO - [[Azure-Administration-Azure-Roles-And-RBAC]]
- Budget - HOW MUCH

Azure Polices | Azure Roles
--- | ---
Ensure compliance of resources | Control access to resources
Does not restrict actions | Manages User actions at different scopes - does restict on Azure Resources


|Advantage|Description|
|---|---|
|**Enforce rules and compliance**|Enable built-in policies, or build custom policies for all resource types. Support real-time policy evaluation and enforcement, and periodic or on-demand compliance evaluation.|
|**Apply policies at scale**|Apply policies to a management group with control across your entire organization. Apply multiple policies and aggregate policy states with policy initiative. Define an exclusion scope.|
|**Perform remediation**|Conduct real-time remediation, and remediation on your existing resources.|
|**Exercise governance**|Implement governance tasks for your environment:  <br>- Support multiple engineering teams (deploying to and operating in the environment)  <br>- Manage multiple subscriptions  <br>- Standardize and enforce how cloud resources are configured  <br>- Manage regulatory compliance, cost control, security, and design consiste|

- Policy Definitions - Defined in a .[[JSON]] to describe business rules to control access to resources
- Policy Assignment - Scope of a policy can effect
- Policy Parameters - Values passed into Policy definition so Polices are more flexible for re-use
- Initiative Definitions - A collection of Policy definitions, assignable to enforce compliance 

`Overview -> Policies - Compliance` To view compliance across a scope.


Management Groups:
- Maximum 6 level depth
- All subscriptions within a management group **automatically inherit** the conditions applied to that management group
- Azure role-based access control authorisation for management group operations **isn't enabled by default!** 
	- Probably best to keep it that way, if required then less is more powerful - no nesting, security through dependent-collaborative authentication, principle of least privilege, etc..
	
Considerations:
- Custom hierarchies and groups
- Policy inheritance - easier to manage unique(s) or security sensitive without overextending permissions
- Compliance rules - help organisation meet compliance level easier
- Cost reporting by tag, across subscription, etc!
- Deploy-able resources type deployment potentials
- Location restrictions for users for security
- Enforcement of compliance rules to manage resources and user options
- Inventory audits on your VMs with [[Azure-Administration-Azure-Backups]] and Azure Policies

## Create a Policy

1. Create policy definitions 
	- A policy definition expresses a condition to evaluate and the actions to perform when the condition is met
	- Builtin or custom
3. Create an initiative definition
	- An initiative definition is a set of policy definitions that help you track your resource compliance state to meet a larger goal
4. Scope the initiative definition
5. Determine compliance
#### Azure Definition File

[Azure Definition File](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure) *"Azure Policy establishes conventions for resources. Policy definitions describe resource compliance [conditions](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#conditions) and the effect to take if a condition is met. A condition compares a resource property [field](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#fields) or a [value](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#value) to a required value. Resource property fields are accessed by using [aliases](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#aliases). When a resource property field is an array, a special [array alias](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#understanding-the--alias) can be used to select values from all array members and apply a condition to each one."*

For a [list of built-in definitions](https://learn.microsoft.com/en-us/azure/governance/policy/samples/built-in-policies)

You use [[JSON]] to create a policy definition. The policy definition contains elements for:

- Display name
- Description
- Mode
- Metadata
- Parameters
- Policy rule
    - Logical evaluation
    - Effect

Policy Rules consist of an `if` and `then` blocks to specify when policy is enforced to precisely define scenario(s) for a policy. Policy Rule has a Policy Effect: 
- Deny
- Audit
- Append
- Audit if not exists
- Deploy if not exists
- Disabled

Policy Creation:
1. Policy Definitions - [list of built-in definitions](https://learn.microsoft.com/en-us/azure/governance/policy/samples/built-in-policies)
2. Initiative definition - [Azure Policy initiative definition structure](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/initiative-definition-structure) and  [list of built-in initiatives](https://learn.microsoft.com/en-us/azure/governance/policy/samples/built-in-initiatives)
3. Scope the initiative definition 
4. Determine Compliance

Policy definitions can also be imported into Azure Policy from [GitHub](https://github.com/Azure/azure-policy/tree/master/samples)
Initiative Definitions are good at ANY scale of organisation, do not skip.

Policy Assignment takes 10-30 minutes - Blueprints are useful

Polices Management:
`Policies -> Compliance` - Assign polices, initiatives
`Policies -> Remediation` - Policies to remediate and Remediation tasks
Policies Authoring:
`Policies -> Definitions` - Policies and Initiative definitions - export definitions
`Policies -> Assignments` - Assign Policies and Initiatives
`Policies -> Examptions` - Scope, Category - To create a new exemption - go to `assignment` or the `compliance`.

Apply a policy by tag
`Policies -> Definitions -> Category -> Tags -> Require a tag.. -> Assign -> Scop -> subscription and resource group`

Assignment of a policy - and various assignment configuration and management:
`Policies -> Assignments -> Assignment Name's ellipsis -> Right click` - This menu will show: Edit, delete, duplicate assignment; view definition and compliance; create exemptions.

Inheritance is made in the: 
`Policies -> Assignments -> Assign`


## Examples And Consideration

![1080](azureexamplepolicygroup.png)

Management group are hierarchy to organize and apply policy over resources. Governance is applied top-down and is inhierited.

1. Subscriptions and Azure AD Tenant
	- Subscription Owners can move Subscription to different Azure AD Tenant, but lose previous RBAC
	- Azure AD tenant create trust to domain-joined to then gain access to their tiering RBAC.
3. Management Groups and Subscriptions - Context
	- Root Management Group is created first
		- Unmovable and Undeletable.
		- 6 Level Deep maximum
4. Resource Group - Everything exists in resource group, no nesting allowed, not a boundary of access

Locks are implemented at the control plain only. For example locks the storage account attributes, but blobs can be delete within the storage account  

Roles are limited to 4000, RBAC at the attribute level can help.

Initatives - Policies implemented over a Scope 


## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[Azure Definition File](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure) 
[Azure management groups](https://learn.microsoft.com/en-us/azure/governance/management-groups/overview) 
[list of built-in definitions](https://learn.microsoft.com/en-us/azure/governance/policy/samples/built-in-policies)
[Azure Policy initiative definition structure](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/initiative-definition-structure)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
[John Savill Azure Master Class v2 - Governance](https://www.youtube.com/watch?v=eLSjnF6Crlw&list=PLlVtbbG169nGccbp8VSpAozu3w9xSQJoY&index=4)
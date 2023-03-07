# Azure Policies

Organizations that use multiple subscriptions need a way to efficiently manage access, policies, and compliance. [Azure management groups](https://learn.microsoft.com/en-us/azure/governance/management-groups/overview) provide a level of scope and control above your subscriptions. Azure Policies enforce organizational standards and assess compliance at-scale Policies - do not restrict access they only observe for compliance. 

Azure Polices | Azure Roles
--- | ---
Ensure compliance of resources | Control access to resources
Does not restrict actions | Manages User actions at different scopes - does restict on Azure Resources

- Policy Definitions - Defined in a .json to describe business rules to control access to resources
- Policy Assignment - Scope of a policy can effect
- Policy Parameters - Values passed into Polcy definition so Polices are more flexiable for re-use
- Initiative Definitions - A collection of policy definitions, assignable to enforce compliance 

`Overview -> Policies - Compliance` To view compliance across a scope.

Considerations:
- Custom heirarchies and groups
- policy inheritance - easier to manage uniques or security sensitive without overextending permissions
- Compliance rules - help organization meet compliance level easier
- Cost reporting by tag, across subscription, etc!
- Deployable resources type deployment potentials
- Location restrictions for users for security
- Enforcement of compliance rules to manage resources and user options
- Inventory audits on your VMs with [[Azure-Administration-Azure-Backups]] and Azure Policies


#### Azure Definition File

[Azure Definition File](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure) *"Azure Policy establishes conventions for resources. Policy definitions describe resource compliance [conditions](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#conditions) and the effect to take if a condition is met. A condition compares a resource property [field](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#fields) or a [value](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#value) to a required value. Resource property fields are accessed by using [aliases](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#aliases). When a resource property field is an array, a special [array alias](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#understanding-the--alias) can be used to select values from all array members and apply a condition to each one."*

You use JSON to create a policy definition. The policy definition contains elements for:

- display name
- description
- mode
- metadata
- parameters
- policy rule
    - logical evaluation
    - effect

Policy Rules consist of an `if` and `then` blocks to specify when policy is enforced to precisely define scenario(s) for a policy. Policy Rule has a Policy Effect: 
- Deny
- Audit
- Append
- Audit if not exists
- Deploy if not exists
- Disabled

Policy Creation:
1. Policy Defintions - [list of built-in definitions](https://learn.microsoft.com/en-us/azure/governance/policy/samples/built-in-policies)
2. Initiative definition - [Azure Policy initiative definition structure](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/initiative-definition-structure) and  [list of built-in initiatives](https://learn.microsoft.com/en-us/azure/governance/policy/samples/built-in-initiatives)
3. Scope the initiative definition 
4. Detirmine Compliance

Policy definitions can also be imported into Azure Policy from [GitHub](https://github.com/Azure/azure-policy/tree/master/samples)
Initiative Definitions are good at ANY scale of organization, do not skip.

Policy Assignment takes 10-30 minutes - Blueprints are useful

Polices Management:
`Policies -> Compliance` - Assign polices, initatives
`Policies -> Remediation` - Policies to remediate and Remediation tasks
Policies Authoring:
`Policies -> Definitions` - Policies and Initiative definitions - export definitions
`Policies -> Assignments` - Assign Policies and Initiatives
`Policies -> Examptions` - Scope, Category - To create a new exemption - go to `assignment` or the `compliance`.

Apply a policy by tag
`Policies -> Definitions -> Category -> Tags -> Require a tag.. -> Assign -> Scop -> subscription and resource group`

Assignment of a policy - and various assignment configuration and management:
`Policies -> Assignments -> Assignment Name's ellipsis -> Right click` - This menu will show: Edit, delete, duplicate assignment; view definition and compliance; create excemptions.

Inheritance is made in the: 
`Policies -> Assignments -> Assign`


## Examples

![1080](azureexamplepolicygroup.png)




## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[Azure Definition File](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure) 
[Azure management groups](https://learn.microsoft.com/en-us/azure/governance/management-groups/overview) 
[list of built-in definitions](https://learn.microsoft.com/en-us/azure/governance/policy/samples/built-in-policies)
[Azure Policy initiative definition structure](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/initiative-definition-structure)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
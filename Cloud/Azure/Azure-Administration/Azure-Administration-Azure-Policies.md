# Azure Policies

Azure Policy enforce organizational standards and assess compliance at-scale Policies - do not restrict access they only observe for compliance

- Policy Definitions - Defined in a .json to describe business ruls to control access to resources
- Policy Assignment - Scope of a policy can effect
- Policy Parameters - Values passed into Polcy definition so POlices are mote flexiable for re-use
- Initiative Definitions - A collection of policy definitions, assignable to enforce compliance 

`Overview -> Policies - Compliance` To view compliance across a scope.

#### Azure Definition File

[Azure Definition File](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure) *"Azure Policy establishes conventions for resources. Policy definitions describe resource compliance [conditions](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#conditions) and the effect to take if a condition is met. A condition compares a resource property [field](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#fields) or a [value](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#value) to a required value. Resource property fields are accessed by using [aliases](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#aliases). When a resource property field is an array, a special [array alias](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#understanding-the--alias) can be used to select values from all array members and apply a condition to each one."*

You use JSON to create a policy definition. The policy definition contains elements for:

-   display name
-   description
-   mode
-   metadata
-   parameters
-   policy rule
    -   logical evaluation
    -   effect

Policy Rules consist of an `if` and `then` blocks to specify when policy is enforced to precisely define scenario(s) for a policy. Policy Rule has a Policy Effect: 
- Deny
- Audit
- Append
- Audit if not exists
- Deploy if not exists
- Disabled

Policy Assignment takes 10-30 minutes - Blueprints are useful

Polices Management:
`Policies -> Compliance` - Assign polices, initatives
`Policies -> Remediation` - Policies to remediate and Remediation tasks
Policies Authoring:
`Policies -> Definitions` - Policies and Initiative definitions - export definitions
`Policies -> Assignments` - Assign Policies and Initiatives
`Policies -> Examptions` - Scope, Category - To create a new exemption - go to `assignment` or the `compliance`.


## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[Azure Definition File](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure) 
# Azure-Administration Cloud Governance

The term _governance_ describes the general process of establishing rules and policies and ensuring that those rules and policies are enforced. Strategy in terms of governance over an organisation cloud resources is maintaining control over your environment to ensure remain compliant with:
- Industry standards
- Corporate or organisational standards
- Regulatory requirements 

- [[Azure-Administration-Azure-Roles-And-RBAC]] 
- RBAC is scoped at:
	- A management group (a collection of multiple subscriptions).
	- A single subscription.
	- A resource group.
	- A single resource.
- When you grant access at a parent scope, those permissions are inherited by all child scopes. 
- `Allow model`

Resource Locks:
- **CanNotDelete** means authorised people can still read and modify a resource, but they can't delete the resource without first removing the lock.
- **ReadOnly** means authorised people can read a resource, but they can't delete or change the resource. Applying this lock is like restricting all authorised users to the permissions granted by the **Reader** role in Azure RBAC.

Tags are very important the metadata from tags is used:
- **Resource management** Tags enable you to locate and act on resources that are associated with specific workloads, environments, business units, and owners.
- **Cost management and optimisation** Tags enable you to group resources so that you can report on costs, allocate internal cost centres, track budgets, and forecast estimated cost.
- **Operations management** Tags enable you to group resources according to how critical their availability is to your business. This grouping helps you formulate service-level agreements (SLAs). An SLA is an uptime or performance guarantee between you and your users.
- **Security** Tags enable you to classify data by its security level, such as _public_ or _confidential_.
- **Governance and regulatory compliance** Tags enable you to identify resources that align with governance or regulatory compliance requirements, such as ISO 27001. Tags can also be part of your standards enforcement efforts. For example, you might require that all resources be tagged with an owner or department name.
- **Workload optimisation and automation** Tags can help you visualise all of the resources that participate in complex deployments. For example, you might tag a resource with its associated workload or application name and use software such as Azure DevOps to perform automated tasks on those resources.

[Azure Policy](https://azure.microsoft.com/services/azure-policy) is a service in Azure that enables you to create, assign, and manage policies that control or audit your resources. [[Azure-Administration-Azure-Policies]] - Tasks involved:
1. Create a policy definition.
2. Assign the definition to resources.
3. Review the evaluation results.
Do not confuse definitions with *Azure Policy initiatives* as they are a way of grouping related policies together.

Azure Blueprints orchestrates the deployment of various resource templates and other artefacts, such as:
- Role assignments
- Policy assignments
- Azure Resource Manager templates
- Resource groups

To Implement:
1. Create an Azure blueprint.
2. Assign the blueprint.
3. Track the blueprint assignments.

## Workflows

Manage access permissions on the **Access control (IAM)** pane
`Azure portal -> Search IAM`

Resource Locking 
`Search -> Resourtce Group -> Locks`

Always add tags, TAGS, TAGS!..
## References

[Microsoft Learn](https://learn.microsoft.com/en-us/training/modules/build-cloud-governance-strategy-azure/1-introduction)
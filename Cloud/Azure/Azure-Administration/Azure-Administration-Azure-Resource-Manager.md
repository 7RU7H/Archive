#  Azure Administration - Azure Resource Manager

Azure Resouce Manager is a collection of services not searchable, it allows a you manage Azure Resources. 
- CRUD Resources
- Apply management features
- Writing Infrastructure as Code (IaC) via JSON temlpates.

Features that encompasses the ARM layer
- Subscriptions
- Management Groups
- Resource Groups
- Resource Providers
- Resource Locks
- Azure Products
- Resource Tags
- Access Control IAM
- Role-Based Access Controls (RBAC)
- Azure Policies
- ARM Templates

Azure Resource Manager is a like gate keeper with Authenication (AD) as all requests flow through ARM. Requestes on the left and Resources on the right 
![](wherearmisinazure.png)

Scoping:
- Management Groups
	- Logical grouping of multiple subscriptions
		- Subscriptions
			- Resource Group with a subscription
				- An Azure Resource


#### Subscriptions 

Subscriptions are required in Azure, you can have multiple;. Multiple subscriptions can be managed hierarchally structured tiering of subscriptions with single top-level "Root" management group, for example:

- Root Management Group
	- HR 
		- Dev/Test subscription
		- Apps
	- IT
		- Production
			- Geo Region 1
				- EA Subscription
				- EA Subscription
			- Geo Region 2
				- EA Subscription
		- Security
			- EA Subscription
	- RND
		- Free Trial Subscription
	- ACC
		- EA Subscription

Access controls can applied at granular level while being very organized.

`Licences -> Assign` configure to assign a licence to user.  


#### Resource Groups

Resource Groups are containers that hold related resources (a group of Virtual Machines) for an Azure solution from a Resource Provider - Microsoft.Compute 

#### Resource Provider

Resource Provider need to be registered, but by default a subscriptions has access many registered resource providers other need to be registered.

#### Resource Tags

Someitimes just known a Tags, it is key value pair assigned to a Azure Resource; for exmaple:
By:
- Department 
- Status
- Team
- Environement
- Project
- Location

Tags allow you to organize resources:
- Operations management - Businesss commitments and SLA operations
- Security classification of data and security 
- Perform granular cost tacking, budgets and alerts
- Resource Management
- Governace and regulatory compliance
- Automation
- Workload optimization

#### Resource Locks

Locking prevents CRUD-ing of resources by other users from accidental or malicious actions:
- CanNotDelete
- ReadOnly

#### Azure Blueprint

Blueprints are a declarative method to orchestrate the delpoyment of various resource template and other artifacts- enable quick creation of govern subcriptions. Nearly everything you want to include for deployments in Azure Blueprints can be accomplished with ARM Templates - [[Azure-Administration-ARM-Templates]] 
- Role Assignments
- Policy Assignments
- Azure Resource Manager templates 
- resource Groups

The Azure Blueprints service is backed by the globally distributed Azure Cosmos DB, Blueprint object are replicated to multiple Azure regions. Azure Blueprints support improved tracking and auditing of deployments.

ARM Template vs. Azure Blueprint

ARM Templates:
- are stored locally or in source control 
- No active connection or relationship to the ARM template

Azure Blueprints
- relationship between the blueprint definition (what should be deployed) and the blueprint assignment (what was deployed)
- Upgrade serval subscription at once that are governed by the same blueprint

#### Administrative Motions and Workflow

###### Create a Disk

`Search: Disk -> Create- > Basics -> Encryption -> Networking -> Advanced -> Tags -> Review + create` Considerations:
- SKUs
- Size, IOPs and cost
- Tags

Wait for deployment, `Go to resource` 

##### Create a Resource Group

`Resource Groups -> Create` - Add tags for QoL 

###### Administrating a Resource Group

`Resource Groups -> $ResourceGroup -> Settings` 
- Deployments - Redeploy, delete
- Security - Microsoft Defender for the Cloud
- Policies - Assign Policies Initiatives
- Properties - Copy and paste Properties
- Locks - Apply locks on resources

#### Moving Resources

Moving Resources - there are end cases - [see Documentation for more]([Move resources to a new subscription or resource group - Azure Resource Manager | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-resource-group-and-subscription)):
-   If you're using Azure Stack Hub, you can't move resources between groups.
-   [App Services move guidance](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-limitations/app-service-move-limitations)
-   [Azure DevOps Services move guidance](https://learn.microsoft.com/en-us/azure/devops/organizations/billing/change-azure-subscription?toc=/azure/azure-resource-manager/toc.json)
-   [Classic deployment model move guidance](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-limitations/classic-model-move-limitations) - Classic Compute, Classic Storage, Classic Virtual Networks, and Cloud Services
-   [Networking move guidance](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-limitations/networking-move-limitations)
-   [Recovery Services move guidance](https://learn.microsoft.com/en-us/azure/backup/backup-azure-move-recovery-services-vault?toc=/azure/azure-resource-manager/toc.json)
-   [Virtual Machines move guidance](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-limitations/virtual-machines-move-limitations)
-   To move an Azure subscription to a new management group, see [Move subscriptions](https://learn.microsoft.com/en-us/azure/governance/management-groups/manage#move-subscriptions).

[ResourcesOperationsExtensions.MoveResources Method (Microsoft.Azure.Management.ResourceManager) - Azure for .NET Developers | Microsoft Learn](https://learn.microsoft.com/en-us/dotnet/api/microsoft.azure.management.resourcemanager.resourcesoperationsextensions.moveresources?view=azure-dotnet)

`Resource Groups -> $Src -> Tick $Resource -> Move -> Move to another resource group`


## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[Move resources to a new subscription or resource group - Azure Resource Manager | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/move-resource-group-and-subscription)

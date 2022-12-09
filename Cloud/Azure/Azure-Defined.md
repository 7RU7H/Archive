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

#### Resource Locks, Tags and Blueprints

Resource Locks can be applied to lock a resource, preventing modification or deletion
Tags are key value pair that is metadata for catagorization - Not inheritable
Blueprints can contain artifacts that cluster together in meta template that can be assigned it to subscriptions; Blueprint can contain: 
- Resource Groups 
- ARM Templates  
- RBAC 
- Policy 

#### Cloud Adoption Framework

Subscriber migrating to the cloud from exist workloads and enivornment can follow this framework
- Strategizing to define and justify objectives and expected outcomes
- Plans to align action to business utcomes
- Readies preparation of the cloud environment for planned changes
- Migrates and modernize existing workloads 
- Innovates with cloud solutions to develop better virtual infrastructure
- Governs environments and workloads
- Manages operations for cloud and hydrid solutions
- Organizes to align team and roles support business's cloud adoption efforts

####  Resources

Virtualisation of the Hardware

VM - Cores, Memorys, Storage -IOPs, Network Connectivity
SKUs VCPU to memory ratios, IOPs and special characteristics; you are pick based on ratios required
VM Scale Set - Template, Configuration, Scale - Min, Max ranges and Auto
Azure Dedicated Host - Has a SKU, Type (constrains the types of VM hostable)
Azure Batch -  Large parallel workloads

Containers Virtualise the Software

Container Host - OS plus the Container Runtimes contains Users Spaces that runs a Image(has multiple layers runtime, app layer, etc) from a Registry
Azure Container Instance/Group Isolate Hosting run a isolated (from other customers) Images or Group to run on Container Host
Azure [Kubernetes](https://kubernetes.io/) Service 
- Management and Control Pane - maintained 
- Node and Pool - Use VM Scale Sets - VM run in pods (Kubernetes)
Azure App Service - Usual Webservice workloads - API, WebServer
Azure Virtual Desktop - Azure manages an environment to host a published session of desktop or application
Serverless- pay for the work it does
- Event driven
- Pay for work done
	- Azure Functions
		- Run Code in the Cloud
	- Azure Function Apps
		- Low or NoCode - GUI flowchart 

#### Azure Key Vault

Hosts secrets, keys and certifcates with RBAC (more granular level) or Policy (Vault level), these can combined with managed identities.

#### Networking

Virtual Networks are regions within a subscription connected by network protocols, defined by, at bare minimum, IPv4 addresses, with IPv6 it always dual stack (IPV4 and IPv6). Virtual Subnets with assign a range within a Virtual Network. Region could consist of multiple Availability Zones, the subnet would span the entire Availability Zone. You lose five address:
- Gateway
- DNS
- DNS
- First 000
- Last 256

Subnets can have Service Endpoints that can optimised and secures a route to a service with Azure Firewall to control the traffic.

Private Endpoints can instead be a set an IP in a Subnet that point to a particular version of that service.

Public Endpoints and protected by basic Azure DDoS protection service, standard plans can be purchase to protect particular areas of the your Subscription's Virtual Network


Multiple VNs can be peered,which we route over the Azure Backbone.
Gatway can be created to connect over the internet  to on-premises networks, encrypted with:
- Policy state route, legacy VPN gateways
- Route-base; nth number of connections that tunnels encrypted based on the IPsec.
- Express route: Private connection(not over internet) to Azure from on-premise

To control traffic use Network Security Group NSG built around a set of properties listed below; NSG are linked to a subnet. Sit on Layer 4 of OSI
- SRC/DST IP/CIDR or Azure Service Tag or Application Security Group (Tag on put on a network adapter)
- SRC/DST Ports
- Protocol
- Name, Description, Priority
- Allow, Deny, Reject

Azure Firewall a first party network appliance:
- Network rules
- Application rules

User Defined Routes customisation of how traffic hops through the network

#### Storage Accounts

Storage Account most form of storage that builtin upon with great levels of complexity. It has the following attributes:
- Region Specific
- Redundacy - Standard performance:
	- Local Redundant Storage - Distributed over Local to AZ1 in a Region
	- Zone Redundant Storage -  Distributed through the Zones of a Region
	- Global Redundancy Storage - Distributed both Locally in one Zone and also in the Paired Region
	- Geo-Zone Redundancy Storage (GZRS) - Distributed Locally one per Zone and Paired region
		- Always replicates asynchronously!
		- Some services allow reading from a Pair
- Premium Options vary on type; never a Geo-replicated option

Access Tiers - Premium and Standard Account types; Lifecycle Management can change the storage account to automate the tier dynamically. Standard Account type can subdivided into:
- Hot tier - cost more for capicity less for transactions
- Cold tier - less for storage and more for transactions 
- Archive  - Even less storage and more for transactions 
- Offline

Binary Large Objects, stored in a containers
- Blocked is made of blocks 
	- Additionally Block can be Azure Data Lake Store Gen 2 (ADLS) withj Posix style ACLs and Hierarchical File system
- Page is made up of pages, good for read/write
	- Disks use a Page Blob, but abstracts away from the disks
- Append is good for logging

Disk Types - Standard disk performance scale linearly:
- Standard HDD
- Standard SSD
- Premium SSD
- Ultra Disk - IOPs and throughput can be controlled; has dynamic runtime

Premium SSD and Ultra Disk require S variant of VM

Files
- SMB Shares
- NFS Shares

Azure File Sync syncronise on-premise file servers to Azure, not multiple on-premises

Queues
- FIFO Messages
- Drives Event driven processs
- Tables

#### Databases

Database services in Azure for responsibility do not need to run in a VM as responsibility over the OS and everything is unnessicary and insecure. Solutions are provided by Azure:
- MSSQL 
	- Azure SQL Databaste (PaaS)
	- Azure SQL Managed Instances 


Control plane - ARM 
Data plane 
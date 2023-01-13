#  Azure Administration - Files (File Shares)


File share in cloud, a centralized server for storage allowing for multiple connections (mounting) with either SMB or NFS. Azure Files uses:
- Replacement or supplement for Network Attach Storage NAS
- Lift-and-Shift - Classic or Hybird Lifes
- Simplify cloud development
	- Shared application settings
	- Diagnostic share - logs to file share
	- Dev/Test/Debug - Quick sharing of tooling
- Containerization - to persist stateful containers
- Diagnostic logs, metrics, and crash dumps can be written to a file share and processed or analyzed later.
- Configuration files can be stored on a file share and accessed from multiple virtual machines.

Azure files instead of File Shares server
- Share Access - Already setup to work with standard networking protocols SMB and NFS
- Fully managed patched by Azure
- Scalable
- Scripting and Tooling - Automation
- Resiliency 

Comparison betweem Azure Files, Azure Blobs and Azure Disks in choosing storage
![1080](azurecomparefilesblobsanddisks.png)

Azure Files Features:
- Backups - shared snapshots
	- Incremental
	- Read-only
	- 200 snapshots per file share
	- 10 year retention
	- Stored in file share
- Soft Delete
- Advanced Threat Protection
	- Very powerful software
- Store Tiers
	- Premium - SSD storage
	- Transaction optimized - HDD with transaction heavy workloads - historically called standard
	- Hot - optimized for general purpose file sharing 
	- Cool - stored in HDD for cost effienct storage- optimized for archiving scenarios

Types of Storage
- General Purpose version 2 - deployed on HDD
- FileStorage - SSD deplyment

Identity
- On-Premise Azure Storage can  be joined to AD DS
- Managed - Azure Storage can  be joined to AD DS - Microsoft manages
- Store Account Key - Username and password 

Networking 
- Azure Files are accessible from anywhere via storage account public endpoint
- SMB - 445 

 Encryption
 - Encrypted-at-rest using Azure Storage Service Encryptions
 - Encrypted-in-transit with SMB 3.0+ or HTTPS

#### Azure File Sync

Azure File Sync enables caching of Azure File Share on an on-premise or cloud VM, no limit to amount of cacheing with SMB, NFS and FTPS. Use to centralize your organization's file shares in Azure Files.

Cloud tiering is an optional feature of Azure File Sync. Frequently accessed files are cached locally on the server while all other files are tiered to Azure Files based on policy settings.

![](azurefilesynccomponents.png)
Components of Azure File Sync:
- Storage Sync Service
	-  forms sync relationships, a subscription can have multiple
- Sync Group 
	- Defines the sync topology for a set of files
- Registered Server
	- Object that represents a trust relationship between server and Storage Sync service resource
- Azure File Sync agent - package that enables Windows Server to Sync
	- `Microsoft.StorageSync`
- Server and Cloud endpoints


#### Workflows

Create a Azure Files Share
`Storage Account -> $storage_account -> File Shares`
- open port 445 - check firewall
- enable - `Secure tranfer required`

 File mounting can be done on-demand with the `mount` command or on-boot (persistent) by creating an entry in /etc/fstab.

Create file share snapshots
`Storage Account -> $storage_account -> File Shares -> $file_share -> Snapshots

Azure File Sync agent:
```powershell
Microsoft.StorageSync
```

Deploying a Azure File Sync:
1. Deploy Storage Sync Services
2. Prepare Windwos Server(s)
3. Install Azure File Sync agent
4. Register Windows Server(s)
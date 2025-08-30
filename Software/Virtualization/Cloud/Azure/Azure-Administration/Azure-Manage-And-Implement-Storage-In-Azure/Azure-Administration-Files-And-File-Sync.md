#  Azure Administration - Files (File Shares)

[Azure Files](https://learn.microsoft.com/en-us/azure/storage/files/storage-files-introduction) offers shared storage for applications by using the industry standard [Server Message Block protocol](https://msdn.microsoft.com/library/windows/desktop/aa365233.aspx). SMB File share in cloud, a centralised storage allowing for multiple connections (mounting) with either SMB or NFS. 

Azure Files uses:
- Replacement or supplement for Network Attach Storage NAS
- Lift-and-Shift - Classic or Hybrid 
	- "Lift and shift" applications to the cloud with Azure Files for apps that expect a file share to store file application or user data.
- Simplify cloud development
	- Shared application settings
	- Diagnostic share - logs to file share
	- Dev/Test/Debug - Quick sharing of tooling
- Containerisation - to persist stateful containers
- Diagnostic data
	- Logs, metrics, and crash dumps can be written to a file share and processed or analysed later.
- Configuration files can be stored on a file share and accessed from multiple virtual machines.

Azure Files instead of File Shares server
- Share Access - Already setup to work with standard networking protocols SMB and NFS
- Fully managed patched by Azure
- Scalable
- Scripting and Tooling - Automation
- Resiliency 

Comparison between Azure Files, Azure Blobs and Azure Disks in choosing storage
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
	- Transaction optimised - HDD with transaction heavy workloads - historically called standard
	- Hot - optimised for general purpose file sharing 
	- Cool - stored in HDD for cost efficient storage- optimised for archiving scenarios

Types of Storage
- General Purpose version 2 - deployed on HDD
- FileStorage - SSD deployment

Identity
- On-Premise Azure Storage can be joined to AD DS
- Managed - Azure Storage can be joined to AD DS - Microsoft manages
- Store Account Key - Username and password 

Networking 
- Azure Files are accessible from anywhere via storage account public endpoint
- SMB - 445 

 Encryption
 - Encrypted-at-rest using Azure Storage Service Encryption
 - Encrypted-in-transit with SMB 3.0+ or HTTPS

#### File Share Snapshots 

File Share Snapshots are:
- Incremental 
- Shareable
	- Support backup and recovery 
- Only need most recent for retention
	- Protect against application error and data corruption
- Capable of restoring individual files
	- Support backup and recovery
	- Protect against application error and data corruption
- To delete a share you need to delete all its snapshots
	- Protect against application error and data corruption
	- Protect against accidental deletion or unintended changes


#### Azure File Sync

Azure File Sync enables caching of Azure File Share on an on-premise or cloud VM, with no limit to amount of caching with SMB, NFS and FTPS. Use to centralise your organisation's file shares in Azure Files.

- Only for:
	- Standard file shares (GPv2), LRS/ZRS
	- Standard file shares (GPv2), GRS/GZRS
	- Premium file shares (FileStorage), LRS/ZRS

Cloud tier is an optional feature of Azure File Sync. Cloud tiering allows frequently accessed files to be cached on the local server. Infrequently accessed files are tiered or archived to the Azure Files share according to the policy created.
- When a file is tiered, Azure File Sync replaces the file locally with a pointer. A pointer is commonly referred to as a _reparse point_. The *reparse* point represents a URL to the file in Azure Files.    
- When a user opens a tiered file, Azure File Sync seamlessly recalls the file data from Azure Files without the user needing to know that the file is stored in Azure.
- Cloud tiering files have greyed icons with an offline `O` file attribute to let the user know when the file is only in Azure.

![](azurefilesynccomponents.png)
Components of Azure File Sync:
- Storage Sync Service
	-  Forms sync relationships, a subscription can have multiple
- Sync Group 
	- Defines the sync topology for a set of files
- Registered Server
	- Object that represents a trust relationship between server and Storage Sync service resource
- Azure File Sync agent - package that enables Windows Server to Sync
	- `Microsoft.StorageSync`
- Server endpoint
	- represents a specific location on a registered server
- Cloud endpoint 
	-  an Azure Files share that's part of a sync group (entire cloud endpoint  (Azure File Share)syncs)
		- An Azure Files share can be a member of one cloud endpoint only.
		- An Azure Files share can be a member of one sync group only.

Azure File Sync Agent
- **FileSyncSvc.exe**: This file is the background Windows service that's responsible for monitoring changes on server endpoints, and for initiating sync sessions to Azure.
- **StorageSync.sys**: This file is the Azure File Sync file system filter that supports cloud tiering. The filter is responsible for tiering files to Azure Files when cloud tiering is enabled.
- **PowerShell cmdlets**: These PowerShell management cmdlets allow you to interact with the `Microsoft.StorageSync` Azure resource provider. You can find the cmdlets at the following (default) locations:
    - `C:\\Program Files\\Azure\\StorageSyncAgent\\StorageSync.Management.PowerShell.Cmdlets.dll`
    - `C:\\Program Files\\Azure\\StorageSyncAgent\\StorageSync.Management.ServerCmdlets.dll`


#### Workflows

Create an Azure Files Share
`Storage Account -> $storage_account -> File Shares`
- open port 445 - check firewall - [[Azure-Administration-Azure-Firewall]]
- enable - `Secure tranfer required`
- File mounting can be done on-demand with:
	- Windows - `Azure Portal -> Resource Groups -> Azure Files -> $FileShare -> Connect`:
		- Specify Drive
		- Authentication method:
			- Active Directory
			- Storage Account Key
	- Linux - the `mount` command or on-boot (persistent) by creating an entry in `/etc/fstab`.

Accessing a Azure a File Share - Mount with File explorer!
UNC pathing:  `\\$StorageAccount.file.core.windows.net\$FileShare` 


Create file share snapshots
`Storage Account -> $storage_account -> File Shares -> $file_share -> Snapshots

Accessing a Azure a File Share - Mount with File explorer!
UNC pathing:  `\\$StorageAccount.file.core.windows.net\$FileShare` 


[Deploy File Sync](https://learn.microsoft.com/en-us/azure/storage/file-sync/file-sync-deployment-guide) - [[Azure-Administration-Files-And-File-Sync]]
- Only for:
	- Standard file shares (GPv2), LRS/ZRS
	- Standard file shares (GPv2), GRS/GZRS
	- Premium file shares (FileStorage), LRS/ZRS
`Azure File Sync -> Create` - Marketplace - not default, but covered in AZ 104
1. Deploy the Storage Sync Service
	- Configure:
		 - The deployment name for the Storage Sync Service
		- The Azure subscription ID to use for the deployment
		- A Resource Group for the deployment
		- The deployment location
2. Prepare Windows Server(s)
	1. Install Azure File Sync agent
	2. Register servers with Storage Sync Service
		- The Storage Sync Service deployment name
		- The Resource Group for the deployment

Azure File Sync agent:
```powershell
Microsoft.StorageSync
```

- Beware Legacy and older generation require PowerShell at 5.1
- And may require disabling of Internet Explorer Enhanced Security for Admins and Users - **ONLY** for initial server registration! - RESET!
	- FileSyncSvc.exe - service; StoragSync.sys - system filter; PowerShell cmdlets:
```powershell
# Default location for cmdlets 
C:\\Program Files\\Azure\\StorageSyncAgent\\StorageSync.Management.PowerShell.Cmdlets.dll
C:\\Program Files\\Azure\\StorageSyncAgent\\StorageSync.Management.ServerCmdlets.dll
```


[AzCopy](https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-files) is installed by default on the CloudShell
```powershell
# Make file shares
azcopy make 'https://<storage-account-name>.file.core.windows.net/<file-share-name><SAS-token>'

# Upload files or directories
# Suport wildcard 
azcopy copy $localpath $remotepath # upload
# Download
azcopy copy $remotepath $localpath # download
azcopy login # create URI to login

# Supported by not recommended - doesn't support differential copies at scale
# Useful in Temporary File deletion and Syncing between Shares
azcopy sync $localpath $remotepath --delete-desitnation true
```

## References

[Youtube Azure Administrator Certification (AZ-104)](https://www.youtube.com/watch?v=10PbGbTUSAg)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
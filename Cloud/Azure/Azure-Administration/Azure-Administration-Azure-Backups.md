
# Azure Backups


The Azure Backup service provides a simple, secure, and cost-effective solution for backing up your data. Administrators implement the Microsoft Azure Recovery Services (MARS) agent for Azure Backup to recover their data from the Microsoft Azure cloud. Azure Backup Service is a backup layer that spans many Azure services - Scales, secures data at-rest and in-transit with unlimited data transfer:
- On-Premise, Azure VMs, Azure Fiels, SQL Server (via Azure VM), SAP HANNA databases (vie Azure VM), Azure Database for PostgreSQL
- Azure Backup directly integerated with Azure Services - not searchable based on service name
- Offload on-premises backups
- Backup VMs
- App Consistent Backups (restore apps back to an exact state) 
- Automatic Storage Management - with Storage options 

Benefits according to Microsoft:
![](azurebackupbenefit.png)

## Azure Recovery Services (ARS) 

Azure Recovery Services (ARS) vault is a storage entity in  Azure that houses data and recovery points
- Enhanced capabilities to help secure backup data 
- Central Monitoring for your hybrid IT environment
- Azure role-based access controll (Azure RBAC)
- Soft Delte
- Cross Region Restore
 Microsoft Azure REcovery Services (MARS) agent backups files, folders, and system state from Windows on-premises mahcnie and Azure VMs
 - BAckups are stored in a REcovery Services vulat in Azure
 - MARS agent is also known as the Azure Backup agent
 - The AMRS agent does not support Linux operating systems

Azure Site Recovery (ASR) is a hybrid (on-premise to cloud) backup solution for site-to-site recovery


- Recovery Services Vaults 
	- Backup: 
		- File Shares, Files and folders, IaaS VM SQL databases
	- Supports 
		-  Support System Center Data Protection Manager, Windows Server, Azure Backup Server, and other services.
	-  No data transfer -  Don't need to configure the storage replication type. 
		- Azure Files backup is snapshot-based

## Microsoft Azure Recovery Services (MARS) agent

- Requires installation on Windows Client and Server - does not require a seperate backup server it is an agent.
- Location of installation and execution of the MARS agent detirmines what data is backed up 
- Not application-aware
- Runable: 
	- On premises
	- Specific file system locations - VM or Physical
	- From a a Microsoft Azure Backup Server (MABS) instance or a System Center Data Protection Manager (DPM) server to backup to a MABS or DPM.

![](azuremarsagentcompletebackupfromonpremisetocloud.png)

## VM Backups

Azure Backup provides independent and isolated backups to guard against unintended destruction of the data on your virtual machines.
- Azure Backup - best option for production workload backup
	- Microsoft Azure Recovery Services (MARS) agent for Azure Backup
		- See comparison with MABS image
	- Microsoft Azure Backup Server (MABS)
		- See comparison with MARS image
	- Snapshot VMs and stores data a recovery points in geo-redendant recovery vaults - Files or VMs
- Azure managed disks 
	- Snapshots 
		- Read-only full copy of a managed disk 
		- Billed by size used
		- Kept two days to reduce backup and restore times
		- Incremental stored as Blobs
	- Image - Capture a single image containing all managed disks associated with a VM
- Azure Site Recovery -  for scenarios involving replication, failover, and fall back.
	- Disaster recovery for VMs 
	- Can backup data from SQL database  or IaaS VMs, Azure Services
	- Replicate Azure virtual machines from one Azure region to another
       - Replicate on-premises VMware virtual machines, Hyper-V virtual machines, physical servers (Windows and Linux), and Azure Stack virtual machines to Azure
       - Replicate AWS Windows instances to Azure
	- Replicate on-premises VMware virtual machines, Hyper-V virtual machines managed by System Center VMM, and physical servers to a secondary site
- VMs can also be backup with System Center Data Protection Manager (DPM) or Microsoft Azure Backup Server (MABS)
	- For specialized workloads, virtual machines, or files, folders, and volumes - data from SQL server or Microsoft Exchange or Sharepoint

Comparison between MABS and MARS
![](azurecomparisonbetweenmabsandmars.png)

Soft delete for those mistakes everybody makes
![](azuresoftdeleteandbackups.png)

## Workflows

Backup Center
`Search -> Backup Center`:
- `+ Backup`
- `<- Restore`
- `+ Policy`
- `+ Vault`

Backup Workflows
1. Create a Recovery Services Vault - choose LRS/GRS
2. Define a backup policy - when and retention length of data snapshots
3. Backup VMs, etc..

Create a Recovery Service Vault
`Search -> Recovery Services vaults -> + Create`
- Multi-select for backup "What you want to backup" options

Configure replication of recover Service Vault
`$Backup -> Properties -> Backup Configuration -> Update `
- Choose: `Geo-redundant | Locally redundant | Zone redundant`

Implement System Center Data Protection Manager (DPM) and or Microsoft Azure Backup Server (MABS)
- First [deploy the System Center DPM protection agent](https://learn.microsoft.com/en-us/system-center/dpm/deploy-dpm-protection-agent)
- Then [install the DPM protection agent (for MABS)](https://learn.microsoft.com/en-us/azure/backup/backup-azure-microsoft-azure-backup#install-and-update-the-data-protection-manager-protection-agent)
- Any machines that you want to back up must be added to a [System Center DPM _protection group_](https://learn.microsoft.com/en-us/system-center/dpm/create-dpm-protection-groups).

Backup 
`$Backup -> Overview -> + Backup -> Select Workload and What to backup -> Configure:
- Policy Sub type - How many per day, Operation tier (x-y days) Resilience Level 
- Backup Policy - Default, Custom and
	- `Create a new policy`
		- Backup schedule
		- Instant Restore -  Retain instant recovery snapshots for X days
		- Retention Range
- `Add` - Add a Resource
- Check `$Backup -> Protected items -> Backup items -> $resourcetype`

Backup a resource
`$Backup -> Protected items -> Backup items -> $resourcetype -> $resource -> View Details -> Backup Now`

Backup File/Folder 
`Search Virtual Machines -> $VM -> Connect` - Connect to machine - 
`Log into Azure Portal -> Recovery Services vaults -> $rsv -> + Backup -> Workload: On-Premise (regardless) -> Backup: Files and folders -> Prepare Infrastructure:`
- Download the Agent for Windows Server or Window Client
- Installation Setup Wiazrd
- Download the Vault Credentials

Restore or File Recovery VM
`Search Recovery Services Vaults -> $rsv -> Backup items -> Azure Virutal Machines -> $VM -> Restore VM / File Recovery`

Recovery Files:
Locally
`Microsoft Azure Backup Application- > Recover Data -> Select Mode, Volume and Data `
Virtual Snapshots:
`Search Recovery Services Vaults -> $rsv -> Backup items -> $AzureVM -> View Details -> File Recovery -> Download Excutable -> Open IaaSVMILRExeForWindows.exe -> copy and paste Password to run Script into IaaSVMILRExeForWindows.exe`, then
On Host open `cmd.exe` with [robocopy]((https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy):
```powershell
# Copy from the mounted virtual snapshosts
# Consider permissions!
robocopy G:\File\Path\To\Dir C:\File\Path\To\Dir $file /r:1 /w:1 
```
Then `Unmount Disks`

Azure Recovery Services soft delete 
`Search Recovery Services Vaults -> $rsv -> Backup items -> Azure Backup Agent -> View Details -> $ComputerName -> Delete -> Type the Server name* & Provide Reason & Add comment for professionalism & Tick and Delete`

Stop Backup and Deal witht Data retention
`Search Recovery Services Vaults -> $rsv -> Backup items -> Azure Virtual Machine -> View Details -> Stop Backup`, then pick to:
- Retain Backup Data 
- Delete Backup Data
	- Type the name of the backup item* ; add a Reason and comment  

Undelete Backup that has Backup Disabled 
`Search Recovery Services Vaults -> $rsv -> Backup items -> $Backup -> Undelete`

Delete Backup Data Backup
`Search Recovery Services Vaults -> $rsv -> Backup items -> $Backup -> Delete backup data`



## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[robocopy | Microsoft Learn](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy)
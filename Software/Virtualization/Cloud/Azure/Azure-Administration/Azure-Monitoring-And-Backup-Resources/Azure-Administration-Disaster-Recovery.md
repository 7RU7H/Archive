# Azure-Administration Disaster Recovery

#### Failover and Reprotection

Failover to secondary region and Re-Protect (replicate back) to primary region 
From a `$VM -> Overview -> Failover`
- Choose:
	- `Latest processed`: Uses the latest recovery point processed by Site Recovery. The time stamp is shown. No time is spent processing data, so it provides a low recovery time objective (RTO).
	- `Latest`: Processes all the data sent to Site Recovery, to create a recovery point for each VM before failing over to it. Provides the lowest recovery point objective (RPO), because all data is replicated to Site Recovery when the failover is triggered.
	- `Latest app-consistent`: This option fails over VMs to the latest app-consistent recovery point. The time stamp is shown.
	- `Custom`: Fail over to particular recovery point. Custom is only available when you fail over a single VM, and don't use a recovery plan.`
- Be aware of adding disk after enabling replication - where are the replication points and which is to be replicated? 
- `(un)Tick - Shut down machine before beginning failover  ` 
- If satified with failover select `Overview -> Commit`
	- `Commit` deletes all available recovery points for VM in Site Rcovery and cannot change the recovery point! 
- After failover, you reprotect the VM in secodary region to replicates back to the primary region 

Failover back to primary region
- Prerequisites: Set up replication
- `$Vault -> $VM` - VM should be in `Protected` state, `Select Failover`: 
	- Choose:
		- `Latest processed`: Uses the latest recovery point processed by Site Recovery. The time stamp is shown. No time is spent processing data, so it provides a low recovery time objective (RTO).
		- `Latest`: Processes all the data sent to Site Recovery, to create a recovery point for each VM before failing over to it. Provides the lowest recovery point objective (RPO), because all data is replicated to Site Recovery when the failover is triggered.
		- `Latest app-consistent`: This option fails over VMs to the latest app-consistent recovery point. The time stamp is shown.
		- `Custom`: Fail over to particular recovery point. Custom is only available when you fail over a single VM, and don't use a recovery plan.`
	- Be aware of adding disk after enabling replication - where are the replication points and which is to be replicated? 
	- `(un)Tick - Shut down machine before beginning failover`
-  `$Vault -> $VM -> Select Re-protect`


## References

[Learn.Microsoft - Fail over Azure VMs to a secondary region ](https://learn.microsoft.com/en-us/azure/site-recovery/azure-to-azure-tutorial-failover-failback)
[Learn.Microsoft - Fail back Azure VM to the primary region](https://learn.microsoft.com/en-us/azure/site-recovery/azure-to-azure-tutorial-failback)
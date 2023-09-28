# Disable Time Synchronisation with Host for Guest VMs

Disabling Time Synchronisation with Host for Guest Virtual Machines is of situational importance and generally it is not necessary. If for example you happen to being [[Attacking-Kerberos]], but are not  synchronised to the Domain Controller internal clock skew errors or maybe you what to have a Honeypot or create [[Malware-Sandbox]] where the time is deliberately set for deceptive purposes.. 
## [VMWare](https://kb.vmware.com/s/article/1189)

- Solutions to syncing to host:
	- Periodic Time-Sync
	- One-off time sync

To disable periodic time synchronization in a VM, launch vSphere Client, go to `Edit Settings →  VM Options →  VMware Tools → Synchronize Time with Host, and deselect the checkbox "Synchronize time periodically"`  
  
The vmx option for this setting is tools.syncTime and its value can be "TRUE" when periodic time sync is enabled, or "FALSE" when periodic time sync is disabled.  

To disable one-off time synchronization in a VM, launch vSphere Client, go to `Edit Settings →  VM Options →  VMware Tools → Synchronize Time with Host, and deselect the checkbox "Synchronize at startup and resume (recommended)"`

Disabling one-off time synchronization as described will also automatically force disable periodic time synchronization.  
  
This setting is managed with the vmx option time.synchronize.allow. By default, when one-off time synchronization is enabled, the option has the value "TRUE", but is not contained in the vmx configuration file. When one-off time synchronization is however disabled, you can find this option in the vmx configuration file with the value "FALSE".

VMware Workstation, Fusion, and vSphere prior to version 7.01 U1 provide a single checkbox in a VM's VMware Tools control panel, which enables or disables periodic time synchronization only.

To disable periodic time synchronization in a VM, launch vSphere Client, go to `Edit Settings →  VM Options →  VMware Tools → Time, and deselect the checkbox "Synchronize guest time with host"`

To disable one-off time synchronization in a VM, you must set the following advanced configuration settings.  
 
|   |
|---|
|time.synchronize.continue = "FALSE"<br>time.synchronize.restore = "FALSE"<br>time.synchronize.resume.disk = "FALSE"<br>time.synchronize.shrink = "FALSE"<br>time.synchronize.tools.startup = "FALSE"<br>time.synchronize.tools.enable = "FALSE"<br>time.synchronize.resume.host = "FALSE"|


## [Virtualbox](https://forums.virtualbox.org/viewtopic.php?t=97014)


```bash
VBoxManage setextradata "VM name" "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled" 1
```

## References

[Virtualbox - forum post to Disable Time Synchronisation with Host for Guest VMs](https://forums.virtualbox.org/viewtopic.php?t=97014)
[VMWare issue 1189 - to Disable Time Synchronisation with Host for Guest VMs](https://kb.vmware.com/s/article/1189)
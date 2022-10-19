# Windows 10 in VirtualBox

During preperation for my OSCP the trials and tribulations of making a VM to to buffer overflow exploitation and dot net compilation on lead me to many issues post installation up windows VMs in VirtualBox. [Tolga Bagci is awesome](https://github.com/TolgaBagci) I ran into crashes and weird installation issues until I hit this [article](https://www.sysnettechsolutions.com/en/install-windows-10-in-oracle-vm-virtualbox/), ISOs seem not the way to go so [Linda's article to download](https://www.partitionwizard.com/partitionmanager/win10-iso-for-virtualbox-vmware.html)

## Downloading..

ISO's sometimes seem to work, it worked for my [[Active-Directory-Lab]] making, but [Here](https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/)]
![](windows-vm-download.png)

## Converting the Disk type
From [howtogeek](https://www.howtogeek.com/312456/how-to-convert-between-fixed-and-dynamic-disks-in-virtualbox/)

Windows,
```powershell
VBoxManage.exe list hdds

# From fixed to dynamic
VBoxManage.exe clonemedium disk "C:\path\to\source.vdi" "C:\path\to\destination.vdi" –variant Standard
# To dynamic from fixed
VBoxManage.exe clonemedium disk "C:\path\to\source.vdi" "C:\path\to\destination.vdi" –variant Fixed
```

## Changing Disk Size
Change the disk size `File -> Virtual Media Manager`
![disksize](windows-vm-change-disk-size.png)

## Prior to Install

Enable the 3D acceleration for least whining from GPU related issues
![](windows-vm-3d-display.png)


Change Paravirtualization to Microsoft's Hyper-v
![hyper-v](windows-vm-paravirtualization-interface-hyper-v.png)
[VirtualBox Documentation](https://docs.oracle.com/en/virtualization/virtualbox/6.0/admin/nestedpaging.html)*If nested paging is enabled, the Oracle VM VirtualBox hypervisor can also use large pages to reduce TLB usage and overhead. This can yield a performance improvement of up to 5%. To enable this feature for a VM, you use the **VBoxManage modifyvm --largepages command**.*

Change the Drive type to optimise 
![SSD](windows-vm-ssd-select.png)
and enable: `Use Host I/O Cache`
![hostio](windows-vm-host-io.png)


# Installation and Post
Installation is simple if you want to be. It is a simple click through unless you want lots of partitions and generally turn off as much telemetry stuff as you can. Next suggestion is to Debloat it with one of the scripts on Github.

If you used the Edge Developer, the default user is has the password `Passw0rd!`

```powershell
net user /add <user> password
net localgroup <preferedGroup> <user> /add
# Remove the default user
net user /del <user>
net localgroup <usersfromgroupsyoudontwantpartof> <users> /del
```



## Reference

[This article SAVED me from myself](https://www.sysnettechsolutions.com/en/install-windows-10-in-oracle-vm-virtualbox/)
[Disk size increase](https://recoverit.wondershare.com/computer-problems/increase-virtualbox-disk-size.html)
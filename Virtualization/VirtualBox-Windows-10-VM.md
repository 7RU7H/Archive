# Windows 10 in VirtualBox

During preperation for my OSCP the trials and tribulations of making a VM to to buffer overflow exploitation and dot net compilation on lead me to many issues post installation up windows VMs in VirtualBox. [Tolga Bagci is awesome](https://github.com/TolgaBagci) I ran into crashes and weird installation issues until I hit this [article](https://www.sysnettechsolutions.com/en/install-windows-10-in-oracle-vm-virtualbox/), ISOs seem not the way to go so [Linda's article to download](https://www.partitionwizard.com/partitionmanager/win10-iso-for-virtualbox-vmware.html)

## Downloading..

ISO's sometimes seem to work, it worked for my [[Active-Directory-Lab]] making, but [Here(https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/)]
![](windows-vm-download.png)

Change the disk size `File -> Virtual Media Manager`
![disksize](windows-vm-change-disk-size.png)

## Prior to Install

Enable the 3D acceleration for least whining from GPU related issues
![](windows-vm-3d-display.png)


Change Paravirtualization to Microsoft's Hyper-v
![hyper-v](windows-vm-paravirtualization-interface-hyper-v.png)


Change the Drive type to optimise 
![SSD](windows-vm-ssd-select.png)
and enable: `Use Host I/O Cache`
![hostio](windows-vm-host-io.png)

# Installation and Post
Installation is simple if you want to be. It is a simple click through unless you want lots of partitions and generally turn off as much telemetry stuff as you can. Next suggestion is to Debloat it with one of the scripts on Github.

The default user is has the password `Passw0rd!`

## Reference

[This article SAVED me from myself](https://www.sysnettechsolutions.com/en/install-windows-10-in-oracle-vm-virtualbox/)
[Disk size increase](https://recoverit.wondershare.com/computer-problems/increase-virtualbox-disk-size.html)
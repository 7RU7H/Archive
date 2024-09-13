# Creating Vulnerable Virtual Machines for CTFs, Practice and Profit


## Introduction and Why?

- To Learn 
	- Networking
	- Operating Systems of least exposure: \*nixs or Window
	- Service Configurations
	- Active Directory
	- Attack Techniques
- Personal Sandbox environment 
- Portability
	- With Cloud computing cloning a setup  and deploying it for bug bounty or security assessment -Daniel Messlier talks in [[TALK-Mechanizing-The-Methodology]] 
	- Between personal machines
- Safety
	- Protect against your own personal stupidity or mistakes and not angrying anyone or local authorities.
	- For [[Malware-Analysis]]
- Testing and Trailing Exploits
	- Instead of firing off a buffer overflow, replicate the software and test locally 

For making an [[Active-Directory-Lab]]

## Hardware Resource Requirements

- A CPU that supports virtualisation.
- More CPU Core for more VMs or more powerful VM(s)
- RAM more the merrier
- HD Space

## ISOs

For Windows 7 ISOs see:
https://techpp.com/2018/04/16/windows-7-iso-official-direct-download-links/


## Software

Virtualiser - Virtualbox or VMWare
- [[Packer]]
	- [VirtualBox Builder from an ISO](https://developer.hashicorp.com/packer/plugins/builders/virtualbox) - use json to save space in your brain 
	- Use smallest, featureless ISOs possible!
	- Preconfigure Virtualiser Networking
	- Preseed files (include anisible is you using it to provision)
	- `packer validate $build.json`
	- `packer build $build.json*`
Provisioner - [[Virtualization/Ansible]] - Or Packer provisioners [Windows Shell](https://developer.hashicorp.com/packer/docs/provisioners/windows-shell) or [Powershell](https://www.packer.io/docs/provisioners/powershell)


## References

[Mich Van Deusen's Blog](https://micahvandeusen.com/creating-a-vulnerable-machine/)
[Ippsec's Steam](https://www.youtube.com/watch?v=B_7NIkSlYuQ)
[Conda playlist](https://www.youtube.com/playlist?list=PLDrNMcTNhhYoEjHYs0ZBfcSE7Hw46BeTA)
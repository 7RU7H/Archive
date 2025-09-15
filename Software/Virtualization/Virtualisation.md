# Virtualisation


[Virtualisation](https://en.wikipedia.org/wiki/Virtualization) *"is the act of creating a virtual (rather than actual) version of something at the same abstraction level, including virtual [computer hardware](https://en.wikipedia.org/wiki/Computer_hardware "Computer hardware") platforms, [storage devices](https://en.wikipedia.org/wiki/Data_storage_device "Data storage device"), and [computer network](https://en.wikipedia.org/wiki/Computer_network "Computer network") resources."*

Benefits
- Reduction in expenditure
- Scalability
- Efficiency

Hypervisor Typology

#### Type 1 Hypervisors   

Also termed as "bare metal hypervisors" as the hypervisor is the layer on top of the hardware and is the often headless operating system (remote management accessible via web-based portal).
```goat
[App][App]
[Guest OS]
[Type 1 Hypervisor]
[Hardware]
```

#### Type 2 Hypervisors 

Also termed as "hosted hypervisors"
```goat
[App][App]
[Guest OS]
[Type 2 Hypervisor][App][App]
[Host OS]
[Hardware]
```

#### Technologies

Hyper-V (both a type 1 and type 2 Hypervisor)
VirtualBox (type 2) 
VMWare ESXi (type 1)
VMWare WorkStation (type 2) 
QEMU (can emulate full systems can be used with a Kernal-based Virtual Machine for near native speeds)


#### Internals

Virtual CPU
Virtual RAM
Virtual Storage
Virtual Networking

Paravirtualisation is the concept of the guest virtual machine have self knowledge of its virtualisation and not using bare metal hardware.

Nested Virtualisation is running a Hypervisor inside a Virtual Machine

## References

[Virtualisation](https://en.wikipedia.org/wiki/Virtualization)
[THM Virtualization and Containers Room](https://tryhackme.com/room/virtualizationandcontainers)
[THM Hypervisor Internals Room](https://tryhackme.com/room/hypervisorinternals)
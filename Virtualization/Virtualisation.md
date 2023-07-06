# Virtualisation


[Virtualisation](https://en.wikipedia.org/wiki/Virtualization) *"is the act of creating a virtual (rather than actual) version of something at the same abstraction level, including virtual [computer hardware](https://en.wikipedia.org/wiki/Computer_hardware "Computer hardware") platforms, [storage devices](https://en.wikipedia.org/wiki/Data_storage_device "Data storage device"), and [computer network](https://en.wikipedia.org/wiki/Computer_network "Computer network") resources."*

Benefits
- Reduction in expenditure
- Scalability
- Efficiency

Hypervisor Typology

Type 1 Hypervisors   

Also termed as "bare metal hypervisors" as the hypervisor is the layer on top of the hardware and is the often headless operating system (remote management accessible via web-based portal).
```goat
[App][App]
[Guest OS]
[Type 1 Hypervisor]
[Hardware]
```

Type 2 Hypervisors 

```goat
[App][App]
[Guest OS]
[Type 2 Hypervisor][App][App]
[Host OS]
[Hardware]
```


## References

[Virtualisation](https://en.wikipedia.org/wiki/Virtualization)
[THM Virtualization and Containers Room](https://tryhackme.com/room/virtualizationandcontainers)
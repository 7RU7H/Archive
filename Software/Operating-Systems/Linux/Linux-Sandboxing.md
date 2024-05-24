# Linux Sandboxing

Much of this article is my attempt to digest [baeldung - Sandboxing fundamentals](https://www.baeldung.com/cs/sandboxing-fundamentals) and others, a so a in computer science *"a sandbox refers to an environment in which a program can run isolated from the rest of your system with limited access to resources."* My object of this page is a to hopeful sandbox Discord on Linux as it seems the most broadly applicable and could actually prevent some spreading of Malware. Or at least raise the bar slightly. Sandboxing can take various approaches with technologies like [[Virtual-Machines]], [[Containerisation]] or [[Software-Emulation]] or as segmented part of mountable part of the file system of the host OS with some thing like `jailkit` - [baeldung - Sandboxing Processes](https://www.baeldung.com/linux/sandboxing-process). The last article directly highlights that *"The price we pay for higher isolation is a higher compute resource usage**, as we need to emulate the entire operating system. Besides that, the start-up and tear-down speed is much longer. Importantly, the virtual machine image is typically bulky in the range of 5 to 20GBs."*

#### `jailkit`, `chroot` and alternatives

 [baeldung - Sandboxing Processes](https://www.baeldung.com/linux/sandboxing-process)
#### Containers

As per my objective to writing this page I decided the best option would be to run discord in a hardened and very limited [[Docker]] container. I decided to make my own, because I have escape enough containers in CTFs to know that a privilege docker container has very few use cases other than making life very easy for everyone.

 [baeldung - Sandboxing Processes](https://www.baeldung.com/linux/sandboxing-process)
https://www.baeldung.com/linux/docker-container-gui-applications
https://itsfoss.com/install-discord-linux/

``` 


```


#### VMs

[baeldung - Sandboxing Processes](https://www.baeldung.com/linux/sandboxing-process)


## References

[baeldung - Sandboxing fundamentals](https://www.baeldung.com/cs/sandboxing-fundamentals)
[baeldung - Sandboxing Processes](https://www.baeldung.com/linux/sandboxing-process)
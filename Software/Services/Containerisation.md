
# Containerisation

Containerisation is the virtualisation at an OS level or an application level. It is a process of encapsulating or packaging an application with any dependencies to run isolated,  uniformly and consistently on any infrastructure. [Containerization](https://www.ibm.com/uk-en/cloud/learn/containerization) is considered an alternative or companion to [Virtualization](https://www.ibm.com/uk-en/cloud/learn/virtualization-a-complete-guide), but is use to group the require resources of an application to deal with issues of dependencies and compatibility at various levels - without the need to install an entire OS with [[Virtual-Machines]]

Using Docker as an example, the table below attempts to illustrate that Container 1 and 2 are isolated, but run on the same Docker Engine that sit on a OS and that physical machine. See [[Docker]] for introductory reference to Docker.

**Container 1** | **Container 2**
--- | --- 
Application 1 | Application 2
Environment 1 | Environment 2
Docker Engine | ...
OS (host) | ...
Physical Computer |

Containerization requires the kernel's namespace feature to segment - isolate - processes and resources of underlying OS. In [[Kubernetes]] and [[Cloud-Computing-Defined]] generally occurs at the level of [[Virtual-Networking]] and not a the Hardware level.

## References

[Wikipedia Containerization](https://en.wikipedia.org/wiki/Containerization_(computing))
[IBM Containerization](https://www.ibm.com/uk-en/cloud/learn/containerization)
[THM Intro to Containerisation](https://tryhackme.com/room/introtocontainerisation)
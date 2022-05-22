# Active Directory Lab Making

## Introduction
AD is everywhere and this article is full of Acronyms to ensure that the length of this is smaller than the size of the official documentation so firstly a glossary of term to \[Home\] key to. Then the contents.

##### Glossary of Terms 
Acronym | Contraction
--- | ---


##### Contents
1. List of Requirements and where to get them
2. *some* general Installation instructions


## List of requirements
Although inspired by all the references there are two contraints for these requirements. Your CPU must support modern virtualisation - **check**. Firstly atleast 32 GB of RAM! You need enough to host your OS and four virtual machines: Hacking-OS; DC VM and two AD users VMs. Atleast 80gb spare memory
1. 4-8gb for Kali/Parrot/BlackArch
2. Domain controller
3. Users need the least but need 




## Active Directory Domain Service (AD DS) Components

For a more realistic AD here is a very brief outline of the compnents

[Official Overview](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview)


Physical Components | Details
--- | ---
Data Store | AD DS information as a file on DC  
DCs | Contains copy of AD DS database
Read-Only DC | Contains copy of AD DS database
Global catalog servers | Hosts global catalogue *see 1.*

1. Global catalogue - *contains information about every object in the directory. This allows users and administrators to find directory information regardless of which domain in the directory actually contains the data*. It is a mapping of contexts in AD forest , speeding up searches for objects attached to DC within a forest.  

Logical Components | Details
--- | ---
Partitions | Domain directory, Configuration directory, Schema directory, global catalog, application directory
Schema | The Ruleset defining the classes of obejcts and attributes
Domains | 
Domain Trees | 
Forests |
Sites | Collections of users, groups, computers as defined by their physical locations.



## References
[shehackske](https://shehackske.medium.com/active-directory-how-to-set-up-an-ad-lab-66647fb453c0)
[cybermentor video](https://www.youtube.com/watch?v=xftEuVQ7kY0)
[hostadvice](https://hostadvice.com/how-to/how-to-install-virtualbox-on-windows-server-2022/#paragraph3)
[hackingarticle](https://www.hackingarticles.in/active-directory-pentesting-lab-setup/)
[drunkrhin0](https://medium.com/swlh/building-an-active-directory-lab-part-1a-automatedlab-fc2399ebe5be)

[ADDS Overview](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview)
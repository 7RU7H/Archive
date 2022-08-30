# Data Exfiltration Defined

This article will attempt to define Data Exfiltration and link futher articles to concepts and methods related to the general concept of Data Exfiltration. Data Exfiltration is non-tradition approach for copying and transferring data from a compromised system to a attacker controlled machine. The means for which the Data is Exfiltrated is delibrately obsucated by trying to emulate normal network activity. For regular file transfers see [[File-Transfers]], [[Linux-File-Transfers]] and [[Windows-File-Transfers]]


## Introduction

Data Exfiltration is is a post-compromise process and ultimate stage of [[Lockhead-Martin-Cyber-Kill-Chain]], that the act of taking an unauthorized copy of sensitive data and moving it from the inside of an organization's network to the outside. The term Data Exfiltration also refer the methods of evasion and stealth used to evade security and hide malicious activities. The Data that is exfiltrated is valuable in some way. Other than to steal data the use cases also include C2 communications(see [[Introduction-To-Comand-And-Control-Frameworks]]) and tunneling - see [[Port-Redirection-And-Tunneling]]


#### Tradition Data Exfiltration Diagram

All traffic is only one direction:
```
# Data Exfiltration
Attacker -> Attack Server <- <- Target Network Security <- Target Network Data Stores
							<- - - - - - - - DATA  
```

#### C2 Communication Diagram

C2 frameworks provides standard and non-traditional protocols to send commands and recieve responses from establish a two way communication channel between Attacker and C2 Beacon.
```
# C2 Communication
						  <- <- Outbound   			    <- <- Outbound
Attacker -> Attack Server -- -- Target Network Security -- C2 Beacon on Target Network 
						  -> -> Inbound					-> -> Inbound
```

#### Tunneling Diagram

Attacker uses data exfiltration technique to establish a communication channel acting like a tunnel to between a victim and attacker's machine to allow attack access the entire network.
```
# Tunneling
	___Represents_the_Attacker's_communication_really_it's_going_through_tunnel___
	|                                                                             |
	|					  <- <- Tunnel   			    <- <- Tunnel              |
Attacker -> Attack Server -- -- Target Network Security -- C2 Beacon on Target Network 
						  -> -> Tunnel					-> -> Tunnel
```

## Methods of Obsucation

#### Encoding

#### Archiving

## Data Exfiltration
[[Data-Exfiltration-Over-TCP-Sockets]]
[[Data-Exfiltration-Over-SSH]]





## References

[THM Data Exfiltration](https://tryhackme.com/room/dataxexfilt)
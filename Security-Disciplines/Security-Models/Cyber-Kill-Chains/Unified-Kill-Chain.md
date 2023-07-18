# Unified Kill Chain

Invented by [Paul Pols](https://www.linkedin.com/in/paulpols) The Unified Kill Chain was originally developed in his master's thesis titled “[_Modeling Fancy Bear Attacks: Unifying the Cyber Kill Chain_](https://www.unifiedkillchain.com/assets/The-Unified-Kill-Chain-Thesis.pdf)”. The thesis was written for the executive master’s programme in Cyber Security by the University of Leiden, where Paul now teaches as a lecturer.*The Unified Kill Chain was developed through a hybrid research approach, combining design science with qualitative research methods. The Unified Kill Chain extends and combines existing models, such as Lockheed Martin's Cyber Kill Chain® and MITRE's ATT&CK™.*

![](unified-kill-chain.png)


"Kill Chain" originates as military term to map the idea of linear attack paths; the UKC states that there are 18 phases to an attack:

![](ukc18phases.png)

1 - 9 being Inital Foothold, while 10 -14 recursive contain paths from 1 - 9 in Network Propagation; 15 - 18 being the Action on Objective of cleanup and exfiltrate/sabotage/extort.
1. Reconnaissance ([MITRE Tactic TA0043](https://attack.mitre.org/tactics/TA0001/)) - [[Passive-Recon]] and [[Active-Recon]]
2. Weaponization ([MITRE Tactic TA0001](https://attack.mitre.org/tactics/TA0001/))
3. Delivery 
4. Social Engineering ([MITRE Tactic TA0001](https://attack.mitre.org/tactics/TA0001/)) - [[Phishing]]
5. Exploitation ([MITRE Tactic TA0002](https://attack.mitre.org/tactics/TA0002/))
6. Persistence ([MITRE Tactic TA0003](https://attack.mitre.org/tactics/TA0002/)) - [[Persistence]]
7. Defense Evasion ([MITRE Tactic TA0005](https://attack.mitre.org/tactics/TA0005/)) - [[Antivirus-Evasion]], and any technique that done evade defense
8. Command and Control ([MITRE Tactic TA0011](https://attack.mitre.org/tactics/TA0011/)) - [[C2-Matrix]]
9. Pivoting ([MITRE Tactic TA0008](https://attack.mitre.org/tactics/TA0008/)) - [[Port-Redirection-And-Tunnelling]]
11. Discovery ([MITRE Tactic TA0007](https://attack.mitre.org/tactics/TA0007/)) - [[Network-Infrastructure-Enumeration]]
12. Privilege Escalation - [[Privilege-Escalation]]
13. Credential Access ([MITRE Tactic TA0006](https://attack.mitre.org/tactics/TA0006/)) [[AD-Credential-Harvesting]]
14. Execution ([MITRE Tactic TA0002](https://attack.mitre.org/tactics/TA0002/))
15. Lateral Movement ([MITRE Tactic TA0008](https://attack.mitre.org/tactics/TA0008/)) [[Lateral-Movement]]
16. Collection  ([MITRE Tactic TA0009](https://attack.mitre.org/tactics/TA0009/%3E%3Cp%20style=))
17. Exfiltration ([MITRE Tactic TA0010](https://attack.mitre.org/tactics/TA0010/)) [[Data-Exfiltration-Defined]]
18. Impact ([MITRE Tactic TA0040](https://attack.mitre.org/tactics/TA0040/))
19. Objectives


## References

[THM Unified Kill Chain](https://tryhackme.com/room/unifiedkillchain)
[UKC official](https://www.unifiedkillchain.com/assets/The-Unified-Kill-Chain-Thesis.pdf)
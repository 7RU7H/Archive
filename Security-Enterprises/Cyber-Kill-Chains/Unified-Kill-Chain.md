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
7. Defense Evasion ([MITRE Tactic TA0005](https://attack.mitre.org/tactics/TA0005/)) - [[Antivirus-Evasion]]
8. Command and Control ([MITRE Tactic TA0011](https://attack.mitre.org/tactics/TA0011/)) - [[C2-Matrix]]
9. Pivoting ([MITRE Tactic TA0008](https://attack.mitre.org/tactics/TA0008/))- [[Port-Redirection-And-Tunneling]]
11. Discovery 
12. Privilege Escalation - [[Privilege-Escalation-Defined]]
13. Credential Access - [[AD-Credential-Harvesting]]
14. Execution
15. Lateral Movement - [[Lateral-Movement]]
16. Collection
17. Exfiltration - [[Data-Exfiltration-Defined]]
18. Impact
19. Objectives


## References

[THM Unified Kill Chain](https://tryhackme.com/room/unifiedkillchain)
[UKC official](https://www.unifiedkillchain.com/assets/The-Unified-Kill-Chain-Thesis.pdf)
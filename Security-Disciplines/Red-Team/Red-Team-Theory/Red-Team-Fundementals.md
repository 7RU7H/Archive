# Red Team Fundementals

## Introduction

Red Teaming in some definitions is catch all term to describe cyber offensive activities. Red teaming is a term borrowed from the military - the attacking side and the Blue being the defending side. Vulnerability Assessments, Penetration Tests and Adversary Emulation of Advance Persistent Threats. Scaling these activities start at technically and legally offensive to very illegal and very offensive. A from scanning a computer to demonstratively proving capability due to lack of security measure potentially exfiltration data by stealth or setting up sabotage for destruction or data to be held ransom. Moloch from [YouTube - The Sliver C2 Framework - Moloch](https://www.youtube.com/watch?v=tkjMZuZ_8nw): *"Remember the real adversary is Third Parties."* 

## Definitions
- As with many Ed Skoudis terms: "Squishy" definition, these are work in progress till they will continue to solidify and as far as I can tell from DEFCON, SANs and Blackhat these terms are relative new and will continue to change, although maybe now as of 2022 only slightly. 

Vulnerability assessment are the scanning of consenting hosts for vulnerabilities as individual entities so that security deficiencies can be **identified** and effective security measures can be deployed to **protect** the network in a prioritised manner. 

Penetration Tests are an attempt to **exploit** the vulnerabilities found on network of systems or system to compromise a given host to then conduct **post-exploitation** tasks  to pivot to other hosts that were not previously accessible to continue to compromise the administrative hierarchy as far a possible. 

Adversary Emulation of Advance Persistent Threats is to emulate the tactics of the potential real-world adversaries to the Blue Team of the network to further prepare defences and teaming in the event of actual attempt to hack the network.

## Red Team Engagements

The meta-objective of Red Team Engagements is to testing and help improve the defensive team's capabilities at **detecting** and **responding** to a real threat actor's Tactics, Techniques and Procedures (TTPs).

The Red Team's goal is to get the "crown jewels" or "flags". These being objectives that reflect the performing similar tactics, successful excuting techniques and procedures (TTPs). These range over these attack surfaces currently:
-   **Technical Infrastructure:** Finding technical vulnerabilities, but with a much higher emphasis on stealth and evasion.
-   **Social Engineering:** Targeting people through phishing campaigns, phone calls or social media to trick them into revealing information that should be private.
-   **Physical Intrusion:** Using techniques like lockpicking, RFID cloning, exploiting weaknesses in electronic access control devices to access restricted areas of facilities.
Scale of Engagement:
-   **Full Engagement:** Simulate an attacker's full workflow, from initial compromise until final goals have been achieved.
-   **Assumed Breach:** Start by assuming the attacker has already gained control over some assets, and try to achieve the goals from that stage of workflow.
-   **Table-top Exercise:**  An over the table simulation where scenarios are discussed between the red and blue teams to evaluate how they would theoretically respond to certain threats.

## Teams and Functions

Team (x Cell) | Definition
--- | ---
Red | Attackers
Blue | Defenders
White | Arbitrators or Referees, monitor adherence to the Rules of Engagement

Red Team Composition

Role | Purpose
--- | --- 
Red Team Lead | Plans and organises engagements at a high level—delegates, assistant lead, and operators engagement assignments
Red Team Assistant Lead | Assists the team lead in overseeing engagement operations and operators. Can also assist in writing engagement plans and documentation if needed.
Red Team Operator | Executes assignments delegated by team leads. Interpret and analyse engagement plans from team leads.


[Definitions from redteam.guide](https://redteam.guide/docs/definitions/)


## Engagement Structure 
These are general structured around a APT from [Mitre Att&ck](https://attack.mitre.org/) and cyber kill chain:

[[Lockhead-Martin-Cyber-Kill-Chain]]
[[Varonis-Cyber-Kill-Chain]]
[[Unified-Kill-Chain]]
[AD-Attack and Defense -Github](https://github.com/infosecn1nja/AD-Attack-Defense)

See [[Red-Team-Engagements]] for more and 

##  Red Team Activities

[[Red-Team-OPSEC]]
[[Red-Team-Threat-Intel]]
[[Red-Team-Recon]]
[[Red-Team-Weaponization]]
[[Red-Team-Tooling]]


## References
[Mitre Att&ck](https://attack.mitre.org/)
[Unified Kill Chain](https://unifiedkillchain.com/)
[THM Red Team Fundementals Room](https://tryhackme.com/room/redteamfundamentals)
[Definitions from redteam.guide](https://redteam.guide/docs/definitions/)
[AD-Attack and Defense -Github](https://github.com/infosecn1nja/AD-Attack-Defense)
[YouTube - The Sliver C2 Framework - Moloch](https://www.youtube.com/watch?v=tkjMZuZ_8nw)
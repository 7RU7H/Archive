# CTI And Containment 

#### Preparations...

Preparations encapsulates monitoring and logging activity within a environment that is to be protected.  It is a continuous process:
- Defining what is normality within your environment such abnormal is easier to find.
- Integrating threat intelligence and Indicators of Compromise IoCs into protective mechanisms
- Assessing infrastructural weaknesses
#### Pre-Containment 

Pre-Containment is post-breach event were control of environment is being determined by the actions of blue team and attackers. This stage of the process focuses on the steps necessary to prevent an incident from having further impact.

- [[EDR]]
- Intrusion Detection Systems (IDS)
- [[SIEM-Solutions]]
- Honeypotting

#### Containment Strategies

Beware any strategies that are being observed by adversaries as counting them will force them to achieve their objectives.

**Entire isolation** - incidence response team completely isolating the infected device(s) through network segmentation or physical.

**Controlled Isolation** - incidence response team closely monitors the adversary’s actions without complete isolation of compromise systems to gather information about the adversary. 

#### CTI Creation and Feedback Loop

[[Cyber-Threat-Intelligence]] is continuous process and positive feedback loops from assess past processes that have occurred is vital for ongoing defence of an environment. 

## References

[THM Threat Intel & Containment Room](https://tryhackme.com/room/intelcreationandcontainment)
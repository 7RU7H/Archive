# Keynote: Researched Adversaries - Dave Kennedy

[TALK: Keynote: Researched Adversaries - Dave Kennedy SANS Offensive Operations](https://www.youtube.com/watch?v=mNum2Xt1ibg), discusses how modern adversaries operate and considers comparative capbabilities have increased over time while organisation without dedicated security staff have struggle to deal with APTs. 

Description: *The security industry was forged in research. Many of our abilities to defend networks as well as secure software, infrastructure, and organizations all came from continual improvements, innovation, and our ability to address security issues. With the birth of profitable organized crime (ransomware), much of the private research industry which was once only afforded to governments with capabilities, now resides in specialized groups that continual to expand in sophistication and capabilities. This talk will dive into why - now more than ever the security industry needs to continue with building better capabilities around understanding our own environments and demonstrate why offensive research is such an important aspect a successful defensive strategy. The talk will also show some research capabilities that has advanced our own offensive abilities."*

Dave concedes that his prediction that "ransomware was a fad" was in hindsight very, very wrong. Out ransomware, Offensive Teams began to focus at mapping Offensive Teams work to improve Defense Teams. 

Adaptive PenTesting - modern version of Pentesting covered here, thinking like an attack to improve defense, not just scans and Go Domain Admin.

5% of Global Organisations can handle the capabilities of Red Teams.

Major Progress in Red and Blue visibilty, understanding and collaboration; not wanting the Offensive Security side to not return the shadows.

I know I will alert, can I craft narrative reason with actions as to stop the SOC analyst raising the alert level to a higher level. 

Use Big Powershell Script, write a comment stating it was written and forged signed by one of the organisation's legitamte Powershell users the SOC is going to consider it a false positive.

## Research Adversary

Conti leaks showed tools, research and Helpdesk for the ransomware.

Purchasing of Carbon Black and other Big Nation state tooling.

Lapsus$ had major breaches on Globant, Azure, Nvidia, Okta, Samsung, Uber, Rockstar Games - all demonstrating learning the infrastructure and use of adaptive attacks. Many were teenagers.

Push Notification are not acceptable for MFA - 99% push on Allow after multiple attempts.
- Poor ordinary people

## What's  Changed

Adversiaries are specializing:
- Ransomware as a service
- Phishing as a service
- Cloud 

For Defense we have:
- MFA
- Visibility and identication of attacks
- Minimization internal/external of attack surface
- Monitoring, Detection and Response
- Zero Trust
- Cloud migration and visibility - Lapsus$: bypass monitoring by target a sweet spot to breach
- Perimeter security
- Education and Awareness
- Endpoint visibilty and protection
- Minimization of rights of users and ability to prevent lateral movement. 

Tech advances
- GPUs and Password Cracking
- Replicability 
- Public Offensive Tools get manipulated and bypass signatures 
	- Examples given:
[Unicorn](https://github.com/trustedsec/unicorn) - Unicorn is a simple tool for using a PowerShell downgrade attack and inject shellcode straight into memory. Based on Matthew Graeber's powershell attacks and the powershell bypass technique presented by David Kennedy (TrustedSec) and Josh Kelly at Defcon 18.

[CS-Situational-Awareness-BOF](https://github.com/trustedsec/CS-Situational-Awareness-BOF) - Situational Awareness commands implemented using Beacon Object Files.

## Attack Customization

MITRE as detections are great baseline for defense, but signature-based detection that are customizations are a way to bypass all of these baselines. 

Customization and knowing were the detection will be is the basis for successful bypassing [[AMSI-Bypassing]] and [[EDR-Bypassing]]

Powershell is still [[Useful_Powershell]]..as detections are fragile. Change the defaults.

Obsure LOLBins like follina attack with [mtds.exe](https://lolbas-project.github.io/lolbas/Binaries/Msdt/) can bypass detections.


## Why is Security Hard

It is complex and too few people, but the larger the organisation the more meetings and complexity of the infrastructure.

It is time and resource expensive and Adversaries are fast moving - solution in part is visibility - detection can move fast.

We need more:

Detection Engineers and CTI positions.
More Telemetry
More Visibility
More longer term planning
Response and ability to minimize contan damage

![1080](sansdavekennedykeynoteresearchedadversariestalk-wheretobeginslide.png)

Data and understanding it is he key to insert colour of team here to make any related of another team better 

## References

[TALK: Keynote: Researched Adversaries - Dave Kennedy SANS Offensive Operations](https://www.youtube.com/watch?v=mNum2Xt1ibg)
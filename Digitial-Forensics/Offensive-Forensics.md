# Offensive Forensics

[Rob Lee's SANS Talk](https://www.youtube.com/watch?v=WwmcZSHw66w) - description: *Offensive Operations and Penetration testing often emphasize "breaking in" and gaining credentialed access. But that is only the first part of the story. But "Now what?" Once operators or nation-state actors have gained entry into environments, what will they face, and what are they up against? What is their objectives? And how will they remain stealthy to maintain access over time to the target for their purposes? Rob's experience working with operators in contested post-compromise environments is informative and telling. Buckle up.*

Assumptions:
- Post Compromise
- Credentials Gains
- fundamental Control of Network Ganined

Now What?

- How do you do that incognito - so without Forensics tools?
- Why are you there? - Objectives!

Now you apply Offensive Forensics!
- How do you remotely apply forensics for needle in the haystack, *but* through a itty-bitty straw and hopeful no-one will noticve that you are searching for things

- What is "it" that you are looking for?
- How can we find "it"?
- Exfil "it" without being seen?
- Stay hidden?
- Achieve mission Objectives?
- Maintain Long Term Access

Threat Hunting is easier to hunt for this stage against an adversary over inital access.

Some Myths:
How good is Anti-Forensics?
- Anti Forensics is often not required - hide in plain sight
	- What does normal look like
-  Can you get in memory
- Living off the land get only "so far"
- Always depends on "true objective" in the attack.


Some of the below provide some stealth
Filesystem:
- Timestomping
- File Deletion
- File/Free Space Wiping
- Data Encryption (.rar fiels)
- Filesles  Malware (Not Artifact-less)

Registry:
- Registry Key/Value Deletion
- Registry Key/Value Wiping
- Hiding Scripts in the registry

Other:
- Event Log Deletion/Tampering
- Process Evasion
	- Rootkits
	- Code injection

Do not trigger a alert the blue team investigative "Eye of Sauron".
IoC still exist if the malware is still wiped, because it was.


Intel Gathering and Espionage Secenario - How good a APT is at this makes it very obvious who is who if they are not
- Maintain Access
- Stealth
- Find Data without detection
- Exfil large data through itty bitty straw - temporal (not directly how fast or slow more a the gaps between each time actions occur), bandwidth, etc
- Maintain Access

Submarine or Spies:
- Easy if no one sees you
Moving to Objective - 
- Sitting duck - are very noticable

TTPs be here:
![](robleesansoffensiveforensicslateralmovementoverview.png)

## Timestomping

[[Timestomping]] from a Forensics Perspective when the below highlighted:
- Is Mismatched
- Out of Order
You have malware.
![](robleesansoffensiveforensicstimestomping.png)


## Future Havok - Rob Lee 's Sleep loser:
- Maintain Access
- Stealth
- Place implant with mission to destroy/disrupt/deny/degrade
- Doesn't require "Runtime" code
- Doesn't Require Large Footprint

Threat Hunter's worst nightmare.

#### File wiping

Filenames potential stored in two places:
- File system metadata
	- MFT Entry
- Directory Data
	- Contain list of children files and directories

- Some forensics Tools ignore direectory slack entries


## So What?

- You are only as good as long as you stay hidden and maintain your mission
- What is your true mission?
- How good are you?
	- Get good a forensics! Less "Oops" more OFOPs

## References

[Rob Lee SANS PenTest HackFest 2022 - Offensive Forensics](https://www.youtube.com/watch?v=WwmcZSHw66w)
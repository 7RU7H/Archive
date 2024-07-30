

Join us for the next edition of t2 on April 18-19, 2024. Clarion Hotel Helsinki [https://t2.fi/](https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbV8wSzhYdVdSWGgyTFZTQUJTbGJkVUd2Z2RXd3xBQ3Jtc0tub2lwTWJaWGNMbVpRNUxHVXZ1QWJTMEZ1UWJJLUM0cWlQZmtrc1A3b3IwZndNTEpQcUNtSDdrcnBUSEZhNl9UbE9TV0dMLXc2TG9SU1Qwd3d1bW5xN3h3RVJsd3Q5SWlMMERJVVA2NWtObUdMU05IUQ&q=https%3A%2F%2Ft2.fi%2F&v=wT2r5VuYCU0) | Andy Jones was the CISO of Maersk during the NotPetya cyberattack in 2017. In the keynote he details the incident and its global impact.

https://www.youtube.com/watch?v=wT2r5VuYCU0

This is an awesome talk.


https://en.wikipedia.org/wiki/Maersk 
Trouble with find staff so UK hosted the IT hub, Andy was employee number 3. 
Huge company
Oil Producer
15% of world trade
Owns 75+ ports

Discusses how everyones device one by one start failing. Andy drives the 5 minutes trip back to Maidhead and 15 minutes Maersk lost everything in 60 countries. All the IT is 60 countries. In a hour they lost everything 110 countries, it was like the internet had not been invented. 
- Network was down
- 2.5 system across oil produces were down
- All headoffice phones were down

15 Billion dollar company down in 15 minutes. In the crisis room they looked out the windows and saw shoppers shopping, so it must just be Maersk. Ransomware notice (non non-encrypted drives) and nothing worked.


Maersk loves a crisis, but most ship and water related crises.

They found the  some firms were affected.

2012 EternalBlue and EternalRomance was approximately and allegedly discovered/created
Harold Martin III or Snowdon stole this code
Shadow brokers tried to sell it, but then dumped it
North Korea's made WannaCry

Ben Delpy create mimikatz in 2012, so Russian SandWorm created NotPetya with Eternalblue with mimikatz builtin to the attack chain.

Naming things is important for naming NotPetya is a terrible name. It makes legal issues surround responsibility more aggravating.

NotPetya is:
1. Quality tested code; US then North Koreans and then Russia - its good code
2. Loves flat network - SMB shares are everywhere
3. It destroys infrastructure

NotPetya does:
Dropped Files
Processes hashes and process Privilege checks
Credential theft
malware prop
- Network node enumeration
- SMB copy and remote execution
- SMBv1 exploitation via EternalBlue
UNC write malware to `admin$` on remote target
Remote execution of the malware
MBR ransomware
- Physical drive manipulation
- MFT encryption
- File encryption
System shutdown
Anti-Forensics

At the time they did not know how it works. For WannaCry Maersk patched even the ships (ships are big floating computers - Maersk are internet connected). Patching ships is hard

Multi-National systemic copy other Multi-National in terms of structures to be competitive. 95% patched is still thousands of machines unpatched... 100% patched is a big lie in Multi-National. They are very dynamic. When Andy Jones was at Unilever they opened and shut factories every two weeks. Acquisitions introduce more machines that need to asset managed Maersk has 17 pages of companies. Some of which are not directly controllable from Asset Management.

Flat Networks (used by big corporations, because they) are:
- Cheaper
- Easier to administrate
- Common

90% spent some time on a ship. It is commodity economy there is not a markup.

The Network Operations Center (NOC) was the first to go. There was no SOC at the time. Ships were on a separate network.

Sandworm Group used NotPetya through update profile for medocs Linkos group financial software, which then infects the child companies. medocs server is its own local server that sits on the network that is not in the main Data centre. Hit Maersk's Ukraine Office. 

Treasury Server exist because pragmaticism toward software that is from business partners.

**Authorial additions**: Andy Jones skims over the details of the exploit chain in AD, basically AD has a number of important network services that operate for users and for the machine and network administration. SMB is a file sharing software used in for the Public documents folder on windows or in Active Directory setup to share specific material with specific access levels. It is on most versions of Windows running by default on home/work network profiles that you will select when joining your computer to a network. This means that servers and workstations have these so therefore because AD is a network where the internal to the network you may want office A in Copehagen to read some files on Maidenhead network means it has to be routable and joined to the Active Directory Federation (think groups og groups of Offices). So worming through AD with unpatched EternalBlue machines is still sadly possible even in 2024 almost 8 years after NotPetya.

Staff were sent home
2500 systems down
50k end points down
35 Port (sea ports) terminals - 35 closed ports (the cranes were affected) 


Writing on the walls was the literal network administration had become managed by humans. 

One Dc Lagos was offline due to power outages, it was imaged and flown to the UK. **authorial opinion: utter madness - 15% of Global trade saved partly by a Downed DC in Lagos, because they had no power...** 

Hope and morale in the small victories.

Caution: Reinfection paranoid

`Ipse se nihil scire id unum sciat` - I know that I know nothing - Socrates

9 devices per seconds
7,241 ms-1 

The people aspect was a lesson in and of itself
- Some people you thought were good in a crisis weren't and those you did not were
- Many company employees (mainly non-technical) wanted and did actually help
- Some people quit from stress 

Recovery questions
- Which systems should be recovered first?
- How do you re-synch the data?
- How do you roll-out in days not months?
- Will legacy still work?
- Where is the clear restore point?
- Does anyone know what a system does? (i.e some weird old box that does something, that previously was not touched, because it works)
- What about reinfection or infected restore points?

Hygiene
- Patching
- Asset Management
- Backups

Complacency is the enemy
- Assume breach - APT has a bigger budget than you
- Do not rely on intelligence - Danish Intelligence said 2 months prior attack on Maritime sector was low.
- Do not rely experts - no useful 
- Assume Attacker is better than you always.

It's a People thing
- Its traumatic
- People are key to recovery

Technically
- Forensics can be a distraction for the recovery 
- Operating with a lot of unknowns - get comfortable 
- You may have to push technical barriers (in reference to operation efficiency)
- Decisions over your paygrade be here.
- Protect technical teams from noise

The Board are happy to sign off on Cyber Security Risks, but they still do not want them to happen.


Live by social media - Die by social media: Rumour about reinfection on Social Media made people pull plug and lot 2 days.

Big incidents like this are a **pivotal business point for Third Parties!**
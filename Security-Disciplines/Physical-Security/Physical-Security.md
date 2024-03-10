# Physical Security

## Introduction

- TOOOL, The Open Organisation Of Lockpickers at [https://toool.us/](https://toool.us/)
- [https://www.locksmiths.co.uk/locksmith-terminology-parts-of-locks/](https://www.locksmiths.co.uk/locksmith-terminology-parts-of-locks/) or the local mirror [[Locksmith-Terminology]]





## Entry Types

- Entry Typology
	- Overt - Destructive and noticeable leaving physical and sonic traces
	- Covert - Undetectable to the untrained, forensic investigation would discover traces 
		- Lock Picking damages locks to some degree regardless of technique
	- Surreptitious 	- Undetectable to trained and untrained people and would undetected in forensic investigation
#### Introductory Talks 

[YouTube - I'll Let Myself In: Tactics of Physical Pen Testers](https://www.youtube.com/watch?v=rnmcRTnTNC8): *"Many organizations are accustomed to being scared at the results of their network scans and digital penetration tests, but seldom do these tests yield outright "surprise" across an entire enterprise. Some servers are unpatched, some software is vulnerable, and networks are often not properly segmented. No huge shocks there. As head of a Physical Penetration team, however, my deliverable day tends to be quite different. With faces agog, executives routinely watch me describe (or show video) of their doors and cabinets popping open in seconds. This presentation will highlight some of the most exciting and shocking methods by which my team and I routinely let ourselves in on physical jobs."*

- Lock Picking is the 9th thing on the list to do
- Installation of Doors is very important
- Doors are legally required to open in an emergency

[Patrick McNeil - The Right Way To Do Wrong](https://www.youtube.com/watch?v=sw94smSiJBY): *"CackalackyCon1 - Patrick McNeil - The Right Way To Do Wrong: Physical security secrets of criminals and professionals alike In 1905 Harry Houdini wrote his first book entitled “The Right Way to Do Wrong” wherein he divulged the lockpicking and other trade secrets of criminals. People make assumptions about how schemes work and believe them to be complicated, yet in many cases the insider knows how simple they are. Most people assume that besides tailgating and social engineering, real break-ins (or physical security testing) are all about picking locks. However, the secret is that on physical pentests it’s typically unnecessary to do that! Some physical controls have known bypasses, and some building contractors (or even locksmiths) don't implement things correctly. Just like Houdini, I’ll be divulging the simple tricks of the trade employed by both criminals and professional physical pentesters to bypass physical controls without using lockpicks. You may be shocked and amazed by what you see, and once you leave you'll be an insider too - seeing insecurity everywhere!"*

- Schemes are something very simple and sometimes just knowing the secret
- Lockpicking is mostly unnecessary 
- Common mistakes of lock fitters and access control systems
- Not discussed:
	- Badge Cloning
	- Network Dropboxes
	- Keyloggers
	- Keyboard Emulators
	- Badge Scan Interception (BLEKey)
	- "Drop" USBs
- Bad locks are everywhere

## Terminology 

[[Locksmith-Terminology]] is a mirror referenced in the introductory section, but below are terminology to be 

- Lock Type 
	- Dead Bolt bolt protrudes into the frame of the door preventing it from opening
- Lock Anatomy
	- Actuator allows locking lugs to retract when the core is turned
	- Ball Bearings are non-shimmable elements for padlocks used to keep a shackle in place
	- Cylinder
	- Driver pin are top half of a pin stack and have Teeth (see Teeth) 
	- Key Pins are located on the bottom half of a pin stack
	- Shackle
	- Shear Line is the interface between the two pins (Key and Driver) in a pin stack
	- Spring
	- Teeth (pointy bits on the Driver Pins)
- Techniques
	- Raking 

## Padlocks

Padlocks - found: Document recycling bins, Gates, Document boxes..
	
####  Padlock Shims
	

Padlock shims - inserted between the shackle and the lock body pushes the locking lever away; reusable, may need to two on some padlocks. 
1. Put on the outside
2. Move it twisting it so that is on then on the inside to push the locking lever away

![](patrickneal-cackalackycon-padlockshims.png)

#### Lever Bypass
![](patrickneal-cackalackycon-leverbypass.png)

If the back of the lock core is missing you reach through past the pins and trip the latch directly. Patrick consider it is easier to rake a master lock open than to use dual mast lever bypass *shanks*.

#### Warded "Picks" / "Bypass Keys"
![](patrickneal-cackalackycon-wardedpicksbypasskeys.png)
Warded is in reference to *"the two piece of metal inside the lock and they fit into the notches of the key and when you turn the key there is a single lever typically inside of there that will release the shackle that lever is typically way at the top"*.

#### Actuator Bypass - American or Abus Tools

American 700 and 1100 series and Abus 72, other manufacturers and copy-cat manufacturers. 1100 and Abus 72 are lock-out tag-out locks (a locks for machinery usage-safety not security)
![](patrickneal-cackalackycon-actuatorbypasses.png)

The Actuator turns the back of the lock the key would press on this and turn it clockwise to release the shackle. Tools then attempt to jam between the Actuator and other piece of the lock to turn it. Fix: American - put a security wafer at the back of the lock. This is broken with a Peterson Wafer Breaker and hammer.


#### Comb Picks / Overlifting

Padlocks with a wide body, but small core is an indication the the lock could be Overlifted; the vulnerability is due to the pin chambers being too long.
![](patrickneal-cackalackycon-combpicks.png)
A Comb Pick need the space to push everything up out of the core.

- Very effective on Master 140

#### Sesame Locks

Lots of copy-cats of the Master 175 locks exist and very likely is also vulnerable; Sesame locks are found in a environment where it is administratively easier to distribute a combination and not a key. 
![](patrickneal-cackalackycon-sesamelocks.png)
From Max Power @dontlook talk that is not available on YouTube anymore
![](patrickneal-cackalackycon-sesamelocksTANGs.png)
The yellow circle is added by Patrick to so where the thin piece of metal where the knife is in the middle of the Actuators.
Technique:
1. Insert a hook pick over the top of a dial or a shim between the dials
2. Depress shackle
3. Push down "fingers" to lift the tang at the top of the lock, or lift from the back
4. Release shackle

#### Decoding Combo Locks

Combo Locks have wheel to dial in a combination, each wheel has a notch; the objective is to find where all the notches align and then rotate forward at the same time. Typically you can create binding tension (by pulling) and as you turn it is possible to find where the gates are.

#### Jiggler / Tryout Keys

Found on desks, cabinets, *electronic safes* and storage boxes these are usual against Wafer locks, which have multiple brass wafers sticking up out of the tang and are typically pushed all in the same direction. They stop the lock from turning by a spring underneath the nub on the wafer. The wafers are raised and lowers so they get out of there own way to allow the lock to turn.
![](patrickneal-cackalackycon-jigglerortryoutkeys.png)
Jiggler or Tryout Keys are used like a lockpick rake, with turning tension and move it in and out very quickly





## Doors

#### Hinge Removal
Hinge Removal

Security Hinges and Jamb Pins prevent some hinge removal
![](deviantollam-ilmi-talk-securityhingesandjambpins.png)



#### Door Latch Attacks 


![](patrickneal-cackalackycon-doorlatchbypassloidtools.png)

Modern Dead Latches - the latch is yellow - and goes into the strike plate and holds the door shut. Prevents you leaning on the door and popping it open. The guard bolt or dead latch plunger is the half cylinder in the front of the latch this indicates this is a dead latch. The addition to the latch is found in different locations around the latch.
![](deviantollam-ilmi-talk-deadlatches.png)
Older doors have just the latch. With modern door this latch protection is pressed back into the the strike plate:
![](deviantollam-ilmi-talk-deadlatchclosed.png)

Proper Deadlatch installation
![](patrickneal-cackalackycon-properdeadlatchinstallation.png)
But if the door is not hung properly or has the correct hardware:
![](deviantollam-ilmi-talk-deadlatchrequireproperdoorfilment.png)
Ollam mentions the modern example of how modern doors are retrofitted with card read access points and there are **a lot configurations** for this fitment hardware 
![](deviantollam-ilmi-talk-deadlatchrequireproperdoorfilmentconfigurations.png)
Protective plates are easily bypassed with Piano wire
![](patrickneal-cackalackycon-bypassingprotectiveplates.png)

#### Lever Handles

Lever style handles that are mandated by the American Disabilities Act - just wack it with a nub. Theses doors are mandate to have a low profile threshold so is vulnerable to the  `Under the door tool`
![](patrickneal-cackalackycon-leverhandleunderdoorthetoolattack.png)

#### Improperly hung doors

Shims

#### Crash Paddles

These door typically are lock from the outside, but have paddles in the event of and emergency are need to allow people to escape.
![](patrickneal-cackalackycon-crashbarsandexitpaddles.png)
These attacks usually involve pressing the paddles from the other side by jamming the tool through the gap between the door. Tools used is called a `Crash Bar Bypass`, which works on levers as well:
![](patrickneal-cackalackycon-crashbarbypass.png)
Weather Stripping is not a security device:
![](deviantollam-ilmi-talk-weatherstrippingisnotasecuritydevice.png)

Exit paddles and glass door are helpful to seeing what you are hitting:
![](deviantollam-ilmi-talk-exitpaddles.png)

#### Deadbolt with Thumb Turn

Deadbolts probably have  thumb turn on the inside for Fire Egress Laws. These are found in Retail places in America.
![](deviantollam-ilmi-talk-deadboltwiththumbturn.png)
Opens with a Thumb Turn Flipper; notable more useful in California, which has lots of frameless glass doors with gaps between the doors.
![](patrickneal-cackalackycon-lockswith-thumbturnlevers.png)

![](deviantollam-ilmi-talk-thumbturnflipper.png)
And nice picture of it in action:
![](patrickneal-cackalackycon-withthumbturnflipper.png)

#### REX Sensors

Some gases can also be sprayed through the gaps in the door to replicate smoke that will trigger the door to open. For Dust Off require **inverting** the can to boiling off R34a - [Wikipedia - 1,1,1,2-Tetrafluoroethane](https://en.wikipedia.org/wiki/1%2C1%2C1%2C2-Tetrafluoroethane) to create cold gas cloud:

Request-To-Exit (REX) Sensors (Thermal sensor) are tripped by the gas Passive Infrared 
Sensor do not differentiate between hot and cold - it is just `different equals human`. 

Patrick - 27:47
Ollam - 15:56

- Plates covering latch can still be bypassed


## References

[THM Physical Security](https://tryhackme.com/room/physicalsecurityintro)
[YouTube - I'll Let Myself In: Tactics of Physical Pen Testers](https://www.youtube.com/watch?v=rnmcRTnTNC8)
[Patrick McNeil - The Right Way To Do Wrong](https://www.youtube.com/watch?v=sw94smSiJBY)
[https://toool.us/](https://toool.us/)
[Wikipedia - 1,1,1,2-Tetrafluoroethane](https://en.wikipedia.org/wiki/1%2C1%2C1%2C2-Tetrafluoroethane) 
[https://www.locksmiths.co.uk/locksmith-terminology-parts-of-locks/](https://www.locksmiths.co.uk/locksmith-terminology-parts-of-locks/).
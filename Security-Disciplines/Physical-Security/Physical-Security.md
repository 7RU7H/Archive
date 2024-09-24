# Physical Security

## Introduction


[Wikipedia -  Lock picking](https://en.wikipedia.org/wiki/Lock_picking) refers to Lock picking as two word as: *"the practice of unlocking a [lock](https://en.wikipedia.org/wiki/Lock_(security_device) "Lock (security device)") by manipulating the components of the lock device without the original key."*

Authorial Note: a Children's Book from my childhood is now forever changed by learning about this: enjoy the Michael Rosen discuss the meta-context of Physical Security: [We're Going On a Bear Hunt](https://www.youtube.com/watch?v=Iou5LV9dRP0) , but instead of bears you and I have will catch bull of eye-rubbing levels of WTF is this world really... standard Legal Disclaimers and do not be a horrible person, help people and do not put others at risk. 

Live demonstration and historic issues with Locks and Security is best explained with this talk from [SaintCon Keynote YouTube - LockPickingLawyer](https://www.youtube.com/watch?v=IH0GXWQDk0Q) description: *"The Lock Picking Lawyer is one of the most well-known names in the world of lock picking and covert entry. He is best known for his extremely popular, eponymous YouTube channel. This channel features over 1,000 videos exposing weaknesses and defects found in locking devices so that consumers can make better security decisions. What’s less well-known is that he also works with lock manufacturers to improve their products, private companies to improve their security, tool-makers to improve their products, and government agencies. As his name suggests, the Lock Picking Lawyer was a business litigator for nearly 15 years, but recently retired from practicing law to devote all of his time to security work."*

- TOOOL, The Open Organisation Of Lock pickers at [https://toool.us/](https://toool.us/)
- [https://www.locksmiths.co.uk/locksmith-terminology-parts-of-locks/](https://www.locksmiths.co.uk/locksmith-terminology-parts-of-locks/) or the local mirror [[Locksmith-Terminology]]
- YouTube (in no particular order)
	- [lockpickinglawyer](https://www.youtube.com/@lockpickinglawyer)
	- [bosnianbill](https://www.youtube.com/@bosnianbill)
	- [DeviantOllam](https://www.youtube.com/@DeviantOllam)
	- [RoonPicker](https://www.youtube.com/@RoonPicker)

PDF: [BlackHat - Ten Things Everyone Should Know About Lockpicking & Physical Security by Deviant Ollam](https://www.blackhat.com/presentations/bh-europe-08/Deviant_Ollam/Whitepaper/bh-eu-08-deviant_ollam-WP.pdf) - List, but read and watch
1. Locks are not complicated mechanisms
2. Most locks are wildly easy to pick
3. Unpickable doesn’t mean invulnerable
4. Minor (component) changes make a big difference
5. Advanced features aren’t a panacea
6. Adding electricity isn’t magical
7. Safe locks vary as widely as door locks
8. Bump keying is a real problem, but one with real solutions
9. Large facilities have their own unique concerns
10. Security in the Real World (is mostly threaten by brute force not finesse tactics)
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
- Under the Door, Over the Door and through the door and around the door
- OH GOD THE KEYS ARE THE SAME KEY!

Ollam's EDC Keyring of Doom:
![](deviantollam-ilmi-talk-everydaycarrykeys.png)

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
	- Pin chamber are chambers drill through Shell and Plug and where the pin is located
	- Plug is where the key goes
	- Security Driver Pins
		- Serrated will give several clicks as it is being picked
		- Mushroom 
		- Spool
	- Shackle
	- Shear Line is the interface between the two pins (Key and Driver) in a pin stack
	- Shell is the main body of the lock that the plug sits
	- Spring prevents Driver and Key pins from rattling around
	- Teeth (pointy bits on the Driver Pins)
- Techniques
	- Bumping - a bypass method uses a key cut to the lowest depths and kinetic energy to bounce the driver pins above the shear line and allow a lock to be opened
	- Decoding - testing the combination through tension and feel rather than brute forcing combinations
	- False set is if a pin appears to be set but it doesn't rattle - [lockpickshop](https://www.lockpickshop.com/Lockpicking-Guide/lock-picking_ch8.htm)
	- Raking
	- Rapping - opening Locks with spring loaded locking lugs by tapping a hammer on the side of the lock
	- Single Pin Picking (SPP) is picking a lock one pin at a time
- Lock Picking Tools
	- Pin Tumbler Tools:
		- Ball Pick
		- Bump Keys
		- Decoder Pick
		- Half-Diamond Pick
		- Hook Pick is a hook shaped pick for SPP
		- Rake Pick - for Raking
		- Skeleton keys or ([Wikipedia -  Lock picking](https://en.wikipedia.org/wiki/Lock_picking)): *"The warded pick, also known as a [skeleton key](https://en.wikipedia.org/wiki/Skeleton_key "Skeleton key"), is used for opening [warded locks](https://en.wikipedia.org/wiki/Warded_lock "Warded lock")*".
		- Tension Wrench is used to apply torque to core of a lock when picking
	- Wafer tumbler Tools
		- Jigglers or Try-out keys
		- Pick guns
		- Tubular lock pick
	 - Tubular Locks
		 - Tubular pick, is called a pick but it is an impressioning device
	- Padlocks Bypass Tools:
		- Jiggler - wiggled inside the keyway of wafer locks to roughly simulate the biting of the key and open the lock.
		- Knife - for an unshielded padlock
		- Mini knife for Masterlock 175
		- Shim - for Padlocks with spring loaded locking lugs rather than ball bearings - inserted into the gaps between the casing and the lugs turned facing inside lugs to open the padlock 
	- Hardware Bypass Tools:
		- Over the Door - 33mm Film
		- Under the Door Tool (UDT)
		- Double Door Tool - for double doors with crash bar on the secure side
		- Crashbar bypass
		- Thumbturn
		- Air Wedge - Pump with a bag attached - insert empty bag into gaps between doors and door frames or between double doors - also common automobile entry - and pump up the bag!
		- Shim - for improperly hung doors
		- Traveller Hook - Latch slipping and improperly hung doors
		- Latch loid
		- Plastic Sheets
		- Lever Bypass or "shiv"
		- Canned Air
	- Alarm bypass and Magnetic utility 
		- Strong Rare Earth Magnet
		- Magnetic pole detector - check if the door is alarmed
	- Duct or Clear Packing Tape
	- Dress for success
	- GOJFC - Authorised to Test Card
#### Tooling

[[Pretext]] is very important, know yourself and know other biases and desire to help - from [Patrick McNeil - The Right Way To Do Wrong](https://www.youtube.com/watch?v=sw94smSiJBY)
![](patrickneal-cackalackycon-blackbagthatisnothavingtobeblack.png)



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
![](patrickneal-cackalackycon-rexsensorbypass.png)
Patrick has also seen:
- Helium Balloons 
- Disposable hand warmers on a wire
- Vape smoke
- Ollam's Whiskey 

#### Adams Rite Bypass Tool

Commonly found on commercial storefront doors in USA
It employs a [Mortise Cylinder](https://www.adamsrite.com/en/products/accessories/4036-mortise-cylinder-4066-thumbturn) that *provides five-pin security with most Adams Rite deadlocks or deadlatches.* Typically these mortise cylinders are open at the back and so if there is a opening you can reach through into the back with bypass tool that is angled to hit the latch release lever.
![](patrickneal-cackalackycon-adamritebypasstool.png)
[Bosian Bill's YouTube Video on Adams Rite Bypass](https://www.youtube.com/watch?v=vXrlZJKpK0o)

This can be prevented with shielding.

#### Kaba Simplex 

Patrick referencing [Bosian Bill's YouTube Video: Kaba Simplex Door Combination Lock Defeated w/Sparrows "MAGNETO"](https://www.youtube.com/watch?v=2KSoPIeN9wY), there is also  the [LockPickingLawyer](https://www.youtube.com/watch?v=cCay5ek_cW0) Video on picking it too. Picture below demonstrates the use of a magnet to pulls the flag to unlock it... 
![](patrickneal-cackalackycon-magnets-andkabasimplex.png)
Put magnet into a sock to prevent the magnet getting stuck to the door. These also have a manufacturer default password:
1. 2 + 4 simultaneously
2. then depress 3 
3. then feel for the click as each button is depressed

#### Key Lock Boxes

Key Boxes are for different contractors to enter building 
![](deviantollam-ilmi-talk-keyboxes.png)


Key Lockbox combo decoding utilises a small piece of feeler gauge to decode the combination. The feeler gauge is placed between the dials, which then slowly rotated and  the feeler gauge will drop and this will indicate the notch. Repeat for each dial, then rotate all wheels one increment at a time until you find the gate and it opens up. [DeviantOllam - Decoding Multi-Wheel Locks with a Mini Knife](https://www.youtube.com/watch?v=8NqyjrMYZXo)
![](patrickneal-cackalackycon-keylockboxes.png)



For boxes with buttons - `jamming` buttons technique :
![](patrickneal-cackalackycon-keylockboxesbuttons.png)

Anti Jamming Boxes like the below - David S from Oak City Locksport 0-day (at video release):
1. Tension wrench
2. and then start jamming (feedback is more nuanced)
![](patrickneal-cackalackycon-antijamming-with-tension-wrench-andjamming.png)


#### Tubular Locks 

[Wikipedia](https://en.wikipedia.org/wiki/Tubular_pin_tumbler_lock) states that *"a **tubular pin tumbler lock**, also known as a **circle pin tumbler lock**, **radial lock**, or the trademark **Ace lock** popularized by manufacturer [Chicago Lock Company](https://en.wikipedia.org/wiki/Chicago_Lock_Company "Chicago Lock Company") since 1933, is a variety of [pin tumbler lock](https://en.wikipedia.org/wiki/Pin_tumbler_lock "Pin tumbler lock") in which a number of pins are arranged in a circular pattern, and the corresponding key is tubular or cylindrical in shape. Most locks use between six and eight pins, although some use as few as four or as many as ten. The devices have been widely used on [vending machines](https://en.wikipedia.org/wiki/Vending_machines "Vending machines"), [elevators](https://en.wikipedia.org/wiki/Elevator "Elevator"), [public computers](https://en.wikipedia.org/wiki/Public_computers "Public computers"), and [bicycle locks](https://en.wikipedia.org/wiki/Bicycle_lock "Bicycle lock")."* But also backups for electronic safes, computer security cables, storage boxes mounted above the door/
![](patrickneal-cackalackycon-tubularlocks.png)
Round key fits into it pushes in the pins to the depths based on the cuts in the key and you hit the sheer line and it allows you to turn. To *"pick"* you use a Tubular pick, but it is an impressioning device:
- Put it into the lock
- Tension on the outside
- Rotate the tubular pick back and forth
- Based on the press of the spring come back at the tubular pick it pushes the pins up and you form a key 

#### Knox

Medeco-Biaxial lock that is very difficult to pick [YouTube video of RoonPicker picking a Medeco-Biaxial lock](https://www.youtube.com/watch?v=tkPxxbYTAOg). When fitted they are sent with a key that only Knox has access to, not available to Lock Smiths you have to order it from Knox. Each Key is numbered and tracked by Knox, these keys are for Law Enforcement and Fire Department to get into a building. There one master key per municipality area - this is bad if it is stolen as the thief would have access to buildings in that area. 

#### Common Keys

Manufacturers will use the same lock and therefore the keys are not unique among manufacturers. [Howard Payne & Deviant Ollam - This Key is Your Key, This Key is My Key](https://www.youtube.com/watch?v=a9b9IYqsb_U) (amazing talk name referencing [Woody Guthrie - This Land Is Your Land](https://www.youtube.com/watch?v=wxiMrvDbq3s))
![](patrickneal-cackalackycon-keychainofdoom.png)
and Elevator locks:
![](patrickneal-cackalackycon-keychainofdoompart2.png)
Elevator Supervisory Keys - more stealth than Fire Emergency keys:
![](patrickneal-cackalackycon-keychainofdoom-elevatorsupervisorykey.png)

Access Control Boxes unfortunately use common keys
![](patrickneal-cackalackycon-keychainofdoom-telephony-access-control-boxes.png)
On the Doorking boxes they have a momentary switch so carry wire to short the circuit of the terminal. The Linear shown above has a tamper switch use a magnet up against side of the box to bypass the tamper switch which is just a read switch. The Linear Pro Access was discuss in the [DEF CON 23 - Dennis Maldonado - Are We Really Safe? - Bypassing Access Control Systems](https://www.youtube.com/watch?v=-cZ7eDV2n5Y) talk.

Deviant Ollam and wife demonstrating system that requires a fob to open, but deviant has the common key and can flip the relay inside the box:
![](deviantollam-ilmi-talk-key-alike.png)
The Door King has been the same shape since 1992; Everything Door King uses the same key.
![](deviantollam-ilmi-talk-doorkingkey16120.png)

Door King also has Electronic components on some systems, opened with a common key...
![](deviantollam-ilmi-talk-doorkingboxinternals.png)
Both manual below display similar schematics for the terminal electronics (but are not the same as the [YouTube - I'll Let Myself In: Tactics of Physical Pen Testers](https://www.youtube.com/watch?v=rnmcRTnTNC8)), but do show which Dry Contacts (see [Wikipedia - Dry contacts (No Current definition probably, because I am no expert in electronics and just noted that here just to ensure universal scepticism to what I put here and may be read by others)](https://en.wikipedia.org/wiki/Dry_contact) *A dry contact is the synonym of volt free — it is not "wetted" by a voltage source. Dry contact can refer to a secondary set of contacts of a relay circuit which does not make or break the primary current being controlled by the relay. U*)  of the Terminal are the relays for the door:
- https://www.doorking.com/sites/default/files/downloads/1812-065-M-3-07.pdf
- https://doorking.com/sites/default/files/downloads/1835-065-D-5-17.pdf

You can just bridge the circuit, you could also bridge Relay 2s to open that door too..
![](deviantollam-ilmi-talk-bridgingcircuits.png)

If by the electronics it indicates (yellow arrows) that it there is one common and one normally open that means it is a Solonoid Powered Door Locks meaning there normally no power required, but by bridging relays with wire the door will suddenly open.
![](deviantollam-ilmi-talk-solonoidpowereddoorlock.png)

Similarly to Ollam talk the https://doorking.com/sites/default/files/downloads/1835-065-D-5-17.pdf shows `PSW` 
![](deviantollam-ilmi-talk-pswtoo.png)

If these are wired up:
![](deviantollam-ilmi-talk-pswwiredup.png)
In this example the Postal Switch is just a momentary
![](deviantollam-ilmi-talk-postalswitchisamomentary.png)
These knockout can be banged out a replaced with a lock, the tail piece:
![](deviantollam-ilmi-talk-tailpieceofamomentary.png)
...will swing around a press the momentary switch (the button looking thing above)

CH751 keys is very common place
![](deviantollam-ilmi-talk-CH751key.png)

1284X key is Ford motor company Crown Key - meaning every American Police Cruisers use this key and then when those Queen Vic cruiser are End of Life with Law enforcement they become... Taxis. When I heard this for the second-to-third time it I still needed a minute to recover.

FEO-K1 Elevator Key
C415A and CH751 - Filing cabinet keys
16120 - Door King Key
222343 (A126) - Linear Boxes key
Cuff Key

Wire Bridge (paper clips with insulation burnt off the tips)
#### Lever Style Door Handles

Door knobs are less prevalent and have mostly been replaced by Lever Style Door Handles to ensure that those with reduced grip and tactile function can open doors. Under the Door Tools are used to attack these as they can be opened from the inside.
![](deviantollam-ilmi-talk-leverstyledoorhandles.png)
And a picture from the other side of the door:
![](deviantollam-ilmi-talk-underdoorattacks.png)
Only very secure facilities require badging out of a room as well as in. 

Migitation against Under the Door Attack: Dynamic Door Bottoms
![](deviantollam-ilmi-talk-underthedoorprevention.png)

But Over to Door attack with 35mm Film to open the door from the inside
[LockPickingLawyer - Opening a Locked Door With Movie Film (With Deviant Ollam)](https://www.youtube.com/watch?v=byYGPO4ptxs)
![](lockpickinglawyeranddevollamopendoorswithfilmfromtheotherside.png)
Shrouds around the handles should be considered to prevent Over the Door attacks
![](deviantollam-ilmi-talk-shroudtopreventoverthedoorattacks.png)
These are found in [Grainger Catalogues](https://en.wikipedia.org/wiki/W._W._Grainger) (American industrial supply chain company buildings) are used to prevent carts from crashing into doors

Hotels also mount these door handles down:
![](deviantollam-ilmi-talk-hotelsmountingdoorhandlesdown.png)
Hotel Doors with clips - these are the feet you put on slidey door closits 
![](deviantollam-ilmi-talk-hoteldoorswithclips.png)

#### Electronic Credentials

Card Cloning

Credential Sniffing

Babak's long range reader 
![](deviantollam-ilmi-talk-Babaklongrangereader.png)

Credential grabbing with the device above inside the pack to the individuals left:
![](deviantollam-ilmi-talk-credentialgrabbingbyproximity.png)

If you can get the read off the wall you can install a sniffer on the backside of the reader:
![](deviantollam-ilmi-talk-snifferonrfid.png)

#### Alternative Key Copying

[WildWest Hacking Fest: Copying Keys from Photos, Molds & More](https://www.youtube.com/watch?v=AayXf5aRFTI) by DeviantOllan: *"Most folk are aware that it's not a good idea to hand a stranger your keys... some very security-conscious folk are even wary of letting potential attackers SEE your keys. The risks of casting, molding, teleduplication, and quick decoding are real and such caution is merited. However, how many of you have ever actually /performed/ an attack like this yourself? Have you ever witnessed it live and in person?"*

#### Weird Ways and [[Social-Engineering]]

- Steal keys
[Wikipedia -Dry contacts (No Current definition probably)](https://en.wikipedia.org/wiki/Dry_contact) 

- Look like you belong and do what those belong there do

- Pretext/ Cover Stories:
	- Elevator Repair from: [YouTube - I'll Let Myself In: Tactics of Physical Pen Testers](https://www.youtube.com/watch?v=rnmcRTnTNC8)
		- Dress for success, have a clip board (get a metal one that you can hide food, tools, etc inside) and badge
		- Be in an elevator
		- Press E button to communicate:
			- "This is a test of the emergency phone in this elevator"
			- "Can you hear me clearly right now?"
			- "Can you tell me where I am calling from?"
		- Depending on the building this will be automated or go to some human at a desk:
			- [[Social-Engineering]] the individual on the desk to panic about not know where the call is coming from will override the concerns about not being informed as to elevator testing being scheduled



## References

[THM Physical Security](https://tryhackme.com/room/physicalsecurityintro)
[YouTube - I'll Let Myself In: Tactics of Physical Pen Testers](https://www.youtube.com/watch?v=rnmcRTnTNC8)
[Patrick McNeil - The Right Way To Do Wrong](https://www.youtube.com/watch?v=sw94smSiJBY)
[https://toool.us/](https://toool.us/)
[Wikipedia - 1,1,1,2-Tetrafluoroethane](https://en.wikipedia.org/wiki/1%2C1%2C1%2C2-Tetrafluoroethane) 
[https://www.locksmiths.co.uk/locksmith-terminology-parts-of-locks/](https://www.locksmiths.co.uk/locksmith-terminology-parts-of-locks/).
[Wikipedia -  Lock picking](https://en.wikipedia.org/wiki/Lock_picking)
[Bosian Bill's YouTube Video on Adams Rite Bypass](https://www.youtube.com/watch?v=vXrlZJKpK0o)
[www.adamsrite.com Mortise Cylinder](https://www.adamsrite.com/en/products/accessories/4036-mortise-cylinder-4066-thumbturn) 
[Bosian Bill's YouTube Video: Kaba Simplex Door Combination Lock Defeated w/Sparrows "MAGNETO"](https://www.youtube.com/watch?v=2KSoPIeN9wY)
[LockPickingLawyer - Kaba Simplex Series 1000](https://www.youtube.com/watch?v=cCay5ek_cW0)
[DeviantOllam - Decoding Multi-Wheel Locks with a Mini Knife](https://www.youtube.com/watch?v=8NqyjrMYZXo)
[Wikipedia - Tubular pin tumbler lock](https://en.wikipedia.org/wiki/Tubular_pin_tumbler_lock) 
[YouTube video of RoonPicker picking a Medeco-Biaxial lock](https://www.youtube.com/watch?v=tkPxxbYTAOg)
[DEF CON 23 - Dennis Maldonado - Are We Really Safe? - Bypassing Access Control Systems](https://www.youtube.com/watch?v=-cZ7eDV2n5Y)
[Lockpickworld](https://www.lockpickworld.com/pages/how-to-pick-locks)
[lockpickshop](https://www.lockpickshop.com/Lockpicking-Guide/lock-picking_ch8.htm)
[BlackHat - Ten Things Everyone Should Know About Lockpicking & Physical Security by Deviant Ollam](https://www.blackhat.com/presentations/bh-europe-08/Deviant_Ollam/Whitepaper/bh-eu-08-deviant_ollam-WP.pdf)
[LockPickingLawyer - Opening a Locked Door With Movie Film (With Deviant Ollam)](https://www.youtube.com/watch?v=byYGPO4ptxs)
[Wikipedia - W.W.Grainger ](https://en.wikipedia.org/wiki/W._W._Grainger)
[Wikipedia -Dry contacts (No Current definition probably)](https://en.wikipedia.org/wiki/Dry_contact) 
[thecoregroup](https://thecoregroup.net/)
[SaintCon Keynote YouTube - LockPickingLawyer](https://www.youtube.com/watch?v=IH0GXWQDk0Q) 
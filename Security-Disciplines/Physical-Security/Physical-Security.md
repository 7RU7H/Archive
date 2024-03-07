# Physical Security


- Entry Typology
	- Overt - Destructive and noticeable leaving physical and sonic traces
	- Covert - Undetectable to the untrained, forensic investigation would discover traces 
		- Lock Picking damages locks to some degree regardless of technique
	- Surreptitious 	- Undetectable to trained and untrained people and would undetected in forensic investigation
#### Introductory Talks

[YouTube - I'll Let Myself In: Tactics of Physical Pen Testers](https://www.youtube.com/watch?v=rnmcRTnTNC8): *Many organizations are accustomed to being scared at the results of their network scans and digital penetration tests, but seldom do these tests yield outright "surprise" across an entire enterprise. Some servers are unpatched, some software is vulnerable, and networks are often not properly segmented. No huge shocks there. As head of a Physical Penetration team, however, my deliverable day tends to be quite different. With faces agog, executives routinely watch me describe (or show video) of their doors and cabinets popping open in seconds. This presentation will highlight some of the most exciting and shocking methods by which my team and I routinely let ourselves in on physical jobs.*

- Lock Picking is the 9th thing on the list to do
- Installation of Doors is very important
- Doors are legally required to open in an emergency

## Techniques
#### Hinge Removal
Hinge Removal
![](deviantollam-ilmi-talk-hingeremoval.png)

Security Hinges and Jamb Pins prevent some hinge removal
![](deviantollam-ilmi-talk-securityhingesandjambpins.png)



#### Door Latch Attacks 
		
Modern Dead Latches - the latch is yellow - and goes into the strike plate and holds the door shut. Prevents you leaning on the door and popping it open. The guard bolt or dead latch plunger is the half cylinder in the front of the latch this indicates this is a dead latch. The addition to the latch is found in different locations around the latch.
![](deviantollam-ilmi-talk-deadlatches.png)
Older doors have just the latch. With modern door this latch protection is pressed back into the the strike plate:
![](deviantollam-ilmi-talk-deadlatchclosed.png)
But if the door is not hung properly or has the correct hardware:
![](deviantollam-ilmi-talk-deadlatchrequireproperdoorfilment.png)
Ollam mentions the modern example of how modern doors are retrofitted with card read access points and there are **a lot configurations** for this fitment hardware 
![](deviantollam-ilmi-talk-deadlatchrequireproperdoorfilmentconfigurations.png)

#### Crash Paddles

These attacks usually involve pressing the paddles from the other side by jamming the tool through the gap between the door 

Weather Stripping is not a security device:
![](deviantollam-ilmi-talk-weatherstrippingisnotasecuritydevice.png)

Exit paddles and glass door are helpful to seeing what you are hitting:
![](deviantollam-ilmi-talk-exitpaddles.png)

#### Deadbolt with Thumb Turn

Deadbolts probably have  thumb turn on the inside for Fire Egress Laws
![](deviantollam-ilmi-talk-deadboltwiththumbturn.png)
Opens with a Thumb Turn Flipper; notable more useful in California, which has lots of frameless glass doors with gaps between the doors.
![](deviantollam-ilmi-talk-thumbturnflipper.png)

Some gases can also be sprayed through the gaps in the door to replicate smoke that will trigger the door to open. For Dust Off require **inverting** the can to boiling off R34a - [Wikipedia - 1,1,1,2-Tetrafluoroethane](https://en.wikipedia.org/wiki/1%2C1%2C1%2C2-Tetrafluoroethane) to create cold gas cloud:
![](deviantollam-ilmi-talk-dooredgegaps.png)
Request-To-Exit (REX) Sensors (Thermal sensor) are tripped by the gas Passive Infrared Sensor do not differentiate between hot and cold - it is just `different equals human`. 

15:56

- Plates covering latch can still be bypassed


## References

[THM Physical Security](https://tryhackme.com/room/physicalsecurityintro)
[YouTube - I'll Let Myself In: Tactics of Physical Pen Testers](https://www.youtube.com/watch?v=rnmcRTnTNC8)
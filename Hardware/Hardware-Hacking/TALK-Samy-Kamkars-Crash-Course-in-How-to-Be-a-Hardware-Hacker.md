# Samy Kamkar's Crash Course in How to Be a Hardware Hacker

[YouTube - Samy Kamkar's Crash Course in How to Be a Hardware Hacker](https://www.youtube.com/watch?v=tlwXmNnXeSY) description: *"Samy Kamkar is well known for many things, but lately it has been his hardware security hacks that have been turning heads. The nice thing to know is that, despite not having a background in hardware, Samy is able to run with the best of hardware researchers. At the Hackaday SuperConference he offered words of advice for anyone trying to walk the path of discovery with an exciting new piece of electronics. One might say it's a crash-course in how to be a hardware hacker."*

Step One: Research
- Google
- Have Hardware? Tear it down!
- Prior Art - has someone else research
- Patents on any of the systems involved?
- If RF TX, lookup the FCC ID
- If RF or Networking or WIFI or USB, sniff it
- If circuit available (of in FCC docs), understand it
- If ICs on board, determine what they are and read datasheets

Samy discusses Credit Card cloning using the some of the above to figure to:
- Observed pattern of card numbers
- Questioned whether it was magnetic 
- Used Iron Oxide to read the magnetic stripe on the card to reveal the encoding mechanism that also encodes whether the card has a chip
- Makes an magnetic coil with magnetic wire and controller that powers the coil on and off to "play whatever you want"


Car Garage Clicker OpenSesame
- Uses radio frequency and anything that transmit has an FCC ID
- Find the Frequency used on documentation and publicly available testing reports 
- RTL SDR to record to transmission from the Garage clicker
- Use Audacity to view the .wav file (transmission is bits (up and down)), clone the transmission - FIX https://en.wikipedia.org/wiki/Sine_wave
- Brute Force codes (remember to optimise)
	- Does the device need the entire transmission?
	- Optimise with a De Bruijn Sequence?


Step Two: Test or Apply
- Use existing tools available to test assumptions
- What inputs produce the output you would like?
- What are all of the inputs?
- What tools allow you to modify those inputs?
- What tools have the speed, memory,, and outputs you require?
- Do not worry about final implementation, just develop and understand attack requirements

No `Mettel IM ME` no problem; Tool implementation (DIY):
- SDR (HackRF, BladeRF, etc) requires a powerful computer
- Common MCU (Arduino, Teensy, 8051, etc)
- RF Transmitter or SoC (CC11xx Si\[14\]0xx, OL23xx, HopeRF 6\[78\]W, CMT211XAW)
- [[Search-Engine-Dorking]] "RF transmitter 315MHz"

Use the basic stuff and do not be afraid and treat it like you would software, if you are software person.

Key Fobs and Rolling Codes
- Whats inside?
- Chip with no markings?
	- Logic Analyzer
	- SMD Micro Probes
	- Multi-meter to measure voltage
- Map out chip's pin
	- What are ground, voltage, etc
- Locate datasheets of chip
	- 2.4GHz transceivers with FHSS
- Compare Pinouts
- Use Datasheet and Logic Analyzer
- Extract Serial Communication:
	- Monitor SPI/I2C/UART/etc
	- Detect frequency timing for FHSS
	- Detect frequency hopping pattern
	- Detect modulation
	- Detect baudrate
	- Determine data transmitted vs data inputted
	- ...
	- Profit
- Extract Firmware
	- Find Test Paths used for programming device
	- Connect to Test Paths instead
- Reflash Firmware with your code
- Build a Interception Device

Rolling Codes - Continuous rotating codes:
- PRNG in key and car
- Synced seed and counter
- Hit button, key sends code
- Hit button again, key sends next code
- If Eve replays the code, car rejects it's because already used
- Should be difficult to predict
- Prevents replay attacks

Replaying the Rolling Code!
- Capture signal remote out of range from vehicle or garage
- Replay later
- This is lame since have to have access to the key and it has to far from the car

Instead Jam!
- Jam at slightly deviated frequency (steal multiple times for multiple codes)
- Listen and Replay
	- Receive at frequency with tight receive filter bandwidth to evade jamming
	- User presses key but car can't read signal due to jamming
	- Once we have the code, we stop jamming and can replay
	- But... once user does get a keypress in, new code invalidates our code

Protocols, Recon and Protocol Abuse :
- Record
- Observe in Audacity

Step Three: Implement
- What are the attack requirements?
- Pre-existing implementations available?
- Simplest requirements to implement the attack?
- Minimum speed
- Minimum memory
- Minimum power (RF? Battery? Time it needs to run?)
- Minimum size?

Kamkar's Favourites:
![](kamkars-fav-diy-hwh-basics-tools.png)

Code on his [GitHub Samyk](https://github.com/samyk)


## References

[YouTube - Samy Kamkar's Crash Course in How to Be a Hardware Hacker](https://www.youtube.com/watch?v=tlwXmNnXeSY)
[GitHub Samyk](https://github.com/samyk)
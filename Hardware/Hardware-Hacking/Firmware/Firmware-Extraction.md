# Firmware Extraction

[DEF CON 24 - Hardware Hacking Village - Matt DuHarte - Basic Firmware Extraction](https://www.youtube.com/watch?v=Kxvpbu9STU4)


What you need as a beginner:
- Screwdriver
- Magnifying glass
- Shikra / Bus Pirate (recommendation are from 2016)
- Microscope with Trinocular for pictures - good for reporting and legal issues


1. OSINT the product and collection the manuals
2. Vulnerability Analysis
	1. How hard is it to open
3.  What is the OS of the device
4. Label the chips 
5. Dork the previously acquired information
	 - If it is a 
		 - PCB like a Bus pirate or Shikra - cheap
		 - laptop BIOS Data Prog - expensive
6. Find the flash memory - branching depending on objectives
	- Some devices do not have serial ports you can attach to and get root
	- [[Rootkits]] exist 
		- If you are doing [[Digital-Forensics]] the turning it on and extracting it when running is different - consider a Faraday cage
		- We only want the Firmware that get booted to read or to write our own firmware to a device
7. Connect to chip, use correct protocol (Either individual wire - tricky or correct clip (beware legal requirements for using the proprietor clips)) or heat gun of the chip and put in PCB that can read the chip (these will be able to read variants of the same chip there are lots))
	- [[JTAG]] - Pass-through mode except in one chain (step through to decide which you want to talk to)
		- Up to 5 signals are used
			- TDI (Test Data In)
			- TDO (Test Data Out)
			- TCK (Test Clock)
			- TMS (Test Mode Select)
			- TRST (Test Reset)
		- There is a lot you can achieve with this protocol 
		- Used on devices that require debug interface
	- [[I2C]] - Everything has an address
		- Requires 2 wires
			- Serial Data Line (SDA)
			- Serial Clock Line (SLL)
		- Generally runs on 3.3 or 5v 
		- Use is slow applications
			- But does have a 3.4 Mbit high speed mode - check you Bus Pirate / Shikra
	- [[SPI]] - Everything is Enable / Disable
		- The wires you care about are:
			- SCLK - Serial Clock
			- MOSI - Master Output, Slave input
			- MISO - Master Input, Slave output
			- SS - Select active chip slave
8. With Bus Pirate plug in to USB 
9. Use  mimicon/screen to get CLI
10. Dump or Write new firmware to flash :)


- If your problem is unlabelled connector on board
	- JTAGulator 
- If your problem is W/R of chips
	- Dataprog
- If your problem is want to learn more protocols - use a USB logic Analyser 
	- with protocol dissectors
- If your problem is you need to debug and access firmware
	- [[JTAG]] is the interface of choice
	- Every vendor has non-version of [[JTAG]] adaptor and slightly differ

Comments are then made regarding [[Backdoors]] firmware, firmware extraction in spoilage 
## References

[DEF CON 24 - Hardware Hacking Village - Matt DuHarte - Basic Firmware Extraction](https://www.youtube.com/watch?v=Kxvpbu9STU4)
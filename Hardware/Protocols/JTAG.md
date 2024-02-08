# JTAG

[Wikipedia - JTAG](https://en.wikipedia.org/wiki/JTAG) (named after the Joint Test Action Group which codified it) is an [industry standard](https://en.wikipedia.org/wiki/Technical_standard "Technical standard") for verifying designs and testing [printed circuit boards](https://en.wikipedia.org/wiki/Printed_circuit_board "Printed circuit board") after manufacture.

Regarding [[Firmware-Extraction]] -  Pass-through mode except in one chain (step through to decide which you want to talk to) from [DEF CON 24 - Hardware Hacking Village - Matt DuHarte - Basic Firmware Extraction](https://www.youtube.com/watch?v=Kxvpbu9STU4)
- Up to 5 signals are used
	- TDI (Test Data In)
	-  TDO (Test Data Out)
	- TCK (Test Clock)
	- TMS (Test Mode Select)
	-  TRST (Test Reset)
		- There is a lot you can achieve with this protocol 
		- Used on devices that require debug interface

## References

[DEF CON 24 - Hardware Hacking Village - Matt DuHarte - Basic Firmware Extraction](https://www.youtube.com/watch?v=Kxvpbu9STU4)
[Wikipedia - JTAG](https://en.wikipedia.org/wiki/JTAG) 
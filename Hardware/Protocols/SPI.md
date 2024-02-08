# SPI 

[Wikipedia - Serial Peripheral Interface (SPI)](https://en.wikipedia.org/wiki/Serial_Peripheral_Interface) : *is a [de facto standard](https://en.wikipedia.org/wiki/De_facto_standard "De facto standard") (with many [variants](https://en.wikipedia.org/wiki/Serial_Peripheral_Interface#Standards)) for [synchronous](https://en.wikipedia.org/wiki/Comparison_of_synchronous_and_asynchronous_signalling "Comparison of synchronous and asynchronous signalling") [serial communication](https://en.wikipedia.org/wiki/Serial_communication "Serial communication"), used primarily in [embedded systems](https://en.wikipedia.org/wiki/Embedded_systems "Embedded systems") for short-distance [wired communication](https://en.wikipedia.org/wiki/Wired_communication "Wired communication") between [integrated circuits](https://en.wikipedia.org/wiki/Integrated_circuits "Integrated circuits").*

Serial Peripheral Interface (SPI) communication protocol is mainly used for communication between microprocessors and small peripherals such as a sensor or an SD card. SPI uses a separate clock wire.

Master-Slave Architecture:
- Main
- Sub

![](SPI-protocol)

The wires you care about are:
SCLK - Serial Clock
MOSI - Master Output, Slave input
MISO - Master Input, Slave output
SS - Select active chip slave

- Clock - SCK makes the communication more reliable and faster at the expense of an additional wire.

With a clock, one of the devices is labelled the controller - only device that is allowed to send clock signals

- Peripheral-In Controller-Out (PICO) - communication is sent from the controller,
- Peripheral-Out Controller-In (POCI) - communication is sent from the secondary device back to the controller.I2C-protocol

![](SPI-PICO-POCI-communication)

This can stack to many Peripherals, but only one Controller and they all use the same SCK, PICO and POCI  line


## References

[Day 19 of AoC4 THM](https://tryhackme.com/room/adventofcyber4)
[Wikipedia - Serial Peripheral Interface (SPI)](https://en.wikipedia.org/wiki/Serial_Peripheral_Interface) 
[DEF CON 24 - Hardware Hacking Village - Matt DuHarte - Basic Firmware Extraction](https://www.youtube.com/watch?v=Kxvpbu9STU4)
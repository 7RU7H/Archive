#  Hardware Protocol

The essentially commutation over a wire is commonly created by the device turning the a signal On and Off, Ones and Zeros - each a bit and sequecial a sequence of eight bits can be considered a byte. In [[Hardware-Hacking]] - Logic Analysers are device can analyse the signals between devices communicating and visualsie thise communication.


## Hardware Protocols

#### USART

Universal Synchronous/Asynchronous Receiver-Transmitter (USART) communication, or as it is better known, serial communication, is a protocol that uses two wires.

![](USART-protocol)

One wire is used to transmit (TX) data from device A to device B, and the other wire is used to receive (RX) data on device A from device B. There is no clock line and the device must agree to the configuration of communication:
- Communication speed - baud rate or bit rate, devices can choose depending on compatibilty between devices
- Bits per transmission - normally set to 8 bits 
- Stop and Start bits -  no clock, therefore defining beginning and ending bits any further communication between both devices must be defined    
- Parity bits - Errors can occur, parity bits are used to detect and correct errors in transmission

Some USART connections will use two additional lines:
- Clear To Send (CTS)
- Request to Send (RTS)
These are to communicate to the other device whether it is ready to receive or to transmit. Furthermore, to agree upon what voltage level is a binary 1 or 0, a third wire called the Ground (GND) wire is required to allow the devices to have the same voltage reference.

#### SPI 

Serial Peripheral Interface (SPI) communication protocol is mainly used for communication between microprocessors and small peripherals such as a sensor or an SD card. SPI uses a seperate clock wire.

![](SPI-protocol)

- Clock - SCK makes the communication more reliable and faster at the expense of an additional wire.

With a clock, one of the devices is labelled the controller - only device that is allowed to send clock signals

- Peripheral-In Controller-Out (PICO) - communication is sent from the controller,
- Peripheral-Out Controller-In (POCI) - communication is sent from the secondary device back to the controller.I2C-protocol

![](SPI-PICO-POCI-communication)

This can stack to many Peripherals, but only one Controller and they all use the same SCK, PICO and POCI  line

#### I2C

Inter-Integrated Circuit (I2C) communication protocol was created to deal with the drawbacks of both the USART and SPI communication protocols:
- USART is asynchronous - clock is built into transmit and recieve line, devices have to agree ahead of time on communication configuration
- SPI - Extra Peripherals require more wires

I2C make two lines for communcation:
- Serial Data (SDA) line 
- Serial Clock (SCL) line

Address signal that is sent on the SDA wire instead of a Chip select wire to determine which peripheral to comunicate up to 1008 devices can be connected to the same two lines

![1000](I2C-protocol)

Start and Stop signal are used to prevent communication collisions - device talking over each other. Each device monitors start and stop. 


## References

[Day 19 of AoC4 THM](https://tryhackme.com/room/adventofcyber4)
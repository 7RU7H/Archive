## USART

Universal Synchronous/Asynchronous Receiver-Transmitter (USART) communication, or as it is better known, serial communication, is a protocol that uses two wires.

![](USART-protocol.excalidraw.md)

One wire is used to transmit (TX) data from device A to device B, and the other wire is used to receive (RX) data on device A from device B. There is no clock line and the device must agree to the configuration of communication:
- Communication speed - baud rate or bit rate, devices can choose depending on compatibility between devices
- Bits per transmission - normally set to 8 bits 
- Stop and Start bits -  no clock, therefore defining beginning and ending bits any further communication between both devices must be defined    
- Parity bits - Errors can occur, parity bits are used to detect and correct errors in transmission

Some USART connections will use two additional lines:
- Clear To Send (CTS)
- Request to Send (RTS)
These are to communicate to the other device whether it is ready to receive or to transmit. Furthermore, to agree upon what voltage level is a binary 1 or 0, a third wire called the Ground (GND) wire is required to allow the devices to have the same voltage reference.

## References

[Day 19 of AoC4 THM](https://tryhackme.com/room/adventofcyber4)
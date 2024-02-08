# I2C

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

[DEF CON 24 - Hardware Hacking Village - Matt DuHarte - Basic Firmware Extraction](https://www.youtube.com/watch?v=Kxvpbu9STU4)
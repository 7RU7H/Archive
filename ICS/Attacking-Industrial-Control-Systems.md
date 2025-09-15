# Attacking Industrial Control Systems

This is mostly notes and a straight mirror of [THM Room: Attacking Industrial Control Systems 1](https://tryhackme.com/room/attackingics1). This room is old and I will in the future do a more update review of were ICS is as touching `pip` in 2025 and old dependency chain is a virtualisation nightmare I would rather do without losing hours of my life. My real world virtual factorio hacking to understand dreams do not need any more python package pain. This room is good overview and is concise about the subject matter such that I did not need to rewrite more simply. 



Security **is not** the first priority in OT/ICS
Human interfaces exist to control behaviour of the plant

Recommended reading: [Guide to Industrial Control Systems (ICS) Security (NIST 800-82)](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-82r2.pdf).




Supervisory Control and Data Acquisition (SCADA) systems are used to control and automate industrial processes. . SCADA systems includes: 
- Supervisory computers: the servers used to manage the process gathering data on the process and communicating with filed devices (PLC/RTU). In smaller deployments HMI is embedded in a single computer, in larger deploy HMI is installed into a dedicated computer. 
[Guide to Industrial Control Systems (ICS) Security (NIST 800-82)](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-82r2.pdf).- Programmable Logic Controllers (PLC): digital computers used mainly for automating industrial processes. They are used to continuously monitor sensors (input) and make decisions controlling devices (output).
- Remote Terminal Units (RTU): nowadays RTUs and PLCs functionalities overlap with each other. RTUs are usually preferred for wider geographical telemetry whereas PLCs are better with local controls.
- Communication network: the network connecting all SCADA components (Ethernet, Serial, telephones, radio, cellular...). Network failures do not necessarily impact negatively on the plant process.  Both RTU's and PLC's should be designed to operate autonomously, using the last instruction given from the supervisory system.
- Human Machine Interface (HMI): displays a digitalized representation of the plant. Operators can interact with the plant issuing commands using mouse, keyboards or touch screens. Operators can make supervisory decisions adjusting or overriding the normal plant behaviour.

#### Modbus

[Modbus 101 - Introduction to Modbus](https://www.csimn.com/CSI_pages/Modbus101.html)

Modbus is an industrial protocol developed by Modicon, acquired by Schneider Electric.
- Modbus is widely used to connect industrial devices; protocol specification is available and royalty-free.
- Modbus protocol is a master/slave protocol: the master reads and writes slaves' registers.
- Modbus RTU is usually used via RS-485 (serial network): one master is present with one or more slaves. Each slave has an unique 8-bit address. 
- Modbus data is used to read and write "registers" which are 16-bit long. The most common register is called "holding register" which is readable and writable; registry type "input register" is readable only. The registers "coil" and "discrete input" are 1-bit long: coils are readable and writable, discrete inputs are readable only.

Modbus register types:
- Discrete Input (Status Input): 1bit, RO
- Coil (Discrete Output): 1bit, R/W
- Input Register: 16bit, RO
- Holding Register: 16bit R/W

Most commonly used Modbus functions:

|               |                                  |
| ------------- | -------------------------------- |
| Function Code | Register Type                    |
| 1             | Read Coil                        |
| 2             | Read Discrete Input              |
| 3             | Read Holding Registers           |
| 4             | Read Input Registers             |
| 5             | Write Single Coil                |
| 6             | Write Single Holding Register    |
| 15            | Write Multiple Coils             |
| 16            | Write Multiple Holding Registers |

Modbus TCP encapsulates Modbus RTU request and response data packets in a TCP packet transmitted over standard Ethernet networks. The TCP Modbus standard port is 502.

#### Self hosting 

[GitHub Virtuaplant](https://github.com/jseidl/virtuaplant) - *VirtuaPlant is a Industrial Control Systems simulator which adds a “similar to real-world control logic” to the basic “read/write tags” feature of most PLC simulators.*
## References

[THM Room: Attacking Industrial Control Systems 1](https://tryhackme.com/room/attackingics1) 
[Guide to Industrial Control Systems (ICS) Security (NIST 800-82)](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-82r2.pdf)
[Modbus 101 - Introduction to Modbus](https://www.csimn.com/CSI_pages/Modbus101.html)
[GitHub Virtuaplant](https://github.com/jseidl/virtuaplant) 
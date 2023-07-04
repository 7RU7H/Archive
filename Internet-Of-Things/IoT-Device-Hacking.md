# IoT Device Hacking

Internet of Things (IoT) Devices are physical devices with various capabilities such as sensors, processing, software and connectivity to exchange data with other devices and systems over the internet or other communications networks.

## Get the Firmware

1. Obtaining it from the vendor's website
2. Googling it  
3. Reversing the mobile application  
4. Sniffing the OTA (over the air) update mechanism
5. Dumping it from the device


## Common Messaging Protocols 

**Protocol  ** | **Communication Method** | **Description**  
--- | --- | --- 
MQTT (Message Queuing Telemetry Transport)| Middleware | A lightweight protocol that relies on a publish/subscribe model to send or receive messages.  
CoAP (Constrained Application Protocol) | Middleware | Translates HTTP communication to a usable communication medium for lightweight devices.  
AMQP (Advanced Message Queuing Protocol)  | Middleware   | Acts as a transactional protocol to receive, queue, and store messages/payloads between devices.  
DDS (Data Distribution Service) | Middleware | A scalable protocol that relies on a publish/subscribe model to send or receive messages.   
HTTP (Hypertext Transfer Protocol) | Device-to-Device | Used as a communication method from traditional devices to lightweight devices or for large data communication.  
WebSocket | Device-to-Device  | Relies on a client-server model to send data over a TCP connection.

## Hacking and Abusing Device Behaviour


1. Setup Client communication - enumerating device id 
- [[MQTT]], or [mqtt-pwn](https://github.com/akamai-threat-research/mqtt-pwn)
1. Hack the message - Abuse Device Behaviour! - use: 
		1. [[RTFM]]  
	1. [[Reverse-Engineering-Tools]] to Reverse Enigneer 
	1. [[Source-Code-Analysis]]

2. Setup a Listener 
	- Consider containerising the listener with - Docker - see [[Docker]]
3. Send a message to the broker to send redirect target output to listener device of your choosing


## References

[Wikipedia IoT](https://en.wikipedia.org/wiki/Internet_of_things)
[THM AoC4](https://tryhackme.com/room/adventofcyber4)
[THM Intro to IoT](https://tryhackme.com/room/iotintro)
# OSI MODEL

### PDU 
"In telecommunications, a protocol data unit (PDU) is a single unit of information transmitted among peer entities of a computer network. 
A PDU is composed of protocol-specific control information and user data. 
In the layered architectures of communication protocol stacks, each layer implements protocols tailored to the specific type or mode of data exchange." [wiki](https://en.wikipedia.org/wiki/Protocol_data_unit)

### Design Principle: Encapsulation:
The OSI model expects data to travel up the various layers via encapsulation. 
Each layer contains descriptions of information at the next layer as well as the intended message itself.

### Layers
```
Layer 			7
Protocol 		Application Layer
Data Unit(PDU) 	DATA
Function		How the software recieves data
						 
Layer 			6
Protocol		Presentation Layer
Data Unit(PDU)  DATA
Function		Rearrangement(encrypting, compressing or tranformations) 
				of all bottom up data for Layer 7

Layer			5
Protocol		Session Layer
Data Unit(PDU)	DATA
Function		Implement protocols that initiate, maintain and terminate 												       			 connections	

Layer			4
Protocol		Transport Layer
Data Unit(PDU)	Segment, Datagram
Function		Ordering and time management of data between source to destination, Handling errors, resending, transmission speed issues
				Stateful protocols - segementation of segments;
				Statless protocols(datagrams) accept some packet loss, reording, errors or duplication.

Layer
Protocol		Network Layer
Data Unit(PDU)	Packet
Function		Routing and broadcasting of messages, addressing of multiple 					  																		   				 hosts

Layer 			2
Protocol		Data Link Layer
Data Unit(PDU)	Frame
Function		Define rules for initating, monitoring and terminating communication
				Error detection and correction

Layer			1
Protocol		Physical Layer
Data Unit(PDU)	Bit, Symbol
Function		Transfers raw data between physical machine and physical medium

```

## References

[Wikipedia PDU](https://en.wikipedia.org/wiki/Protocol_data_unit)
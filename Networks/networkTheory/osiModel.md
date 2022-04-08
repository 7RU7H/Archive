# OSI MODEL

### PDU 
"In telecommunications, a protocol data unit (PDU) is a single unit of information transmitted among peer entities of a computer network. 
A PDU is composed of protocol-specific control information and user data. 
In the layered architectures of communication protocol stacks, each layer implements protocols tailored to the specific type or mode of data exchange." 

### Design Principle: Encapsulation:
The OSI model expects data to travel up the various layers via encapsulation. 
Each layer contains descriptions of information at the next layer as well as the intended message itself.

### Layers

___________________________________________________________________________________________________________________________________________________________________
===================================================================================================================================================================

	Layer				Protocol Data Unit(PDU)	Function

	Layer 7: Application Layer	DATA			How the software recieves data
		
HOST	Layer 6: Presentation Layer	DATA			Rearrangement(encrypting, compressing or tranformations) of all bottom up data for Layer 7, 
LAYERS
	Layer 5: Session Layer		DATA			Implement protocols that initiate, 
								maintain and eventually terminate connections 

	Layer 4: Transport Layer	Segment, Datagram	Ordering and time management of data between source to destination
								Handling errors, any need for resending, transmission speed issues
								Stateful protocols - segementation of segments;
								Statless protocols(datagrams) accept some packet loss, reording, 
								errors or duplication   
_______
	Layer 3: Network Layer		Packet			Routing and broadcasting of messages, addressing of multiple hosts

MEDIA	Layer 2: Data Link Layer	Frame			Define rules for initating, monitoring and terminating communiction
LAYERS								Error detection and correction

	Layer 1: Physical Layer		Bit, Symbol		Transfers raw data between physical machine and physical medium


___________________________________________________________________________________________________________________________________________________________________
===================================================================================================================================================================


#  Transport Layer: TCP

#### Transmission control protocol (TCP)

Initiated with a TCP handshake
TCP segment require the sender to specify a port number

To initate a TCP session:
Three-way-handshake
A -> SYN -> B
B -> SYN-ACK -> A
A -> ACK -> B

- TCP considerations 
	- TCP does not know architecture
	- Timestamps option can reduce retransmission timer 
	 - SACK_PERM TSVal, TSecr - Timestamp Value and Timestamp Echo Reply - do not confused with [[Wireshark]] Time stamping
	- Some increment by the milliseconds or network latency
	- [[TCP-IP-Model]]
	- [[TCP-Wrappers]]

## References

[How TCP Works - Chris Greer](https://www.youtube.com/watch?v=4EFEdAyxemk)
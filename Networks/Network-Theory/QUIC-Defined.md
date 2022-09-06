# QUIC Defined

## Introduction

[For a great video that is probably the most concise explainantion of the QUIC protocol view the Chris Greer How QUIC works Youtube](https://www.youtube.com/watch?v=HnDsMehSSY4)

QUIC is a UDP-Based Multiplexed and Secure Transport Protocol designed to replace older protocols. [RFC 9000](https://www.rfc-editor.org/rfc/rfc9000.html). For secure TCP with TLS requires at its most modern, atleast three require round trips wit no errors, latency. QUIC is not acronymn, runs over UDP and does not require TCP handshaking, the TLS Client side "hello" is including in the **inital packet** and the TLS Server side is returned in the subsequent packet. QUIC has HTTP3 on higher protocol layer and the Client can then send http3 GET requests one network round trip less the TCP. QUIC also has 0-RTT, which if the Client is known Server-side can have ZERO round trips! By sitting on the top of UDP an already in-use protocol on servers around the world to layer inside of QUIC bypasses any hardware upgrading required Serverside.



## Wireshark and Chis Greener
[[Wireshark]]

## References
[QUIC Wikipedia](https://en.wikipedia.org/wiki/QUIC)
[QUIC WorkGroup](https://quicwg.org/)
[RFC 9000](https://www.rfc-editor.org/rfc/rfc9000.html)

[David Bombal - Robin Marx QUIC Interview]()()
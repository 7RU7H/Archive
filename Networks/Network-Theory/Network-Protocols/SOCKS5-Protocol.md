# SOCKS5 Protocol

[SOCKS](https://en.wikipedia.org/wiki/SOCKS) is internet proctol that exchanges network packets between to clients through a proxy server. [RFC 1928](https://www.rfc-editor.org/rfc/rfc1928.txt) outline SOCKS5 that provides optional authentication. SOCKS is found at the Session Layer (5) of the [[OSI-Model]]. 

From [THM Network Security Protocols](https://tryhackme.com/room/networksecurityprotocols):
-   **Client Initiation**
    -   Client A connects with the SOCKS5 proxy and sends the first byte (0x05) to the proxy where “5” is the SOCKS version.
    -   Client A sends a second byte (0x01). One means authentication is supported.
    -   Client A sends the third byte (0x00, 0x01, 0x02, or 0x03); these bytes denote the supported authentication methods and can be of variable length.
-   **SOCKS5 Proxy Reply**
    -   The proxy sends back a second byte, which is the chosen authentication method by the proxy server.
    -   After the initiation packet, client A sends the request packet, which includes BHOST & BPORT numbers.
    -   The successful session is established between client A and the proxy. The same steps are involved in the association of client B with the proxy.
-   **Data Transfer**
    -   After successfully associating both clients with a proxy server, both clients can exchange data and share information that will be routed through the proxy server.

## References

[THM Network Security Protocols](https://tryhackme.com/room/networksecurityprotocols)
[Wikipedia SOCKS](https://en.wikipedia.org/wiki/SOCKS)
[RFC 1928](https://www.rfc-editor.org/rfc/rfc1928.txt)
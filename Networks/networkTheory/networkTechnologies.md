# Network Technologies                                        

Domain Name System(DNS)

www.root.com # Top level domain root
To resolve this hostname:

DNS recursor = First server contacted, responsible for intercting with the DNS infrastructure  and return results to client.

Offsec:

"The process starts when a hostname is entered into a browser or other application. The browser passes the hostname to the operating system's DNS client and the operating system then forwards the request to the external DNS server it is configured to use. This first server in the chain is known as the DNS recursor and is responsible for interacting with the DNS infrastructure and returning the results to the DNS client. The DNS recursor contacts one of the servers in the DNS root zone. The root server then responds with the address of the server responsible for the zone containing the Top Level Domain (TLD),2 in this case, the .com TLD.

Once the DNS recursor receives the address of the TLD DNS server, it queries it for the address of the authoritative nameserver for the megacorpone.com domain. The authoritative nameserver is the final step in the DNS lookup process and contains the DNS records in a local database known as the zone file. It typically hosts two zones for each domain, the forward lookup zone that is used to find the IP address of a specific hostname and the reverse lookup zone (if configured by the administrator), which is used to find the hostname of a specific IP address. Once the DNS recursor provides the DNS client with the IP address for www.megacorpone.com, the browser can contact the correct web server at its IP address and load the webpage.

To improve the performance and reliability of DNS, DNS caching is used to store local copies of DNS records at various stages of the lookup process. That is why some modern applications, such as web browsers, keep a separate DNS cache. In addition, the local DNS client of the operating system also maintains its own DNS cache along with each of the DNS servers in the lookup process. Domain owners can also control how long a server or client caches a DNS record via the Time To Live (TTL) field of a DNS record."


    NS - Nameserver records contain the name of the authoritative servers hosting the DNS records for a domain.
    A - Also known as a host record, the "a record" contains the IP address of a hostname (such as www.megacorpone.com).
    MX - Mail Exchange records contain the names of the servers responsible for handling email for the domain. A domain can contain multiple MX records.
    PTR - Pointer Records are used in reverse lookup zones and are used to find the records associated with an IP address.
    CNAME - Canonical Name Records are used to create aliases for other host records.
    TXT - Text records can contain any arbitrary data and can be used for various purposes, such as domain ownership verification.

Address Resolution protocol (ARP) 
ARP is designed to associate Network Layer addreses to Link Layer address.
Allows switch to transmit Ethernet Frames to their intended destination decives on a LAN
ARP has its own command, arp, that allows it to display or manipulate the network cache

The Internet Control Messaging Protocol (ICMP)
ICMP operates at the Transport layer of TCP/IP. It plays a crucial support function: when there is a problem with the reception of data, it alerts the sender with various kinds of error messages. It generally does not transmit data itself, aside from these error codes.

Dynamic Host Configuration Protocol (DHCP)
Ensures any new machines that join a network can negotiate with existing machines to recieve a properley configured a unique IP address.
Centralization is important, A DHCP server assigns an IP address making sure they are all unique.  


# Routing Tables:

Routing tables help machines determine how they can send information to other hosts that they may not have a direct connection with.
A routing table essentially describes a chart for how its router (or network host) can reach an array of potential destinations in the most efficient manner, by making use of the least number of hops possible.

Routing tables can be used to direct traffic within a network, or across multiple networks. For the latter, routing tables can include both static and dynamic data. Static routes are simply hardcoded addresses, whereas dynamic routes are learned by a machine or router by means of some networking protocol (for example, DHCP).


# Firewalls:

Firewalls receive, and then drop or allow, incoming and outgoing traffic to pass through a network based on rules defined by a system or network administrator.
Packet Filter, filters packets by rules detirmined in the Access Control List(ACL).  
Accept: Sends ICMP to confirm connection.
Drop: Drop conenction does ICMP back to source.
Reject: Sends ICMP to confirm rejected connection.
IPtables can be used hold a library of blacklisted or whitelisted traffic.


Packet-Filtering Firewall: Packet-filtering is the most basic type of firewall. This type of firewall inspects the protocol, source and destination IP addresses, and source and destination ports in the case of TCP and UDP datagrams. It is a stateless inspection firewall.
    
Circuit-Level Gateway: In addition to the features offered by the packet-filtering firewalls, circuit-level gateways can provide additional capabilities, such as checking TCP three-way-handshake against the firewall rules.
    
Stateful Inspection Firewall: Compared to the previous types, this type of firewall gives an additional layer of protection as it keeps track of the established TCP sessions. As a result, it can detect and block any TCP packet outside an established TCP session.
    
Proxy Firewall: A proxy firewall is also referred to as Application Firewall (AF) and Web Application Firewall (WAF). It is designed to masquerade as the original client and requests on its behalf. This process allows the proxy firewall to inspect the contents of the packet payload instead of being limited to the packet headers. Generally speaking, this is used for web applications and does not work for all protocols.
    
Next-Generation Firewall (NGFW): NGFW offers the highest firewall protection. It can practically monitor all network layers, from OSI Layer 2 to OSI Layer 7. It has application awareness and control. Examples include the Juniper SRX series and Cisco Firepower.
    
Cloud Firewall or Firewall as a Service (FWaaS): FWaaS replaces a hardware firewall in a cloud environment. Its features might be comparable to NGFW, depending on the service provider; however, it benefits from the scalability of cloud architecture. One example is Cloudflare Magic Firewall, which is a network-level firewall. Another example is Juniper vSRX; it has the same features as an NGFW but is deployed in the cloud. It is also worth mentioning AWS WAF for web application protection and AWS Shield for DDoS protection.

# Network address translation(NAT):

Used to increase the amount of IP addresses possible, creating a one-to-many map, while keep certian ranges for private use.
Acting as gateway translation from intranetwork address accessing extranetwork addresses.

Offsec Fundemnetals:
"NAT greatly increases the amount of addresses that can communicate on the Internet but it also has some important implications for security. Since the default gateway will overwrite all source IP addresses by its public address, any traffic passed through the gateway looks like it is coming from the gateway itself. This helps protect the internal IP addresses, since it is difficult for a given destination to know what the "real" source IP address is. On the flipside, NAT can make it difficult to attribute traffic for network and system administrators outside of a private network."

# Portaddress translation(PAT):

Similar to a NAT but the managing the usages of ports between 0 - 65535.

# Virtual Private Networks(VPNs):

A Virtual Private Network (VPN) essentially allows for the creation of a private network that acts as a dedicated tunnel within another public network (i.e the Internet). Accessed via various authentication protocols. Typically tun0 or tap0 are used to interface

Transmission Control Protocol(TCP)

Important States:
ESTABLISHED
    The socket has an established connection. 
SYN_SENT
    The socket is actively attempting to establish a connection. 
SYN_RECV
    A connection request has been received from the network. 
FIN_WAIT1
    The socket is closed, and the connection is shutting down. 
FIN_WAIT2
    Connection is closed, and the socket is waiting for a shutdown from the remote end. 
TIME_WAIT
    The socket is waiting after close to handle packets still in the network. 
CLOSED
    The socket is not being used. 
CLOSE_WAIT
    The remote end has shut down, waiting for the socket to close. 
LAST_ACK
    The remote end has shut down, and the socket is closed. Waiting for acknowledgement. 
LISTEN
    The socket is listening for incoming connections. Such sockets are not included in the output unless you specify the --listening (-l) or --all (-a) option. 
CLOSING
    Both sockets are shut down but we still don't have all our data sent. 
UNKNOWN
	The state of the socket is unknown.


IP ROUTE FLAGS:


    U : This flag signifies that the route is up
    G : This flag signifies that the route is to a gateway. If this flag is not present then we can say that the route is to a directly connected destination
    H : This flag signifies that the route is to a host which means that the destination is a complete host address. If this flag is not present then it can be assumed that the route is to a network and destination would be a network address.
    D : This flag signifies that this route is created by a redirect.
    M : This flag signifies that this route is modified by a redirect.

HTTP Secure

HTTPS1 (Hypertext Transfer Protocol Secure) is the secure version of HTTP. HTTPS is encrypted to increase the overall security of data communication between clients and the server.

A website should use HTTPS, regardless of what kind of data is exchanged. This is not only because unencrypted data can be easily read, but also malicious javascript can be inserted by an attacker listening to the communication, which can lead to client-side attacks 2 or man-in-the-browser3 attacks. As a result, most websites today use HTTPS as a layer of prevention.

HTTPS also provides some protection from network tempering, such as a man-in-the-middle.4 Tools such as Ettercap5 or NetHunter Man In The Middle Framework6 are used for this kind of attack.

If a computer is compromised, certain attacks are still possible despite HTTPS.

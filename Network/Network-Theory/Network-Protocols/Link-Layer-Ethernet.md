# Link Layer: Ethernet

Networks consisting of only physical devies are vulnerable to collisions - two or more device transmits packets on a network segment at the same time.
Link layer purspose is to reduce collisions no the physical network.
Ethernet allows to form logical boudaries around physically connected devices via the concept of network switches or bridges.
Switches reduce collision by divideing it into smaller networks of networks.
Devices can reach another devices networking interface by invoking its MAC address

MAC addresses are constructed by concatenating six bytes (8-bit hexidecial numbers), for example:
11:22:33:44:55:66
^^ ^^ ^^
Organizationally Unique Identifier (OUI) the bottom three octets, ensures uniqueness

Device do not inherently know each other MAC addresses, thus ARP:
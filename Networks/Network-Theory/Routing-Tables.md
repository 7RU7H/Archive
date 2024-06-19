# Routing Tables

Routing tables help machines send information to other machines that may or are not in direct connection with. 

A routing table essentially describes a chart for how its router (or network host) can reach an array of potential destinations in the most efficient manner, by making use of the least number of hops possible.

Routing tables can be used to direct traffic within a network, or across multiple networks. For the latter, routing tables can include both static and dynamic data. Static routes are simply hardcoded addresses, whereas dynamic routes are learned by a machine or router by means of some networking protocol (for example, DHCP).

#### IP Route Flags

Mirrored from [IP Route Table Tables - University of Wollongong](https://documents.uow.edu.au/~blane/netapp/ontap/nag/networking/reference/r_oc_netw_routing-table-flags.html)

| Flag | Description                                                                                                    |
| ---- | -------------------------------------------------------------------------------------------------------------- |
| U    | Up—Route is valid                                                                                              |
| G    | Gateway—Route is to a gateway router rather than to a directly connected network or host                       |
| H    | Host name—Route is to a host rather than to a network, where the destination address is a complete address     |
| R    | Reject—Set by ARP when an entry expires (for example, the IP address could not be resolved into a MAC address) |
| D    | Dynamic—Route added by a route redirect or RIP (if routed is enabled).                                         |
| M    | Modified—Route modified by a route redirect                                                                    |
| C    | Cloning—A new route is cloned from this entry when it is used                                                  |
| L    | Link—Link-level information, such as the Ethernet MAC address, is present                                      |
| S    | Static—Route added with the route command                                                                      |

## References

[IP Route Table Tables - University of Wollongong](https://documents.uow.edu.au/~blane/netapp/ontap/nag/networking/reference/r_oc_netw_routing-table-flags.html)
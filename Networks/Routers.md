# Routers


Stand-alone appliances designated as routers typically will learn routes using a combination of static route creation, dynamic routing protocols, and directly connected interfaces. Any traffic destined for networks not present in the routing table will be sent to the `default route`, which can also be referred to as the default gateway or gateway of last resort

If not Routing Protocol are used packets are forwarded to a `Gateway` out of the corresponding NIC (`Iface`). Routing Protocols exist:

BGP

EIGRP

OSPF

##  References

[HTB Academy Pivot Module](https://academy.hackthebox.com/)
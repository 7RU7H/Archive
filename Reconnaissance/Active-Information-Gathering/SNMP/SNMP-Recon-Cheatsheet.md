# SNMP Cheatsheet

Simple Network Management Protocol (SNMP) is based on UDP; stateless protocol making it to it is susceptible to IP spoofing and replay attacks.
SNMP services misconfigurations lead to data leakages. It is meant to **manage** the network. SNMP protocols 1, 2, and 2c offer no traffic encryption and can be easily intercepted over a local network. For port information see [[Network-Protocols-Cheatsheet]].

## MIB Tree
SNMP Management Information Base (MIB) is a database organised in tree based structure containing information usually related to network management. Leaves being the endpoints and the branches representing organisations or network functions.

SNMP MIB values | SNMP Parameter
--- | ---
1.3.6.1.2.1.25.1.6.0 | System Processes
1.3.6.1.2.1.25.4.2.1.2 | Running Programs
1.3.6.1.2.1.25.4.2.1.4 |  Processes Path
1.3.6.1.2.1.25.2.3.1.4 | Storage Units
1.3.6.1.2.1.25.6.3.1.2 | Software Name
1.3.6.1.4.1.77.1.2.25 | User Accounts
1.3.6.1.2.1.6.13.1.3 | TCP Local Ports

## Enumeration

Never forget your `nmap sU` scans or equivalent.

Requires a community list contains community strings and ip addresses. `onesixtyone` will then brute force against the list of ips.
```bash
onesixtyone -c $community -i $SMNP_IP_LIST
```

```bash
snmpwalk -c public -v1 -t 5 $IP $mib_values
```

## Ippsec approach

```bash
sudo apt install snmp-mibs-downloader
sudo vim /etc/snmp/snmp.conf
# Add a comment on the line 
mibs :
# Use snmpbulkwalk - remember '.' at end
snmpbulkwalk -c public -v2c $IP .
```

Snmpenum tool may not catch any weirdness.

## Get an IPv6 Address from MIBs
[[IPv6-Defined]] to understand IPv6

```bash
cat snmpwalk-output | grep iso.3.6.1.2.1.4.34.1.3.2.16|cut -d "." -f 13-28 | cut -d " " -f 1
# Output will be in the format by line
# Loopback
# Link-Local
# Unique-Local
or 
cat -n snmpbulkoutput | grep "inetCidrRouteIfIndex.ipv6"
```

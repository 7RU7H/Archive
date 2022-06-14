# SNMP
UDP port 161 

## Enumeration
Requires a community list
```bash
onesixtyone -c community -i $SMNP_IP_LIST
snmpwalk -c public -v1 $IP $mib_values
```

**Mib-values (for snmpwalk):**

```c
1.3.6.1.2.1.25.1.6.0 System Processes

1.3.6.1.2.1.25.4.2.1.2 Running Programs

1.3.6.1.2.1.25.4.2.1.4 Processes Path

1.3.6.1.2.1.25.2.3.1.4 Storage Units

1.3.6.1.2.1.25.6.3.1.2 Software Name

1.3.6.1.4.1.77.1.2.25 User

1.3.6.1.2.1.6.13.1.3 TCP Local Ports
```

## Ippsec approach
```bash
sudo apt install snmp-mibs-downloader
sudo vim /etc/snmp/snmp.conf
# Add a comment on the line 
mibs :$
# Use snmpbulkwalk - remember '.' at end
snmpbulkwalk -c public -v2c $IP .
```

snmpenum tool may not catch any weirdness.
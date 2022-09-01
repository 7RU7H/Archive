# Internet Protocol IP 

IP addresses
```
4 * octet concatenate_to 32bit int; foreach assign 1-255 # (2^8 = 256) 

```
2^32 OR
2^8^4 = 0-255.0-255.0-255.0-255 possible addresses ~4.3billion possible values
This can be written as 32 bit binary address.
Each network is assigned a subnet mask.
This helps to define what IP address are allowed to exist within that same network or not.
To figure out which other machines can be inside network:
1. Compare the zero-bits - The zero-bits of the subnet masks do not constrain potential IP addresses.
1. Compare the one-bits - The one-bits tell us that every corresponding bit of any two IP addresses inside the network must match.

4.3 billion possible values, [[Network-Address-Translations]] (NAT) solves this small number
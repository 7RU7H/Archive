# Routing Guest VMs Traffic Through A Host Machines VPN

[Ippsec.Rocks](https://ippsec.rocks): Sharing VPN with your Window guest from your Linux host 
```bash
# Check if IP fowarding is enabled 
cat /proc/sys/net/ipv4/ip_forward
# Enable IP forward
sudo echo 1 > /proc/sys/net/ipv4/ip_forward
# Iptables rules 
# INTERFACE is whatever network device that is providing internet to your nic from `ip a`
# INF-IP is INTERFACE ip not include CIDR range
# RANGE is the range choosen or the CIDR range from INTERFACE
sudo iptables -A FORWARD -i tun0 -o $INTERFACE -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i $INTERFACE -o tun0 -j ACCEPT
# Create masquerade/NAT rule to deal with connection not rewriting the ip adderss as Linux box is gateway, but not handling addresses
sudo iptables -t NAT -A POSTROUTING -s INF-IP/RANGE -o tun0 -j MASQUERADE
```

On Windows guest create route on Windows machine
```powershell
route add 10.10.10.0/23 mask 255.255.254.0 gw $LINUXIP
```

Ippsec reconfigured a network adaptor, but you could also add entries into /etc/hosts on windows
```powershell
# Found: C:\Windows\System32\drivers\etc\hosts
# Requires Administrator terminal to create DNS blackhole
powershell.exe echo "127.0.0.1 dc.absolute.htb absolute.htb" >> C:\Windows\System32\drivers\etc\hosts
```

## References

[Oppsec.rocks](https://ippsec.rocks)
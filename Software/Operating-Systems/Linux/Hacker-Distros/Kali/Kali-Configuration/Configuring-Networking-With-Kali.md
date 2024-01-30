# Networking With Kali

Consider using [[Linux-Networking-Commands]]

- **NetworkManager**
The default network configuration relies on DHCP to obtain an IP address, DNS server, and gateway. Must check _network-manager-*_ packages as some are not installed by default.

For introductory information about DNS visit: [[DNS]]. Base Kali has NetworkManager as a default DNS manager. To display current configuration of resolv.conf

```bash
cat /etc/resolv.conf
```

```bash
sudo systemctl restart NetworkManager
```


Singh's Alternative written about on [Singh's infrabytes blog](http://www.infrabytes.com/change-dns-in-kali) is `resolvconf`.

- **ifupdown**
`ifupdown` package contains  `ifup` and `ifdown`, which read definitions from the `/etc/network/interfaces` configuration file. They central at boot time in configuration of the network with the `/etc/init.d/networking` init script.
```bash
ifdown network-device # Deconfigure network device
# You can now modify /etc/network/interfaces
ifup network-device # Spin up network with any modifications that may have been made
# Directives
auto network-device # Automatically configure the network interface once it is available
iface <network-device> inet/inet6 <type> # configure interface when avaliable

``` 
For wireless interfaces, you must have the `wpasupplicant` package (included in Kali by default),

- **systemd-networkd**
[Systemd-networkd](https://wiki.archlinux.org/title/Systemd-networkd) *"is a system daemon that manages network configurations"*.  On Kali it is disabled by default it requires enabling and a symlink-ing the systemd-networkd DNS resolution file
To configure place `.network` files into `/etc/systemd/network/` directory. 

```bash
systemctl enable systemd-networkd
systemctl enable systemd-resolved
systemctl start systemd-networkd
systemctl start systemd-resolved
ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
```
- Alternatively - `/lib/systemd/network/` for packaged files or `/run/systemd/network/` for files generated at run-time. 

Beware lacks in integrated support for wireless networks.

## Interfaces

In the `/etc/network/interfaces` changes can be made to each interface, below is an example of configuring `eth0` for dynamic host configuration protocol (DHCP)
```bash
auto eth0
iface eth0 inet dhcp
```

Wireless
```bash
 wpa_passphrase myssid wpa-password # Generate a PSK

# add to /etc/network/interfaces
echo "
auto wlan0
iface wlan0 inet dhcp
     wpa-ssid myssid
     wpa-psk $PSK_hash

" | sudo tee -a /etc/network/interfaces
 
```


## References

[Singh's infrabytes blog](http://www.infrabytes.com/change-dns-in-kali)
[Systemd-networkd](https://wiki.archlinux.org/title/Systemd-networkd) 
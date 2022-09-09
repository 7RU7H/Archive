# Kali Configuration

## Network Related

- **NetworkManager**
The default network configuration relies on DHCP to obtain an IP address, DNS server, and gateway. Must check _network-manager-*_ packages as some are not installed by default.

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


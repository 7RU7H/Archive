# Netfilter

Beware the difference between `iptables` (see [ipXtables]) and successor [nftables](https://wiki.nftables.org/)

Netfilter use four tables to store rules(called **chains**) regulating various kinds of operations on packets. Standard chains are used to handle packets based on predefined circumstances. Each chain has list of rules, each rule is a set of conditions and action to be jumped `-j` to - performed - when a condition is met

-   `filter` - concerns filtering rules (accepting, refusing, or ignoring a packet);
	- `filter` Standard Chains:
		-  `INPUT` - concerns packets whose destination is the firewall itself.
		-   `OUTPUT` - concerns packets emitted by the firewall.
		-   `FORWARD` - concerns packets passing through the firewall (which is neither their source nor their destination).
-   `nat` (Network Address Translation) - concerns translation of source or destination addresses and ports of packets
	- `nat` Standard Chains:
		-   `PREROUTING` - to modify packets as soon as they arrive.
		-   `POSTROUTING` - to modify packets before going outbound.
		-   `OUTPUT` - to modify packets generated by the firewall itself.
-   `mangle` - concerns other changes to the IP packets (including the ToS—_Type of Service_—field and options);
	- Standard Chains:
		- `PREROUTING` - alter incoming packets before routing
		- `OUTPUT` - altering locally-generated packet before routing
		- `INPUT` - concerns packets whose destination is the firewall itself.
		- `FORWARD` - concerns packets passing through the firewall 
		- `POSTROUTING` - modify packets before going outbound.
-   `raw` - allows other manual modifications on packets before they reach the connection tracking system.
	- - `raw` Standard Chains:
		-  `PREROUTING` - modify packets arriving via any interface.
		-  `OUTPUT` - altering locally-generated packet before routing

- `security` - *This table is used for Mandatory Access Control (MAC) networking rules, such as those enabled by the **SECMARK** and **CONNSECMARK** targets. Mandatory Access Control is implemented by Linux Security Modules such as SELinux. The security table is called after the filter table, allowing any Discretionary Access Control (DAC) rules in the filter table to take effect before MAC rules.*
	- `security` Standard Chains:
		- `INPUT` - incoming packets
		- `OUTPUT` - altering locally-generated packet before routing
		- `FORWARD`  - altering packets being routed through the machine


## Netfilter Actions

-   `ACCEPT`: allow the packet to go on its way.
-   `REJECT`: reject the packet with an Internet control message protocol (ICMP) error packet (the `--reject-with type` option of `iptables` determines the type of error to send).
-   `DROP`: delete (ignore) the packet.
-   `LOG`: log (via `syslogd`) a message with a description of the packet. Note that this action does not interrupt processing, and the execution of the chain continues at the next rule, which is why logging refused packets requires both a LOG and a REJECT/DROP rule. Common parameters associated with logging include:
    -   `--log-level`, with default value `warning`, indicates the `syslog` severity level.
    -   `--log-prefix` allows specifying a text prefix to differentiate between logged messages.
    -   `--log-tcp-sequence`, `--log-tcp-options`, and `--log-ip-options` indicate extra data to be integrated into the message: respectively, the TCP sequence number, TCP options, and IP options.
-   `ULOG`: log a message via `ulogd`, which can be better adapted and more efficient than `syslogd` for handling large numbers of messages; note that this action, like LOG, also returns processing to the next rule in the calling chain.
-   _chain_name_: jump to the given chain and evaluate its rules.
-   `RETURN`: interrupt processing of the current chain and return to the calling chain; in case the current chain is a standard one, there's no calling chain, so the default action (defined with the `-P` option to `iptables`) is executed instead.
-   `SNAT` (only in the `nat` table): apply _Source Network Address Translation_ (SNAT). Extra options describe the exact changes to apply, including the `--to-source address:port` option, which defines the new source IP address and/or port.
-   `DNAT` (only in the `nat` table): apply _Destination Network Address Translation_ (DNAT). Extra options describe the exact changes to apply, including the `--to-destination address:port` option, which defines the new destination IP address and/or port.
-   `MASQUERADE` (only in the `nat` table): apply _masquerading_ (a special case of _Source NAT_).
-   `REDIRECT` (only in the `nat` table): transparently redirect a packet to a given port of the firewall itself; this can be used to set up a transparent web proxy that works with no configuration on the client side, since the client thinks it connects to the recipient whereas the communications actually go through the proxy. The `--to-ports port(s)` option indicates the port, or port range, where the packets should be redirected.

## References

[iptable Manual](https://ipset.netfilter.org/iptables.man.html)
[Debian iptable man page](https://linux.die.net/man/8/iptables)
[netfilter Documentation](https://netfilter.org/documentation/)
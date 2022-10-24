# Hardening

[ssh tarpit](https://github.com/skeeto/endlessh)


## Softblock wifi and bluetooth
```bash
rfkill list
rfkill block wifi
rkilll block bluetooth
```

To hardblock wifi or bluetooth find the toggle on motherboards, in bioses and other switchs on peripherals.   

## SSH Related
[ssh](https://linuxhint.com/disable_root_ssh_debian/)

Helpful connect unwanted ssh connections back to there machine lol. 
```bash
socat -d -d TCP-L:22,reuseaddr,fork SYSTEM:"nc \\$SOCAT_PEERADDR 22
```


## Iptables

Log new connections to a box [ippsec](https://www.youtube.com/watch?v=ABVR8EgXsQU&t=186)
```bash
iptables -A INPUT -p tcp -m state --state NEW -j LOG --log-prefix "IPTables New-Connection: " -i $interface
```


## References
[ippsec geniunely rocks](https://ippsec.rocks/?#)
[@climagic](@climagic)
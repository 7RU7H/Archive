# Hardening

[AppArmor](https://apparmor.net/): *"AppArmor is an effective and easy-to-use Linux application security system. AppArmor proactively protects the operating system and applications from external or internal threats, even zero-day attacks, by enforcing good behavior and preventing both known and unknown application flaws from being exploited. AppArmor supplements the traditional Unix discretionary access control (DAC) model by providing mandatory access control (MAC). It has been included in the mainline Linux kernel since version 2.6.36 and its development has been supported by Canonical since 2009."*

```bash
aa-status 
sudo journalctl -fx
```

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

SSH Keys



## Iptables

Log new connections to a box [ippsec](https://www.youtube.com/watch?v=ABVR8EgXsQU&t=186)
```bash
iptables -A INPUT -p tcp -m state --state NEW -j LOG --log-prefix "IPTables New-Connection: " -i $interface
```

## Stop Sneaky, Fast Execution!

[/dev/shm is a common directory for marshalling and operating from in Linux for attackers as it directory that is a tempory file storage that uses RAM for the backing store](https://superuser.com/questions/45342/when-should-i-use-dev-shm-and-when-should-i-use-tmp. It is flushed leaving no trace of execution or what was put in that directory. It is also faster as than disk storage.
```bash
sudo mount -o remount,noexec /dev/shm
mount | grep shm # to check flags
```


## Disto Specific Guides

[Fedora](https://docs.fedoraproject.org/en-US/fedora/17/html/Security_Guide/chap-Security_Guide-Basic_Hardening.html)


## References
[ippsec geniunely rocks](https://ippsec.rocks/?#)
[@climagic](@climagic)
[Fedroa Hardening Guide(https://docs.fedoraproject.org/en-US/fedora/17/html/Security_Guide/chap-Security_Guide-Basic_Hardening.html)
## Service Configuration

Services sometimes called daemons, or programs have configurable configuration files.
Kali Linux's policy is to have any network services disabled by default, which is a different behavior to other Linux operating systems. For more information see [_Kali Linux Policies_](https://portal.offensive-security.com/courses/pen-103/books-and-videos/modal/modules/about-kali-linux/kali-linux-policies/network-services-disabled-by-default).

RTFM: `/usr/share/doc/package/README.Debian` is good initial research location. `dpkg -L package` lists files included in the package `dpkg -s package` displays the package meta-data and shows any possible recommended or suggested packages. Configuration files are often self-doucmented, examples of configuration files are provided in `/usr/share/doc/package/examples/`.

#### SSH Configuration
For usage see [[SSH-Cheatsheet]]. While the `openssh-server` package is installed by default, the SSH service `sshd`  is disabled by default and thus is not started at boot time. Use:
```bash
systemctl enable ssh
systemctl start ssh
```

Ideally regardless and regardless on the use of the above service. 
```bash
# Editing /etc/ssh/sshd_config
# Requires:
systemctl reload ssh
```

Generating new `ssh` host keys are stored `/etc/ssh/ssh_host_*`  new images may comes with pre-generated hosts!
```bash
rm /etc/ssh/ssh_host_*
dpkg-reconfigure openssh-server
systemct restart ssh
```

## References

[Kali Linux Policies](https://portal.offensive-security.com/courses/pen-103/books-and-videos/modal/modules/about-kali-linux/kali-linux-policies/network-services-disabled-by-default)
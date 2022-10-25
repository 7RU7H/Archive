# Kali

## Introduction
Kali Linux is Debian GNU/Linux Linux distribution, which is probably the defacto Enterprise-ready standard for security auditing with the tagline: "the quieter you become, the more you are able to hear". First released in March 2013 to then use a Rolling release model on 21st January, 2016 to present.

With it is own custom Linux Kernel it massively customizable from a trusted source.
Headless or GUI the default tools are extensive and come with various alternatives. Default tool come organised into Information Gathering, Vulnerability Analysis, Web Application Analysis, Database Assessment, Password Attacks, Wireless Attacks, Reverse Engineering, Exploitation Tools, Sniffing & Spoofing, Post ExploitationF, orensics, Reporting Tools and Social Engineering Tools. 

## OS Features 
Track divergence with Debian:
[Kali Package Tracker](https://pkg.kali.org/derivative/kali-dev/) 
Git repository packages:
[Package](https://gitlab.com/kalilinux/packages)
ISO types:
[ARM, Bare metal, VM, Mobile, Cloud, Containers, Live Boot, Window Subsystem for Linux](https://www.kali.org/get-kali/)
Forensics Mode(to avoid data contamination from auto-mounting any diskes) avaliable a boot.
Network Services Disabled by Default.
Offsec sponsers tool curating a vast collection of great tools for the long term.

## Documentation

[Offical Documentation Queries Site: https://www.kali.org/docs/](https://www.kali.org/docs/) 

[Offensive Security Docs](http://docs.kali.org)
[Offensive Security Forums](https://forums.kali.org)
[Offensive Security Tools](https://tools.kali.org)
[Offensive Security Bugs](https://bugs.kali.org)
[Offensive Security Train](https://kali.training)

[[Man-Pages]]
Info Documents : `apt install pinfo`

```bash
apt show package # useful package infomation for troubleshooting and online referencing
man 
apropos # For help with finding the man page related to argument provided
# Package specific documentation
ls /usr/share/doc/package/
```


## Installation

One thing to consider is preseeding an unattended installation for ultimate customisability, another being the recent additions of metapackages to `apt instal kali-<metapackage>` that are catergorisation of tools themed by task.

[Download from this site.]([https://www.kali.org/downloads/](https://www.kali.org/downloads/) Use `cat /proc/cpuinfo` or this fancy grep(`grep -qP '^flags\s*:.*\blm\b' /proc/cpuinfo && echo 64-bit || echo 32-bit`) to check whether you are have 32 or 64 bit CPU. Make sure verify integrity and authenticity with  `sha256sum $ISO`. You could also use a key server: `wget -q -O - https://archive.kali.org/archive-key.asc | gpg --import`. There are various GUI tools on all OS for USB formating and creating bootable disks, but here with a Linux Distro:
```bash
# be root
dmesg # kernel logs - find your device
dd if=$SIO of=/usb/dir
```

Kali can be botted in UEFI mode but not secure boot. Disable secure boot.

## Post-Installation

As Kali uses Debian package management - see [[Debian-Package-Management]]. `dpkg`  informs Kali's structuring. Debian and Kali use three sections to differentiate packages according to the licenses chosen by the authors of each work. A difference between Debian and Kali is that, Debian only has main enabled by default, whereas Kali has all three enabled by default. `main` the Debian default enabled;  `non-free` archive is different because it contains software that does not (entirely) conform to these principles but which can nevertheless be distributed without restrictions; `contrib` (contributions) is a set of open source software that cannot function without some non-free elements, which include `non-free` section files or free software whose compilation requries proprietary elements. For example Kali `/etc/apt/sources.list`:
```
# Main Kali repository
deb http://http.kali.org/kali kali-rolling main contrib non-free
```

For the most part the indirect use of debian package manager with `apt` seem the most simple way to approach package management on Kali.
```bash
apt
apt-get # refuses to install packages that are not preinstalled
apt update
apt upgrade
apt full-upgrade # For major updates
apt-get dist-upgrade # apt-get version of full-upgrade
apt install # indirect use of debian package manager to install packages
apt-listchanges # displays information about possible problems at the beginning of a package upgrade
apt install $package $package- # "-" for remove
apt remove $package+ $package # "+" for install
apt purge $package # completely remove package and data 
apt install -o Dpkg::Options::="--force-overwrite" $package

apt search
apt remove
```

Kali Guidelines of upgrading - generally recommend that you upgrade Kali at least once a week
-   When you are aware of a security issue that is fixed in an update.
-   When you suspect that an updated version might fix a bug that you are experiencing.
-   Before reporting a bug to make sure it is still present in the latest version that you have available.
-   Often enough to get the security fixes that you have not heard about.
And not upgrading
-    If you can't afford any breakage 
-    If a disruptive change happened recently and you fear that all issues have not yet been discovered
-    If the `apt full-upgrade` output tells you that it will remove packages that you consider important for your work


#### Configuration

For general configuration hub pages see [[Kali-Configuration]] and general CLI interaction for basics see [[Kali-CLI-Basics]]. For using Python2: [EoL Python ](https://www.kali.org/docs/general-use/using-eol-python-versions/), see [[Python-Tooling-Libraries]] for full setup! 

#### Securing and Monitoring

- **If it is not in use - DISABLE IT** - If it is disabled it does not pose a security threat.
- There is no default firewall, if the service listens on all network interfaces it publicly available.
	- Kali's Linux kernel embeds the netfilter firewall - **beware** it has no easy setup and **MUST** be configured in  user space with the `iptables` and `ip6tables` commands. 
- Some services have no authentication credentials 
- Some services have default credentials - (re)set any password
- Some services run as root - reconfigure to not 

Always read the `README.Debian`, the [kali.org/docs](https://www.kali.org/docs/introduction/default-credentials/) and [tools.kali.org](https://tools.kali.org/)

Consider setting up a [Security Policy]([[Security-Policies]]), review [[Kali-Hardening]] and [[Securing-Network-Services]]. For firewall configuration visit [[ufw]] page, while reviewing [[Firewalls]]. There is also the GUI `fwbuilder` tool used in conjunction with understanding of [[Netfilter]] using [[ipXtables]] commands.

In order to implement the firewall rules each time the machine is booted, you will need to register the configuration script in an `up` directive of the `/etc/network/interfaces` file with the script store for example `/usr/local/etc/$hostname.fw` - consdier the command used to configure  the network interfaces!

Offensive Security promote the use of the `logcheck` package  not installed by default. Considerations:
- list of monitored files is stored in `/etc/logcheck/logcheck.logfiles`
- Default values stored in `/etc/rsyslog.conf` - defaults are good unless file has not been completely overhauled.
- Levels of detail `paranoid`, `server` and `workstation` - each should be be customized to exclude some extra messages (depending on installed services), unless you really want to receive hourly batches of long uninteresting emails
- The message selection mechanism is complex - found `/usr/share/doc/logcheck-database/README.logcheck-database.gz` is a difficult required read.
TL;DR regarding applied rules can be split into several types:
-   Those that qualify a message as a cracking attempt (stored in a file in the `/etc/logcheck/cracking.d/` directory).
-   Ignored cracking attempts (`/etc/logcheck/cracking.ignore.d/`). - Ignore messages
-   Those classifying a message as a security alert (`/etc/logcheck/violations.d/`).
	- Can only be ignored by a rule in a `/etc/logcheck/violations.ignore.d/myfile` or `/etc/logcheck/violations.ignore.d/myfile-extension` file.
-   Ignored security alerts (`/etc/logcheck/violations.ignore.d/`).
- Everything else is system events
	- A system event is always signaled unless a rule in one of the `/etc/logcheck/ignore.d.{paranoid,server,workstation}/` directories states the event should be ignored.

Offensive Security suggest the use of `top` as an interactive tool that displays a list of currently running processes. But you could use attacker tools like [pspy](https://github.com/DominicBreuker/pspy)

Auditing packages with `dpkg --verify / -V` and check the in md5sums between what is on the machine and  what should be on the machine.

For monitoring files: The Advanced Intrusion Detection Environment (AIDE) tool checks file integrity and detects any change against a previously-recorded image of the valid system, installed with `apt install aide`.

The checksecruity scripts - `chkrootkit` and `rkhunter` packages detect certain rootkits potentially installed on the system - testing may not be reliable as rootkits are designed to hide.

## Creating Images

## Service Related Service Setups/Points of Interest

[[Kali-Setup-Docker]]
[[Kali-Windows-Resources]]

## Communities

[Official forums](https://forums.kali.org/) and the [Rules](https://www.kali.org/docs/community/kali-linux-community-forums/) 
`#kali-linux` channel on the[IRC Channel](https://webchat.otfc.net/) , [Web-based Client](https://webchat.otfc.net/) and [Rules](https://www.kali.org/docs/community/kali-linux-irc-channel/)

## Bug Reporting

Official Recommendations:
- Double check before filing bug reports against Debian
	- Who maintains it really?! If it is a straight import from Debian
		- Use a Debian Client to test - https://www.debian.org/devel/debian-installer/
		- Use `reportbug` command within Debian Client
		- send an email (with a special syntax) to `submit@bugs.debian.org`
	- Else if its Kali related then use the web-based bug tracker at https://bugs.kali.org/
- Write the report in English
- Be repectful of Developers' work
- Be reactive and ready to provide additional information
- Provide:
	- Instruction to reproduce the problem
	- Give context and set your expectations
	- Be specific
	- Mention possible fixes or workarounds
	- Log bug reports are fine - if really long provide summary
- Avoid filing duplicate bug reports
- Ensure you use the latest version
- Do not mix multiple issues in single bug report


## References

[Offical Documentation Queries Site: https://www.kali.org/docs/](https://www.kali.org/docs/) 
[EoL Python ](https://www.kali.org/docs/general-use/using-eol-python-versions/)
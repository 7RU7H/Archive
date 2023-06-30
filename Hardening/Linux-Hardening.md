# Hardening

## Physical Security

[[Physical-Security]] for your Linux machine...

Encrypt your drives. Defense in depth; depth being analogus to wasting the time of the attacker.  

GRUB password with [PBKDF2](https://en.wikipedia.org/wiki/PBKDF2)
```bash
# This hash is added to a config
grub2-mkpasswd-pbkdf2
```

For [[Kali-Hardening]] LVM encryption is avaliable preinstall.


## Snort

[Snort](https://www.snort.org/faq/what-is-snort) - consider [[Snort]] article locally - *"Snort is an open source network intrusion prevention system, capable of performing real-time traffic analysis and packet logging on IP networks. It can perform protocol analysis, content searching/matching, and can be used to detect a variety of attacks and probes, such as buffer overflows, stealth port scans, CGI attacks, SMB probes, OS fingerprinting attempts, and much more."*


## Fail2Ban

[Fail2ban](https://github.com/fail2ban/fail2ban) "*scans log files like `/var/log/auth.log` and bans IP addresses conducting too many failed login attempts. It does this by updating system firewall rules to reject new connections from those IP addresses, for a configurable amount of time. Fail2Ban comes out-of-the-box ready to read many standard log files, such as those for sshd and Apache, and is easily configured to read any log file of your choosing, for any error you wish."*

## AppArmor

[AppArmor](https://apparmor.net/): *"AppArmor is an effective and easy-to-use Linux application security system. AppArmor proactively protects the operating system and applications from external or internal threats, even zero-day attacks, by enforcing good behavior and preventing both known and unknown application flaws from being exploited. AppArmor supplements the traditional Unix discretionary access control (DAC) model by providing mandatory access control (MAC). It has been included in the mainline Linux kernel since version 2.6.36 and its development has been supported by Canonical since 2009."*

[AppArmor](https://www.apparmor.net/) can be used for more granular control over processes and their host and network access
```bash
aa-status 
sudo journalctl -fx
```


## SELinux 

[SELinux](https://github.com/SELinuxProject) can be used for more granular control over processes and their host and network access

## Softblock wifi and bluetooth

To Hardblock wifi or Bluetooth find the toggle on motherboards, in bioses and other switches on peripherals.   
```bash
rfkill list
rfkill block wifi
rfkill block bluetooth
```

## SSH Related

[SSH](https://linuxhint.com/disable_root_ssh_debian/)

Helpful connect unwanted ssh connections back to there machine lol. 
```bash
socat -d -d TCP-L:22,reuseaddr,fork SYSTEM:"nc \\$SOCAT_PEERADDR 22
```

SSH Keys 

[ssh tarpit](https://github.com/skeeto/endlessh)

## Iptables

Log new connections to a box [Ippsec](https://www.youtube.com/watch?v=ABVR8EgXsQU&t=186)
```bash
iptables -A INPUT -p tcp -m state --state NEW -j LOG --log-prefix "IPTables New-Connection: " -i $interface
```

## Stop Sneaky, Fast Execution!

[/dev/shm is a common directory for marshalling and operating from in Linux for attackers as it directory that is a temporary file storage that uses RAM for the backing store](https://superuser.com/questions/45342/when-should-i-use-dev-shm-and-when-should-i-use-tmp. It is flushed leaving no trace of execution or what was put in that directory. It is also faster as than disk storage.
```bash
sudo mount -o remount,noexec /dev/shm
mount | grep shm # to check flags
```


## Filesystem 

Modern \*nix ship  with LUKS (Linux Unified Key Setup), from [THM](https://tryhackme.com/room/linuxsystemhardening) :
*"Most distributions let you encrypt a drive using a graphical interface. However, if you would like to set up LUKS from the command line, the steps are along these lines:*"
- Install `cryptsetup-luks`. (You can issue `apt install cryptsetup`, `yum install cryptsetup-luks` or `dnf install cryptsetup-luks` for Ubuntu/Debian, RHEL/Cent OS, and Fedora, respectively.)
- Confirm the partition name using `fdisk -l`, `lsblk` or `blkid`. (Create a partition using `fdisk` if necessary.)
- Set up the partition for LUKS encryption: `cryptsetup -y -v luksFormat /dev/sdb1`. (Replace `/dev/sdb1` with the partition name you want to encrypt.)
- Create a mapping to access the partition: `cryptsetup luksOpen /dev/sdb1 EDCdrive`.
- Confirm mapping details: `ls -l /dev/mapper/EDCdrive` and `cryptsetup -v status EDCdrive`.
- Overwrite existing data with zero: `dd if=/dev/zero of=/dev/mapper/EDCdrive`.
- Format the partition: `mkfs.ext4 /dev/mapper/EDCdrive -L "Strategos USB"`.
- Mount it and start using it like a usual partition: `mount /dev/mapper/EDCdrive /media/secure-USB`.

Encrypting a USB flash memory - [THM](https://tryhackme.com/room/linuxsystemhardening) :
```bash
# List USB drives
sudo lsblk
# Locate/print block device atttributes
sudo blkid
# With verbose cryptsetup verify passphrase 
sudo cryptsetup -y -v luksFormat /dev/sdb1
# open a LUKs device <device> <name>
sudo cryptsetup luksOpen /dev/sdb1 EDCdrive
# make ext4 filesystem - 2 and 3 are avaliable
sudo mkfs.ext4 /dev/mapper/EDCdrive -L "Strategos USB"
# Mount USB
sudo mount /dev/mapper/EDCdrive /media/secure-USB
# Check Settings:
sudo cryptsetup luksDump /dev/sdb1
```
For more related USB topic consider [[USB-Maintenance]]

Single file encryption and decryption
```bash
# count=$x is MBs in size!
# ext4 does not support <= 32MB
dd if=/dev/zero of=cryptfile.img bs=1M count=64
# Format it providing a passphrase
sudo cryptsetup luksFormat cryptfile.img
# Bind file to a block device for manipluation like a partition
sudo cryptsetup luksOpen cryptfile.img cryptdev
# Create a filesystem at the device block
sudo mkfs.ext4 /dev/mapper/cryptdev
# Close deviuce
sudo cryptsetup luksClose cryptdev

# Decrypt
sudo cryptsetup open --type luks $encryptedFile.img $decryptName
# Mount to a directory
mkdir -p cryptdir
sudo mount -t auto /dev/mapper/cryptdev cryptdir
# Unmount and close
sudo umount cryptdir
sudo cryptsetup luksClose cryptdev
```

Create a /etc/cryptmount/cmtab file user config - `cryptmount` allows us to mount configured encrypted files without root permissions.
```bash
mycryptlabel {
    dev=$(HOME)/cryptfile.img
    dir=$(HOME)/cryptdir
    fstype=auto
    keyformat=luks
}
```

Private mount namespace, mount and unmount
```bash
# Create private mountspace
sudo unshare -m sudo -u "$USER" -i
# mount
cryptmount mycryptlabel
# unmount
cryptmount -u mycryptlabel
```

## Firewalls

Proper implementation of Linux [[Firewalls]] to prevent adversaries [[Evading-Firewalls]] requires firstly a Firewall and a ruleset. Some of the security risk is mitigate by defining controls over acceptable network traffic, what packets from specific ports are allowed to leave a machine or be accepted at a recieve port and preventing clients functioning as a servers. Therefore considerations on a ruleset are critical as to Allow, Deny or Reject:
- What should enter the network 
- What should leave the network

Stateless Firewalls inspect specific IP and TCP/UDP Header fields:
- Filtering IP based on:
	- Source IP address
	- Destination IP address
- Filtering on TCP/UDP Header
	- Source TCP/UDP port
	- Destination TCP/UDP port

Prior to utilizing a solution, deciding on a firewall policy or an enforcer of an existing security policy that covers firewall configuration. Although their are advocates for either really it is a lesser of two evils to pick the first:
- Block everything and allow certain exceptions.
- Allow everything and block certain exceptions.

My reasoning being that to do so firstly in the long term is less work, in the short and long term you will have great understanding of Linux networking and exceptions require visibility. Hindsight is painful an exception is an exemption from what you were monitoring.

Netfilter hooks require a front-end like `iptables` see [[ipXtables]] for futher usage
```bash
# A generally good idea would to blacklist and then open ports one at a time on use, especially if they are below 1024 as root is require to bind to those ports.  
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT
# Flush rules
iptables -F 
# List all rules
iptables -L
```

Netfilter hooks require a front-end like `fwfilter`
```bash
# Create a table called fwfilter
nft add table fwfilter
# Add an input chain
nft add chain fwfilter fwinput { type filter hook input priority 0 \; }
# Add an output chain
nft add chain fwfilter fwoutput { type filter hook output priority 0 \; }
# Add allow rule for ssh traffic
nft add fwfilter fwinput tcp dport 22 accept
nft add fwfilter fwoutput tcp sport 22 accept
# List fwfilter
nft list table fwfilter
```

For the uncomplicated amongst us there is `ufw` - [[ufw]], [Uncomplicated Firewall (ufw)](https://wiki.ubuntu.com/UncomplicatedFirewall)

## Remote Access

To harden Linux remote access we must try defend against:
- Brute Force and guess of passwords
- Password sniffing
- [[MITM-Attacks]] over the network

Sometimes it pays to think similarly to protercting a domain controller, which do you actually need remote access to a machine? Data in transit by design has to be parsed at the intended endpoint even if it is encrypted. With sniffed encrypted data all it then takes is to retroactively decrypt with any keys used and patience was really the only barrier to the attacker. If you do need remote access:
- Do not connect over WIFI or Bluetooth, absolutely not public
- Use MFA were possible
- Passphrase that are long and strong that memberable 
	- Take care making passsphrase that reference interests that you can be profiled for through OSINT you from social media by attackers 
- Use encrypted protocols to remotely connect
- Use [[Tor-Hidden-Services]] or [[IPsec]] - require your own hosting and maintaining your own infrastructure 
- Disable Root/Administrator remote access
	- In `/etc/ssh/sshd_config`
	 - [Deny RDP or other protocols for Administrators Group](https://learn.microsoft.com/en-us/troubleshoot/windows-server/remote/deny-user-permissions-to-logon-to-rd-session-host)
- Use RSA keys for ssh, see [[SSH-Cheatsheet]] - `ssh-keygen -t rsa` 
- Use [[Cryptography]] - `openssl` for key generation 

## Sudo / Doas

Perform as command that follows the `sudo` instruction with root privileges with granular rules if configured. This is possible the most difficult to get right as administrator as sudo is both complex and its use and uses one wants to prevent is non-trivial problem.
```bash
# Add to the sudo group
sudo -aG sudo $username
# Some Arch, Fedora and RedHat has the Wheel group instead
sudo -aG wheel $username

# Disable root or any unused accounts
sudo sed -i 's@root:x:0:0:root:/root:/bin/bash@root:x:0:0:root:/root:/sbin/nologin@g' /etc/passwd

# Password policy configuration files
apt-get install libpam-pwquality
# RedHat and Fedora 
/etc/security/pwquality.conf
# Debian and Ubuntu
/etc/pam.d/common-password
```

libpam-pwquality configuration:
```bash
sudo cat /etc/security/pwquality.conf
difok=5 # specify number of characters that were not present in the last password
minlen=10 # minimum length
minclass=3 # minimum classes of characters - lowercase, uppercase, digits, symbols ...
badwords=(space seperated list of words that should be used in passwords)
retry=2 # retry prompt amount
```

Prevent Wildcard abuse of sudo 
```bash
ls -la /etc/sudoers.d 
sudo vim $USER
# Instead *
sed 's/*/[a-zA-Z0-9_-]/g' /etc/sudoers.d/$USER
```

## Sofware and Services

- Do not run services as root
- Disable Unnecessary services
- Block unneeded network ports
- Avoid Legacy Protocols
	- If it is not encrypted do not use it
- Remove Identification Strings 
	- Version numbers
	- OS type and version

## Update and Upgrade Policy

- Keep your system updated with the latest security patches and bug fixes.
- Upgrade to OS to LTS when current OS no longer is supported
	- [The Ubuntu lifecycle and release cadence](https://ubuntu.com/about/release-cycle).
	- RedHat Enterprise Linux 8 and 9 offer 12 years of support in three phases:
		1. Full Support for five years
		2. Maintenance Support for five years
		3. Extended Life Phase for two years
		4. [Red Hat Enterprise Linux Life Cycle](https://access.redhat.com/support/policy/updates/errata/)
- Update the Kernel

## Logging 

[CrowdStrike:](https://www.crowdstrike.com/guides/linux-logging/advanced-concepts/) *"Linux uses a daemon called rsyslogd to process messages using the syslog protocol. This service evolved from the regular syslog daemon to the current enterprise-level logging system."* Its configuration file can be found at `/etc/rsyslog.conf` on Red Hat, Debian-based including [[Kali]], and Fedora. Its directives are located in `/etc/rsyslog.d/*.conf`

[CrowdStrike example of writing kernel logging with an alert level then forwarding to a remote host](https://www.crowdstrike.com/guides/linux-logging/advanced-concepts/) 
```bash
# Write kernel logs to file
kern.* /var/log/kern
# Everybody gets emergency messages
*.emerg *
# Forward all messages to another host to be processed by that remote host’s syslog daemon
*.* @@remote-host:514
```

For [[Debian-Package-Management]] [logcheck](https://www.debian.org/doc/manuals/securing-debian-manual/log-alerts.en.html) for alerting

- General System messages
	-  `/var/log/messages` 
	- `/var/log/syslog` - [Ubuntu](https://help.ubuntu.com/community/LinuxLogFiles)  
- User related messages 
	- Authentication attempts
		-  `/var/log/auth.log` - Debian based 
		-  `/var/log/secure` - Red Hat and Fedora-based 
	- Current users logged in
		-  `/var/log/utmp`
	- Users logged in and out
		-  `/var/log/wtmp`
		- `/var/log/lastlog` - Ubuntu, Fedora
	- Failed Logins
		- `/var/log/btmp`
- Kernel messages
	 -  `/var/log/kern.log`
- Start-up messages and boot information 
	-  `/var/log/boot.log`
- Device Driver messages
	- `/var/log/dmesg`
- Debug
	- `/var/log/debug`
- Package Management
	- [[APT-And-Other-Non-Host-Distributions]]
		- `/var/log/apt/history.log` - command history
		- `/var/log/apt/term.log` - terminal output

## Distribution Specific Guides

- [Fedora](https://docs.fedoraproject.org/en-US/fedora/17/html/Security_Guide/chap-Security_Guide-Basic_Hardening.html)
- [[Kali-Hardening]]
- [Debian ](https://www.debian.org/doc/manuals/securing-debian-manual/)

- Consideration to add on research... 
	- [Exec Shield](https://en.wikipedia.org/wiki/Exec_Shield) 

## References

[lpenz](http://www.lpenz.org/articles/luksfile/)
[THM Room Linux System Hardening](https://tryhackme.com/room/linuxsystemhardening)
[Ippsec geniunely rocks](https://ippsec.rocks/?#)
[@climagic](@climagic)
[Fedroa Hardening Guide](https://docs.fedoraproject.org/en-US/fedora/17/html/Security_Guide/chap-Security_Guide-Basic_Hardening.html)
[PBKDF2](https://en.wikipedia.org/wiki/PBKDF2)
[https://linux.die.net/man/8/cryptsetup](https://linux.die.net/man/8/cryptsetup)
[https://linux.die.net/man/8/cryptmount](https://linux.die.net/man/8/cryptmount)
[https://willhaley.com/blog/encrypted-file-container-disk-image-in-linux/](https://willhaley.com/blog/encrypted-file-container-disk-image-in-linux/)
[AppArmor](https://www.apparmor.net/) 
[SELinux](https://github.com/SELinuxProject)
[Red Hat Enterprise Linux Life Cycle](https://access.redhat.com/support/policy/updates/errata/)
[Ubuntu lifecycle and release cadence](https://ubuntu.com/about/release-cycle)
[Microsoft Learn](https://learn.microsoft.com/en-us/troubleshoot/windows-server/remote/deny-user-permissions-to-logon-to-rd-session-host)
[Ubuntu](https://help.ubuntu.com/community/LinuxLogFiles)  
[logcheck](https://www.debian.org/doc/manuals/securing-debian-manual/log-alerts.en.html)
[Debian Hardening Guide](https://www.debian.org/doc/manuals/securing-debian-manual/)
[ippsec.rocks](https://ippsec.rocks)
[Uncomplicated Firewall (ufw)](https://wiki.ubuntu.com/UncomplicatedFirewall)
[Snort](https://www.snort.org/faq/what-is-snort) 
[Fail2ban](https://github.com/fail2ban/fail2ban)
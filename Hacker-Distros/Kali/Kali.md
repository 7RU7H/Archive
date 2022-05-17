# Kali

## Introduction
Kali Linux is Debian GNU/Linux Linux distributio, which is probably the defacto Enterprise-ready standard for security auditing with the tagline: "the quieter you become, the more you are able to hear". First released in March 2013 to then use a Rolling release model on 21st January, 2016 to present.

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

## Installation

[Download from this site.]([https://www.kali.org/downloads/](https://www.kali.org/downloads/) Use `cat /proc/cpuinfo` or this fancy grep(`grep -qP '^flags\s*:.*\blm\b' /proc/cpuinfo && echo 64-bit || echo 32-bit`) to check whether you are have 32 or 64 bit CPU. Make sure verify integrity and authenticity with  `sha256sum $ISO`. You could also use a key server: `wget -q -O - https://archive.kali.org/archive-key.asc | gpg --import`. There are various GUI tools on all OS for USB formating and creating bootable disks, but here with a Linux Distro:
```bash
# be root
dmesg # kernel logs - find your device
dd if=$SIO of=/usb/dir
```

Kali can be botted in UEFI mode but not secure boot. Disable secure boot.

## Post-Installation

If for some reason use need Python2: [EoL Python ](https://www.kali.org/docs/general-use/using-eol-python-versions/)



```

## Configuration

## Kali-Unique Linux 

## Securing

## Monitoring

## Creating Images


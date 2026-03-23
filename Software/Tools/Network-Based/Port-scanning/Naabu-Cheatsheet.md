# Naabu Cheatsheet

[naabu](https://github.com/projectdiscovery/naabu) is a fast port scanner written in go with a focus on reliability and simplicity. Designed to be used in combination with other tools for attack surface discovery in bug bounties and pentests.

-   Fast And Simple **SYN/CONNECT** probe based scanning
-   Optimized for ease of use and **lightweight** on resources
-   **DNS** Port scan
-   **Automatic IP Deduplication** for DNS port scan
-   **IPv4/IPv6** Port scan (**experimental**)
-   **Passive** Port enumeration using Shodan [Internetdb](https://internetdb.shodan.io)
-   **Host Discovery** scan (**experimental**)
-   **NMAP** integration for service discovery
-   Multiple input support - **STDIN/HOST/IP/CIDR/ASN**
-   Multiple output format support - **JSON/TXT/STDOUT**
-   Custom Configs -  `$HOME/.config/naabu/config.yaml`, define any flag in the config file and set default values to include for all scans.

Developer Notes:
-   Naabu allows arbitrary binary execution as a feature to support [nmap integration](https://github.com/projectdiscovery/naabu#nmap-integration).
-   Naabu is designed to scan ports on multiple hosts / mass port scanning.
-   As default naabu is configured with a assumption that you are running it from VPS.
-   We suggest tuning the flags / rate if running naabu from local system.
-   For best results, run naabu as **root** user. 



## Cheatsheet

CTF full port one-liner
```bash
# Beware Speed/Accuracy Loss - defaults listed below:
naabuRate=1000
workers=25
nmapRate=# None
# naabu -i and nmap -e to specify interface
# Reduce idiocy - ie no vpn up, no scan
interface=tun0
# add -v flag for naabu verbosity - does not do anything in 2.0.5
# add -stats for time, PPS, packets percentage 
sudo naabu -host 10.10.10.10 -p 0-65535 -i $interface -c $workers -rate $naabuRate -nc -o naabu/10-10-10-10-allports -nmap-cli 'nmap -sV -sC --min-rate $nmapRate -e $interface -oN nmap/from-naabu-some-ports-sc-sv'
```


## nmap-cli or nmap later

Consider both, but remember slow port scanning is more accurate. Also nmap-cli for naabu is dependent on the results naabu. You can add `-p` related flags in the `-nmap-cli` string.

- Note I will test through a proxy at some point in the near future. 


## Installation

[Naabu on Kali](https://www.kali.org/tools/naabu/) - is behind master branch so some features do not exist

## Usage

```bash

```
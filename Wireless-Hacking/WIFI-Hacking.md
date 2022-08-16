# WIFI Hacking

## Gear
Given that you may not have network card that has monitor mode:
Recommended Adapters:  
Alfa Tube U: [https://amzn.to/3Q8Togp](https://amzn.to/3Q8Togp)  
Alfa AWUS036NHA: [https://amzn.to/3wnyVen](https://amzn.to/3wnyVen)  
Alfa AWUS036ACM: [https://amzn.to/3fCL4WT](https://amzn.to/3fCL4WT)  
Alfa AWUS036ACH: [https://amzn.to/3rLAjny](https://amzn.to/3rLAjny) or [https://amzn.to/2PxkkMV](https://amzn.to/2PxkkMV)

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

## Checks and Airmon-ng

First Check adapter configuration, then check again after running `airmon-ng`
```bash
iwconfig
airmon-ng start wlan0
iwconfig
```



## References
[THM Room](https://tryhackme.com/room/wifihacking101)
[David Bombal](https://davidbombal.com/hack-wifi-from-1-80/)
[medium Fabian Voith](https://fabian-voith.de/2020/04/22/get-alfa-awus036ach-usb-nic-running-on-kali-vm-to-attack-wireless-networks/)
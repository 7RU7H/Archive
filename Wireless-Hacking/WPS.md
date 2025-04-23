# WPS

[HackTheBox WPS Pin Attacks - Blog - BEWARE Spoilers for HTB Retired Machines after section: Exploiting WPS in practice](https://www.hackthebox.com/blog/wps-pin-attacks-and-cracking-wps-with-reaver)  *"Wi-Fi Protected Setup (WPS), sometimes referred to as Wi-Fi Simple Configuration (WSC), is a network standard and protocol that allows devices to join a Wi-Fi network without using the network’s key... WPS uses the IEEE 802.11 and [Extensible Authentication Protocol](https://learn.microsoft.com/en-us/windows-server/networking/technologies/extensible-authentication-protocol/network-access?tabs=eap-tls%2Cserveruserprompt-eap-tls%2Ceap-sim) (EAP) protocols for discovery and configuration"*


WPS:
- Enrollee: device to connect to network
- Registrar: devices responsible for handling authentication and configuration
	- AP can support External Registrars
- Access Point (AP) abstraction allowing for communication between Enrollees and Registrars
- Push Button Configuration (PBC)
- PIN Entry: 8 digit pin - vulnerable to [[Brute-Force-Attacks]] see [[WiFi-Hacking]]
	- Split into two 4 digit keys 
	- Last digit of the 8 digit PIN or second key is a checksum 
	- Both Enrollees and Registrars can check whether the 1st Half is incorrect
		- Registrar receives a NACK after 
			- the M4 message = the first half of the PIN is incorrect  
			- the M6 message = the second half is incorrect.
	- PIN permutations
		- 10^4; 10k
		- 10^3; 1k
	- [PDF Stefan Viehböck 2011 PoC ](https://sviehb.files.wordpress.com/2011/12/viehboeck_wps.pdf)
## References

[HackTheBox WPS Pin Attacks - Blog - BEWARE Spoilers for HTB Retired Machines after section: Exploiting WPS in practice](https://www.hackthebox.com/blog/wps-pin-attacks-and-cracking-wps-with-reaver) 
[learn.microsoft - IEEE 802.11 and Extensible Authentication Protocol](https://learn.microsoft.com/en-us/windows-server/networking/technologies/extensible-authentication-protocol/network-access?tabs=eap-tls%2Cserveruserprompt-eap-tls%2Ceap-sim)
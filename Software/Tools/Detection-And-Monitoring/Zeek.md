# Zeek

[The official description of Zeek (formerly Bro)](https://docs.zeek.org/en/master/about.html): *"Zeek (formerly Bro) is the world's leading platform for network security monitoring. Flexible, open-source, and powered by defenders... Zeek is a passive, open-source network traffic analyser. Many operators use Zeek as a network security monitor (NSM) to support suspicious or malicious activity investigations. Zeek also supports a wide range of traffic analysis tasks beyond the security domain, including performance measurement and troubleshooting."* [Open-source and Commercial version exist the differences outllined in this link](https://corelight.com/products/compare-to-open-source-zeek?hsLang=en)

- [Zeek Architecture](https://docs.zeek.org/en/master/about.html#architecture)
	- Event Engine
		- Processes packets that then forwarded to the Policy Script interpreter
	- Policy Script Interpreter
		- Semantic Analysis of pre-processed packet data
		- Event Correlation utilizing Zeek's custom scripting language's `event handlers`
			- Script can express a site's security policy  - if X, what should then be done
	- Output from Policy Script Interpreter go to:
		- Logs
		- Notifications

## Zeek and Snort Comparison

- Focus 
	- [[Zeek]]: NSM and IDS through network analysis with detection for alerts that triggered by events 
	- [[Snort]] : IDS/IPS signature-based detection 
- Common Use  
	- [[Zeek]]: Network Monitoring, traffic investigation and detecting chained event
	- [[Snort]] : Itrusion detection and prevention to stop the known threats and attacks

```bash
zeek -h
zeekctl help
```

## References

[THM Zeek Room](https://tryhackme.com/room/zeekbro)
[Zeek Documentation](https://docs.zeek.org/en/master/about.html)
[Open-source and Commercial Zeek version comparison](https://corelight.com/products/compare-to-open-source-zeek?hsLang=en)
[Zeek Architecture](https://docs.zeek.org/en/master/about.html#architecture)
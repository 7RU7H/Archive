# Intrusion Detection Systems (IDS)

Intrusion Detection System (IDS) is a system that detects unauthorised network and system intrusions. Examples include detecting unauthorised devices connected to the local network and unauthorised users accessing a system or modifying a file.

## Types of IDS:

#### Network Intrusion Detection Systems (NIDS)
- Monitors traffic flow from various part of the network
- Investigate traffic on the entire subnet
- If a signature is identified creates an alert 

#### Host-Based  Detection Intrusion System (HIDS)
- Monitor single endpoint device
- Investigate traffic on said endpoint
- If a signature is identified creates an alert 

## Detection types:

- Signature-based: Signatures of known malicious traffic fed into IDS.
- Anomaly/Behaviour-based: Regular traffic model, for IDS to detect anomalies.
- Policy-based: Detect based on policy violations
- Hybrid Models

## Tools

[[Snort]]

## Hacking IDS

[[Evading-IPS-And-IDS]] and [[IDS-Evasion]]

## References

[THM Room IDS Fundamentals](https://tryhackme.com/room/idsfundamentals)
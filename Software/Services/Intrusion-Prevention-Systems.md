# Intrusion Prevention Systems (IPS)

Intrusion Prevention System (IPS) is a device or application that detects and stops intrusions attempts proactively. They are usually deployed in front of the protected asset and block any potential threat from reaching their target.

## Types of IPS:

#### Network Intrusion Prevents System (NIPs)
- Monitors traffic flow from various parts of the network
- Protect the traffic on entire subnet
- If a signature is identifed the connect is terminated

#### Behaviour-Based Intrusion Prevention System (Network Behaviour Analysis - NBA)
- Behaviour-based system monitor the traffic flow from various parts of the network
- Protect the traffic on entire subnet
- If a signature is identifed the connect is terminated

Bundled with **Network Behaviour Analysis System** 
- Similar to NIPs but requires  "baselining" - a training period to learn normal traffic and differentiate the malicious traffic and threats.
- Trained period helps avoid false positives and recognise benign activities

#### Wireless Intrusion Prevention System (WIPS)
- Monitors the traffic flow from wireless network
- Protect the Wireless traffic 
- Stop attacks lauched from Wireless traffic

#### Host-Based Intrusion Prevention System (HIPS)
- Hips actively protect from a single endpoint device
- Investigate the traffic on a particular device
- If a signature is identifed the connect is terminated

HIPS is similar to HIDS, HIPs instead stop the threats by terminating connect whereas HIDS creates alerts for the threats.

## Detection types:

Signature-based: Signatures of known maliciou traffic fed into IDS.
Anomaly/Behaviour-based: Regular traffic model, for IDS to detect anomalies.
Policy-based: Detect based on policy violations

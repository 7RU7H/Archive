# Quantum Hacking

This page is based on notes taken from the follow Lectures: [Quantum hacking - Vadim Makarov Lecture Part 1](https://www.youtube.com/watch?v=2r7B8Zpxmcw), [Lecture: ] and [Lecture: ]

Quantum Hacking is:
- Discovering vulnerabilities
- Demonstrate attacks
- Develop counter measures
- Eliminating imperfections

Quantum Computers are fundamentally made, exist and secured by:
- Law of Physics 
- Model of Equipment that components on a device consider a Quantum Computer
- Security Proofs


Security Model of Quantum Key Distribution
- Alice and Bob comply by the protocol (both measuring a transferred data that has a QBER) to then produce a private key
- Secret key R = `f(QBER)
- Quantum Bit Error Rate

The Model of Equipment is idealised out of necessity and the actual (each Quantum computer) has its own complexities: 
- Imperfections
- Modes of preparation

So ultimately without absolute exact physical data-fingerprint of a Quantum Computer through time, to hack a Quantum Computer is task of analysing the Security Proof and Model of the Equipment for differences in the Model of Equipment used by `Alice` and `Bob`

```
Hack -> Integrate imperfection into security -> Model of Equipement --
^---------------------------------------------------------------------
```
Sometimes the security proof needs updating..


#### Commercial QKDs (2014)

Classical encryptors:
- L2, 2 Gbit/s
- L2 10 Gbits/s
- L3 VPN, 100 Mbit/s

WDMs

Key Manager

QKD to another node (4km)

QKD to another node (14km)


Quantis RNG simply (copied from [Quantum hacking - Vadim Makarov Lecture Part 1](https://www.youtube.com/watch?v=2r7B8Zpxmcw))

- Weak Coherent Light source `->`
- `->` `[/]` 50/50 Beam splitter to make physically random decision) 
	- photon will go depending on its photon number (if small number (close to single photon))
- `->` pair of Photon detectors `-D` 
	- Both `-D` `->` converge on:
- Simple device that captures the `[Clicks Processed]` that outputs `->` a `Random Stream` 

#### Question Based Hacking a QKD, Quantum Computers, etc

- True Randomness?
	- Quantis RNG `->` FPGA `->` Phase modulator in Bob (id Quantique Clavis2 (2008))
		- For each `->` how is it implemented such that it safely and security prevents our Objective
	- Is there sequential randomness (of data) at each level of abstraction? 
- Can we trust the Manufacture?
	- Human will be Humans to other (h/'/H `||!?` )umans and Monkeys are just sign language experts without Lab coats.
	- Has the manufacturer:
		- Tapped the device to record the stream for playback?
		- Added a pre-recorded random sequence generator and a switch?
		- With [[Firmware-Extraction]] is there malicious code
		- Is the Quantis RNG device isolated from [[Side-Channel-Attacks]]
		- Is there a hardcoded secrets?
		- Has manufacturer susceptible to Hardware or [[Software-Supply-Chain-Attacks]]?


#### Double Click attacks


Occur naturally of detector dark counts, multi-photon pulses... Discard them? Intercept-resend attack... with a twist:
```
Alice -->[Eve [Bob'] [Alice'] ] --> 100 photons --> Bob chooses the detection basis so that either (how many discards?):

1. Bob: detects in Eve's Basis: single click
2. Bob: detects in conjugate nasis: double click, discard
```
Proper treatment for double clicks: assign a random bit value.

#### Trojan Horse Attacks

- All Optical components will have some back-reflection

If we capture the back reflection we can store and read data still we decode transmission

In this example Alice does not measure the Quantum states being transmitted
![](quantum-trojan-horse-attack-MAKAROV.png)

The research group mapped the reflection types:
- The scheme with different components used is the bar graph atop the line graph (C, BS, etc) map to distance from the entrance
![](quantum-trojan-horse-attack-plugangplay-MAKAROV.png)

#### Counter Measures

You need to check each EGM pulse in case of [[Side-Channel-Attacks]]
- Make a Monitoring Detector
- Consider the limitations of the Electronics 
- Consider the Phase modulation wave (has a rise, bump, plateau and fall), attacks occur outside of the plateau
![](quantum-trojan-horse-attack-plugangplay-countermeasures-MAKAROV.png)



## References

[Quantum hacking - Vadim Makarov Lecture Part 1](https://www.youtube.com/watch?v=2r7B8Zpxmcw))

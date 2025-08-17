# Quantum Hacking

23:46


This page is based on notes taken from the follow Lectures: [Lecture: ], [Lecture: ] and [Lecture: ]

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


#### Commercial QKD

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
- `->` Photon detector `-D` 
- Both `-D` `->` converge on: `[Clicks Processed]` outputting `->` `Random Stream`  


#### Question Based Hacking a QKD, Quantum Computers, etc

- True Randomness?
	- Quantis RNG `->` FPGA `->` Phase modulator in Bob (id Quantique Clavis2 (2008))
		- For each `->` how is it implemented such that it safely and security prevents our Objective
	- Is there sequential randomness (of data) at each level of abstraction? 
- Can we trust the Manufacture?
	- Human will be Humans to other (h/'/H `||!?` )umans and Monkeys are just sign language experts without Lab coats.





## References

[Quantum hacking - Vadim Makarov Lecture Part 1](https://www.youtube.com/watch?v=2r7B8Zpxmcw))

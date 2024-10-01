# Side Channel Attacks

[Wikipedia Side Channel Attack](https://en.wikipedia.org/wiki/Side_channel_attack) describes *"a side-channel attack is any attack based on extra information that can be gathered because of the fundamental way a [computer protocol](https://en.wikipedia.org/wiki/Computer_protocol "Computer protocol") or [algorithm](https://en.wikipedia.org/wiki/Algorithm "Algorithm") is [implemented](https://en.wikipedia.org/wiki/Implementation#Computer_science "Implementation")"*

**Please read**:
Consideration on sources. It is worth reminding the reader that there are no bug bounties for most of these attacks and there is Organisational insensitives to keep things secret or not fix or litigate for damages for claiming vulnerability. Also this leads to the weird end of academic research were potential anyone can claim things for prestige or competitive or personal reasons; (as more of a reminder to myself) measure twice, cut once - indicators are clues not facts and take a step back. Examples of Issues:
- White Paper's premise is that most SCA White Papers do not actually exploit with replicatable proof provide efficacy of how SCA were exploit. **The Author of the page cannot provide proof as to the truth of these statements**
	- [PDF On the Optimization of Side-Channel Attacks by Advanced Stochastic Methods - Werner Schindler: https://iacr.org/archive/pkc2005/33860084/33860084.pdf](https://iacr.org/archive/pkc2005/33860084/33860084.pdf) 
- Some papers are gated by pay walls
- Science is a voluntary effort - does not mean that paper are independently verified or verifiable
- Cost of anyone doing all the science and then making all of it free and public is Utopian


**Reader beware, I am not an expert** and if you are reading this then 99.99% chance you are not either this is just a idiot's attempt to summarise and classify, in the hope of formulating identification methodology for current and future SCAs.
## SCA Taxonomy 

It is worth noting that attacks can be use in combination for Combinational Attacks (see section), [PDF NIST - Side-Channel Attacks: Ten Years After Its Publication and the Impacts on Cryptographic Module Security Testing ](https://csrc.nist.gov/csrc/media/events/physical-security-testing-workshop/documents/papers/physecpaper19.pdf) notes the following types of SCAs

- [[Timing-Attacks]]
- [[Fault-Attacks]]
- [[Power-Analysis-Attacks]]
- [[Electromagnetic-Attacks]]
- [[Acoustic-Attacks]]
- [[Visible-Light-Attacks]]
- [[Error-Message-Attacks]]
- [[Cache-based-Attacks]]
- [[Frequency-based-Attacks]]
- [[Scan-based-Attacks]]


[Wikipedia - Side Channel Attacks](https://en.wikipedia.org/wiki/Side-channel_attack) claims the following not included in the NIST White paper (**Author notes none of these have references (as of 01/10/2024), but they seem legitimate..**):
- [Data remanence](https://en.wikipedia.org/wiki/Data_remanence "Data remanence") — in which sensitive data are read after supposedly having been deleted. (e.g. [Cold boot attack](https://en.wikipedia.org/wiki/Cold_boot_attack "Cold boot attack"))
- Software-initiated fault attacks — Currently a rare class of side channels, [Row hammer](https://en.wikipedia.org/wiki/Row_hammer "Row hammer") is an example in which off-limits memory can be changed by accessing adjacent memory too often (causing state retention loss).
- [Allowlist](https://en.wikipedia.org/wiki/Allowlist "Allowlist") — attacks based on the fact that the allowlisting devices will behave differently when communicating with allowlisted (sending back the responses) and non-allowlisted (not responding to the devices at all) devices. Allowlist-based side channel may be used to track Bluetooth MAC addresses.
- Optical - in which secrets and sensitive data can be read by visual recording using a high resolution camera, or other devices that have such capabilities (see examples below)

**Author notes and ideas while researching - please dismiss if forget to tidy up**
- Mode Shift attacks - force it into debug mode
- Dorking as an informational in-and-exfiltration?

#### SCA in Cryptography

[PDF NIST - Side-Channel Attacks: Ten Years After Its Publication and the Impacts on Cryptographic Module Security Testing ](https://csrc.nist.gov/csrc/media/events/physical-security-testing-workshop/documents/papers/physecpaper19.pdf)

- Control over the computation process
	- Active 
	- Passive
	- Invasiveness - Examples but no definition scale given 
		- Invasive
		- Semi-Invasive
		- Non-Invasive
- Module access
- Method in analytical process - which not classify the attack, but the research for the attack? - unless analysis is the attack and this is written weird
	- Simple side channel attack
	- Differential side channel attack
	- Output total 
		- `In case only one single output-value is used for an attack, then the attack is called first-order attack. If two or more output values for the same side-channel are used in an attack, then the attack is called second-order attack and higher-order attack`

Counter Measures proposed:
- De-correlate the output traces on individual runs (e.g., by introducing random timing
shifts and wait states, inserting dummy instructions, randomization of the execution of operations,
etc.);
- Replace critical assembler instructions with ones whose “consumption signature” is hard
to analyze, or re-engineer the critical circuitry which performs arithmetic operations or memory
transfers;
- Make algorithmic changes to the cryptographic primitives so that attacks are provably
inefficient on the obtained implementation, e.g., masking data and key with random mask
generated at each run.


#### People

#### Physical Security

#### Computers and Servers

[[Cold-Boot-Attacks]]


## References

[Wikipedia Side Channel Attack](https://en.wikipedia.org/wiki/Side_channel_attack) 
[PDF NIST - Side-Channel Attacks: Ten Years After Its Publication and the Impacts on Cryptographic Module Security Testing ](https://csrc.nist.gov/csrc/media/events/physical-security-testing-workshop/documents/papers/physecpaper19.pdf)
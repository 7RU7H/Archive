## Red Team OPSEC

Operations Security (OPSEC) is a term coined by the United States military. In the field of cyber-security, let’s start with the definition provided by [NIST](https://csrc.nist.gov/glossary/term/opsec): *“Systematic and proven process by which potential adversaries can be denied information about capabilities and intentions by identifying, controlling, and protecting generally unclassified evidence of the planning and execution of sensitive activities. The process involves five steps: identification of critical information, analysis of threats, analysis of vulnerabilities, assessment of risks, and application of appropriate countermeasures.”*

Consider [[OPSEC]]
## Critical Information

Client Information & Red Team information:
1. Activities, identities, plans, capabilities and limitations
1. Tactics, techniques and procedures
1. IPs, MAC addresses, public domains, hosted websites i.e phishing or "We use this OS or software!"

## Threat Analysis

- Who is the adversary is?
- What are the adversary’s goals?
- What tactics, techniques, and procedures does the adversary use?
- What critical information has the adversary obtained, if any?

## Vulnerabilities Analysis

[DoD opsec](https://www.esd.whs.mil/Portals/54/Documents/DD/issuances/dodm/520502m.pdf): 
- OPSEC vulnerability exists when an adversary can:
	- obtain critical information
	- analyse the findings
	- act in a way that would affect your plans.

## Risk Assessment

The efficiency of the countermeasure in reducing the risk
The cost of the countermeasure compared to the impact of the vulnerability being exploited.
The possibility that the countermeasure can reveal information to the adversary

## Countermeasures 

“Countermeasures are designed to:
- prevent an adversary from detecting critical information
- provide an alternative interpretation of critical information or indicators (deception), 
or deny the adversary’s collection system.”

## References

[THM Red Team Opsec Room](https://tryhackme.com/room/opsec)
[DoD opsec](https://www.esd.whs.mil/Portals/54/Documents/DD/issuances/dodm/520502m.pdf):
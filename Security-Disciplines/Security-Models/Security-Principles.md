# Security Principles

Consider review in conjunction with [[Security-Policies]], [[Security-Controls]]  and [[Security-Strategies]]

- **Vulnerability**: Vulnerable means susceptible to attack or damage. In information security, a vulnerability is a weakness.
- **Threat**: A threat is a potential danger associated with this weakness or vulnerability.
- **Risk**: The risk is concerned with the likelihood of a threat actor exploiting a vulnerability and the consequent impact on an organisation.

## Foundational Security Models

#### Bell-LaPadula Model

Objective: achieve confidentiality from the following rules:
- Simple Security Property: "no read up", lower security level cannot read an object at higher security level
- Star Security Property: "no write down" higher security level cannot write to an object at a lower security level
- Discretionary-Security Property: utilisation of an access matrix to determine allowed reads and writes 

Warning not design for:
- file-sharing

#### The Biba Integrity Model

Objective: achieve integrity from the following rules:
- Simple Integrity Property: “no read down”; a higher integrity subject should not read from a lower integrity object.
- Start Integrity Property:  “no write up”; a lower integrity subject should not write to a higher integrity object.

Warning not design for:
- Insider threats

#### The Clark-Wilson Model

- Constrained Data Item (CDI):  refers to the data type whose integrity we want to preserve.
- Unconstrained Data Item (UDI refers to all data types beyond CDI
- Transformation Procedures (TPs): These procedures are programmed operations, such as read and write, and should maintain the integrity of CDIs.
- Integrity Verification Procedures (IVPs): These procedures check and ensure the validity of CDIs.


#### Brewer and Nash model
#### Goguen-Meseguer model
#### Sutherland model
#### Graham-Denning model
#### Harrison-Ruzzo-Ullman model

## Security Models 

####  CIA Triad

- Confidentiality
- Integrity
- Availability

Extension to this:
- Authenticity 
- Non-repudiation: Refusing the denial from original sources counter claim they are the original source

#### Parkerian Hexad

In 1998, Donn Parker proposed the Parkerian Hexad:

1.  Availability
2.  Utility
3.  Integrity
4.  Authenticity
5.  Confidentiality
6.  Possession

####  DAD

- Disclosure
- Alteration
- Destruction/Denial

#### Domain-based Models

- [Principle of Least Privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege) - grant only the lowest possible privileges required for tasks or services that a role needs
- [Zero Trust](https://en.wikipedia.org/wiki/Zero_trust_security_model) - remove all implicit trust and have granular authorization across a entire set of vectors 
- [Trust but Verify](https://en.wikipedia.org/wiki/Trust,_but_verify) - have trust, but trust verified authentication mechanisms to authenticate
- [Open Security](https://en.wikipedia.org/wiki/Open_security) - Security of a system should not depend on its secrecy 
- [Defense in Depth](https://en.wikipedia.org/wiki/Defense_in_depth_(computing)) - adding as many layers of defense as possible  

## ISO/IEC 19249



The International Organization for Standardization (ISO) and the International Electrotechnical Commission (IEC) have created the ISO/IEC 19249.ISO/IEC 19249:2017 _Information technology - Security techniques - Catalogue of architectural and design principles for secure products, systems and applications_. 

ISO/IEC 19249 lists five _architectural_ principles:

1. **Domain Separation**: Every set of related components is grouped as a single entity; components can be applications, data, or other resources. Each entity will have its own domain and be assigned a common set of security attributes.
	- In contrast, user-mode applications can run in ring 3 (the least privileged level). Domain separation is included in the Goguen-Meseguer Model.
2. **Layering**:  Layering relates to Defence in Depth, but is applicable across all layers not just defense
3. **Encapsulation**: reduce exposed low level implementation
4. **Redundancy**: This principle ensures availability and integrity - backups and no single points of failure
5. **Virtualization**: Virtualization provides sandboxing capabilities that improve security boundaries, secure detonation, and observance of malicious programs.

ISO/IEC 19249 teaches five _design_ principles:

1. **Least Privilege** - Only enough privilege to perform tasks
2. **Attack Surface Minimisation** - Reduce internal network exposure and external access points 
3. **Centralized Parameter Validation** - Check input
4. **Centralized General Security Services**: Centralise security and have redundancy to avoid single points of failure
5. **Preparing for Error and Exception Handling**: Assume failures, issues and errors occur prevent and prepare with review and implementation 


## References

[THM Room Principles of Security](https://tryhackme.com/room/principlesofsecurity)
[Principle of Least Privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege)
[Zero Trust](https://en.wikipedia.org/wiki/Zero_trust_security_model)
[Open Security](https://en.wikipedia.org/wiki/Open_security)
[Defense in Depth](https://en.wikipedia.org/wiki/Defense_in_depth_(computing))
19249.ISO/IEC
[Trust but Verify](https://en.wikipedia.org/wiki/Trust,_but_verify)
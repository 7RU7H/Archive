# Key Management



#### CryptoOps - DevSecOps  

- Starting strong with early adoption of security practices
- Regulatory and compliance standards
	- [Payment Card Industry Data Security Standard](https://www.pcisecuritystandards.org/standards/pci-dss/) (PCI DSS)
	- [General Data Protection Regulation](https://gdpr-info.eu/) (GDPR)
	- [Health Insurance Portability and Accountability Act](https://www.cdc.gov/phlp/php/resources/health-insurance-portability-and-accountability-act-of-1996-hipaa.html) (HIPAA)
- Have a Key Management Lifecycle (KML) that ensures Key Rotations occur!
	0. Key Generation
		- Secured through generation method (good Cryptographic algorithm and key generation cleanup to avoid leaking components), clear RAM, etc..
		- Strong RNGs
		- Adhere to industry standards and algorithm 
			- No CEO cousin's custom SHA hashing please
		- Secure Key generation environment 
			- Secure physical environment
				- Tamper resists
				- Physical and Digital ACLs
			- [Hardware Security Module](https://cpl.thalesgroup.com/en-gb/encryption/hardware-security-modules) (HSMs)
			- Turn the server off and clear the RAM - but Organisations use Bastion hosts, so good luck
		- Validate the Key generation process 
	- Key Distribution - Distribute the public key not the private key and Encryption in transit, also encompasses the secure storage of keys.
		- Encryption in transit
		- Employ Public Key Infrastructure
		- Used trusted delivery methods:
			- Key Distribution Centres 
			- Asymmetric key distribution
			- Symmetric key distribution
			- Pre-Shared Key (PSKs)
		- Authenticate properly
	- Key Storage - Encryption at rest with your storage solutions
		- Provide storage solutions - decide before users do
			- Cloud based
				- [AWS Key Management Service](https://docs.aws.amazon.com/kms/latest/developerguide/overview.html) (KMS)
				- [Azure Key Vault](https://learn.microsoft.com/en-us/azure/key-vault/general/basic-concepts)
				- [Google Cloud Key Management Service](https://cloud.google.com/security/products/security-key-management?hl=en) provide managed environments for handling cryptographic keys.
		- Encrypted databases 
		- Specialised [hardware security modules](https://cpl.thalesgroup.com/en-gb/encryption/hardware-security-modules) (HSMs)
		- [[RBAC]] - Role-Based Access Control
		- [[ABAC]] - Attribute-Based Access Control 
			- More Granular than RBAC so should only be used sparingly to avoid complexity creep and also avoid solving problems with micro adjustments rather than focusing Top-down 
		- [[Authentication]] implemented properly and upgraded over time
		- Accountability
			- Auditing
			- Monitoring
	- Key Usage - Authenticate properly, Access Control properly
	- Key Backup and Recovery - Encryption at rest, purge periods (soft delete for a specified number of days)
	2. Key Rotation
	3. Key Termination
		- Key Revocation
		- Key Destruction
- Review [CSAs](https://cloudsecurityalliance.org/artifacts/key-management-lifecycle-best-practices) best practices.
## References

[THM Room CryptoOps](https://tryhackme.com/r/room/introductiontocryptops)
[CSAs KLI Best Practices](https://cloudsecurityalliance.org/artifacts/key-management-lifecycle-best-practices)
[thalesgroup - Hardware Security Module](https://cpl.thalesgroup.com/en-gb/encryption/hardware-security-modules) 
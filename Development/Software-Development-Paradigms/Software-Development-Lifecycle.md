# Software Development Lifecycle

As with all Development Philosophy, consider the [[Development-Philosophy-Disclaimer]] first.

Software Development Lifecycle (SDLC) is a DevOps concept and its aim is to:
- Provide analysis of each phase 
- Establish repeatable processes and predictable outcomes
- Improve the quality of the software
- Improve the quality of the development process	
- Meet deadlines
- Meet cost estimationshttps://tryhackme.com/room/dnsmanipulation

Software Development Lifecycle is not Secure Software Development Lifecycle this article will append the Secure additions along side SDLC after defining SDLC first. 

#### Phases

Loosely put and, frequently rearranged 

- Planning - Feasibility Stage
	- Define scope and purpose of the application
- Requirements Definition: 
	- Define prototype ideas and gathering all the necessary details, which may be in the form of:
		- Making a list of all the requirements for the prototype system  
		- Prototypes should be evaluated for alternatives  
		- Identify the end user's needs through research and analysis
- Design and Prototyping
	- Outline the details of the overall application
	- Create a Architecture Design Review
- Software Development
	- Programming happens and application is developed based on specifications outlined in earlier design documents
- Testing
	- Setup Test environment setup:
		- Access bug reporting capabilities and the application architecture to support the product
	- Review software using automated tooling
	- Quality Assurance Team and Quality Analysis (QA) Engineers:
		- Validate functionality within the allotted time and scope
	 - [[Containerisation]] of architecture required to test deployment of target audiences 
- Deployment
	- Automated deployment of software roll outs: '
		- Version and automation allows for the capability to rollback a deployment
- Operations and Maintenance
	- Automate traditional operations tasks
	- Standardising tooling

#### CALMS

- Culture: Promote innovative cultures
- Automation
- Lean: Chunk tasks into small chunks
- Measurements: Measure effectiveness
- Sharing

#### DevOps Metrics

- Meantime to production ([MTTP](https://about.gitlab.com/handbook/engineering/infrastructure/team/delivery/metrics.html)). 
	- What is the turnaround time for newly committed source code?
- Frequency of deployment. 
	- What is the frequency of deployment of releases? The average lead time. How long does it take to develop, build, test, and deploy a new feature?
- Speed of deployment. 
	- A new release is deployed into production; how long does it take?
- Deployment Agility. 
	- You can measure deployment agility by combining deployment speed and frequency.
- Production failure rate. 
	- How often do failures occur in production?
- MTTR stands for mean time to recover. 
	- What is the recovery time after a failure?

#### Secure SDLC (SSDLC)

Improvement on SSDLC as someone forgot that security bugs existed, even though this is DevOps so later than Agile, therefore we also have SSDLC. 
- Implement security by design
	- Security education and awareness for all!
- Insecurity is extremely costly post deployment 
- Understand Security Posture
	- Perform gap analysis -determine what and the effectiveness of activities and policies that exist in organisation
	- Create Software Security Initiative (SSI)
		- Establishing realistic and achievable goals with defined metrics for success
	- Formalise processes
		- Gather feedback before enforcing SSI and formalise procedures
	- Invest in security training


- Planning (Feasibility Stage) and Risk Assessment Phase: 
	- Define scope and purpose of the application
	- Per planned feature gather all possible security considerations that promote security by design
- Requirements Definition and Risk Assessment Phase: 
	- Per feature's requirements gather all possible security considerations that promote security by design
	- Define prototype ideas and gathering all the necessary details, which may be in the form of:
		- Making a list of all the requirements for the prototype system  
		- Prototypes should be evaluated for alternatives  
		- Identify the end user's needs through research and analysis
- Design and Prototyping with Threat Model Phase: 
	- Identifying potential threats when there is a lack of appropriate safeguards 
		- Focus on: what should not happen - not CTI
	- Outline the details of the overall application
	- Create a Architecture Design Review
- Software Development with Code Scanning and Review Phase:
	- Scan automatically and Manual Static Analysis - both is better than either or neither
	- Programming happens and application is developed based on specifications outlined in earlier design documents
- Testing with additional Code Scanning and Review Phase
	- Scan automatically and Manual Static Analysis - both is better than either or neither
	- Setup Test environment setup:
		- Access bug reporting capabilities and the application architecture to support the product
	- Review software using automated tooling
	- Quality Assurance Team and Quality Analysis (QA) Engineers:
		- Validate functionality within the allotted time and scope
	 - [[Containerisation]] of architecture required to test deployment of target audiences 
- Deployment and Secure Configuration phase: 
	- Automated deployment of software roll outs: 
		- Version and automation allows for the capability to rollback a deployment
- Operations and Maintenance with Security Assessments Phase:
	- Perform Security Assessments or other bad actor will for you
	- Automate traditional operations tasks
	- Standardising tooling

- Focusing on security part of SSDLC
	- Risk Assessment
		1. Assume application will be attacked consider threat actor motivations and perform [[Cyber-Threat-Intelligence]]
		2. Evaluate risk - worst-case modelling for executives and senior engineers 
		3. Accessibility of target - how accessible components are
		- Types:
			- Qualitative:  `Risk = Severity * Likelihood` 
			- Quantitative: Measure risk with numerical values
	- Threat Modelling
		- STRIDE developed by Microsoft, built upon the CIA triad:
			- Spoofing: act of impersonation of a user
			- Tampering: modification of information by an unauthorised user
			- Repudiation: Not taking responsibility for events where the actions are not attributed to the attacker
			- Information Disclosure: violation of confidentiality from the CIA Triad
			- Denial of Service: Exhaustion of resources to deny service availability 
			- Escalation of Privilege: violation of authorisation from the CIA Triad
		- DREAD created by Microsoft as a add-on to STRIDE to create a rating system that is scored based on risk probability:
			- Damage: 
			- Reproducibility
			- Exploitability
			- Affected Users
			- Discoverability
		- PASTA (Process for Attack Simulation and Threat Analysis):
			1. Define Objectives
			2. Define Technical Scope
			3. Decomposition and Analysis
			4. Threat Analysis
			5. Vulnerabilities and Weaknesses Analysis
			6. Attack Enumeration & Modelling
			7. Risk Impact Analysis

#### Secure Code Review and Analysis

- Types
	- [[Static-Application-Security-Testing]] (SAST) 
		- White-box testing and analysis of source code
			- **CI/CD integration:** Each time a pull request or a merge is made, SAST tools will check the code for vulnerabilities. 
			- **IDE integration:** SAST tools can be integrated into IDEs 
	- Software Composition Analysis (SCA) 
		- automated scanning of dependencies for security vulnerabilities
	- Dynamic Application Security Testing (DAST) 
		- black-box testing to dynamically find vulnerabilities at runtime
	- Interactive Application Security Testing (IAST) 
		- grey-box testing that analyses code for security vulnerabilities on real-time running web and mobile applications
	- Runtime Application Self Protection (RASP)
		- runtime application integrated into an application to analyse inward and outward traffic and end-user behavioural patterns to prevent security attacks.

#### Security Assessments

Do not confuse:
- [[Vulnerability-Assessment]]  != [[Penetration-Testing]] !=  [[Red-Team-Engagements]]

[[Vulnerability-Assessment]] with [[Vulnerability-Scanning]]
- [[OpenVAS]]
- [[Tools/Vulnerability-Analysis/Nessus/Nessus|Nessus]]
- [[ISS-Scanner]]

[[Penetration-Testing]]

### Methodologies

- Microsoft SDL
	- Principles
		- Secure by design
		- Security by default
		- Security by deployment
		- Communications
	- Practices
		- Provide Training
		- Define Security Requirements
		- Define Metrics and Compliance reporting
		- Perform Threat Modelling
		- Define and Use Cryptography Standards
		- Manage the Security Risk of Using Third-Party Components
		- Use Approved Tools
		- Perform Security Testing (SAST, DAST, IAST)
		- Perform Security Assessments
		- Establish a Standard Incident Response Process

OWASP S-SDLC
- Principles
	- SDL is a collection of mandatory security activities grouped by the traditional software development lifecycle phases.
	- Data is collected to assess training effectiveness.
	- In-process metrics are used to confirm process compliance.
	- Post-release metrics are used to guide future changes.
	- SDL places heavy emphasis on understanding the cause and effect of security vulnerabilities.
	- A development team must complete the sixteen mandatory security activities to comply with the Microsoft SDL process.
- [OWASP SAMM](https://owasp.org/www-project-samm/) - Software Assurance Maturity Model
	- Measure how well an organisation is currently doing

[BSIMM](https://owaspsamm.org/blog/2020/10/29/comparing-bsimm-and-samm/)
- Measure security posture

## References

[THM Software Development Lifecycle](https://tryhackme.com/room/sdlc)
[THM Secure Software Development Lifecycle](https://tryhackme.com/room/securesdlc)
[THM SAST Room](https://tryhackme.com/room/sast)
# Secure Software Development Lifecycles



## Attacks Against CI/CD

#### Poisoned Pipeline Execution

- Direct Poisoned Pipeline Execution
	- Direct write access to to repository pipeline
- Indirect Poisoned Pipeline Execution
	- Writing to another repository that affects the target pipeline (control of a dependency) 

DevOps infrastructure is inherently vulnerable as it requires both human access to low level memory like a user account with [[SeDebugPrivilege]], to the need to put passwords in environment variable in [[Docker]]. These practices are implemented for human to get the development time in with distractions and to scale automation. Therefore vectors to obtain access to the source code or a component to maliciously configure the application such that the inherent trust that exists to develop an application propagates that *poisoning* of the pipeline. This problem is larger that just the implementation of security controls as the branching requirement of developer to work on sections of an application lead to a massive total sprawl of all work done that gets merged continuously. Tracking this as human is impossible and meticulously LLM scanning is improbably and very costly. Budgets, humans require ring 0 permissions, external dependencies, key exchanging, automation, laziness, buggy development code, branching exponentiation, BYOD with Developers and remoting, highly privilege virtual devices on Virtual networks in Cloud providers unsegmented hardware, defaults being developed and used in various domains (DNS, certificates, passwords, no encryption implemented yet, virtual networking where debugging network traffic, configurations, file system permissions, etc) etc. All in all it is possibly the most vulnerable possible meta-environment and environment possible in modern information security where security controls are objectionable at all levels of an organisation either because costs in time, quality of life. Issues to can have lastly impact as data has to be propagated version to version, to different environments,etc.

Remediation
- Preventing unauthorised respiratory changes - enforce [Protected Branches (GitLab)](https://docs.gitlab.com/ee/user/project/protected_branches.html)
- Artefact management
	- Artefact expiration to limit retention
- Pipeline visualisation
- Static analysis and linters (*"flags programming errors, bugs, stylistic errors and suspicious constructs."* - [Wikipedia](https://en.wikipedia.org/wiki/Lint_(software)))
- Access controls - [[Principle-Of-Least-Privilege]]
- Regular security audits
- Pipeline stages
	- Removing extraneous stages






## Tooling
#### GitLab

[GitLab](https://about.gitlab.com/) according to itself *"is the most comprehensive AI-powered DevSecOps Platform"* and *"is an open-core company that operates GitLab, a DevOps software package that can develop, secure, and operate software. The open source software project was created by Ukrainian developer Dmytro Zaporozhets and Dutch developer Sytse Sijbrandij.*" - [Wikipedia](https://en.wikipedia.org/wiki/GitLab)
Components
- Version Control system
- Continuous Integration / Continuous Deployment (CI/CD)]
	- Integrate new features
	- Deployment for different environments (sandboxing, staging, production) 
- Security Scanning
	- [[Static-Application-Security-Testing]] 
	- [[Dynamic-Application-Security-Testing]] (DAST)

## References

[Wikipedia - GitLab](https://en.wikipedia.org/wiki/GitLab)
[GitLab](https://about.gitlab.com/)
[Advent of Cyber 2023]https://tryhackme.com/room/adventofcyber2023
[Protected Branches (GitLab)](https://docs.gitlab.com/ee/user/project/protected_branches.html)
[Wikipedia - Lint (software)](https://en.wikipedia.org/wiki/Lint_(software))
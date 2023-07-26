# Securing Cloud Deployments: A Red Team Perspective
[From the Sans institute talk: Securing Cloud Deployments: A Red Team Perspective](https://www.youtube.com/watch?v=ZFanzuXHv3c), these are just my notes. *"Cloud computing represents an opportunity for businesses of all sizes to deploy new service offerings more quickly, focus on development instead of system maintenance, avoid big bets on capital expenditures, and handle spikes in demand seamlessly. However, it also represents a fundamental shift in the security architecture that many organizations have become accustomed to over the last decade or more. In this talk, Matt will describe common missteps he sees as teams move to a cloud-first world, ways that organizations can minimize risk by protecting themselves and their services, and how security testing itself changes in the cloud."*

Matt Burrough @mattburrough, Senior Penetration Test Lead, Microsoft

## How Does Red Teaming Change in the Cloud?

 - Permission, Authorisation
 
  	Traditionally | Cloud
	--- | ---
	Attack and done | Deal with cloud provider(s)

 - Scope/ Rule of Engagement
	 - Shared Resource
	 
	Traditionally | Cloud
	--- | ---
	Networks contained | Cloud provider host other customer 
	
	 - Services, Infrastructure, Metastructure

	Traditionally | Cloud
	--- | ---
	Physical Network | Seperate management metastructure for virtualisation to user applications
	
	 - Limits on Tools
	 
	Traditionally | Cloud
	--- | ---
N/A | Cloud needs new tools, Licencing

- Reporting

	Traditionally | Cloud
	--- | ---
	N/A |  Third party disclosures
	
## Frequent Findings

#### Lift and shift gone wrong
1. Control that used to sufficient aren't anymore
2. Miss out on Cloud-First benefits like scaling
3. Taking for graned previous controls, like patching, monitoring, security policies

#### Improperly Configured Storage 
1. Did you mean to leave that blob open to the world? - Public storage for anonymous mixed with private.
2. Doing key management properly? Key control critical!
3. Accounts and permissions probably not what you're used too.. - Not the same as an AD network
4. Encryption at rest? In transit? - Cloud provider support these, use them
5. Data retention?
6. Just because you can doesn't mean you should. 
	1. E.G: Controls from traditional network systems are good, running web app from storage in cloud loses logging and monitoring

Traditional granular controls are very different from cloud controls!

#### Secrets in Source
1. Code, Configs are moving to the cloud, too.
2. Accessing Cloud API means developers may be putting more secrets into  code/
3. Are redacted secrets exposed?
4. Encoding isn't encryption
5. Attacker can now find them at scale.

#### Insecure Network Settings
1. Excessively permissive firewall rules
2. Management ports exposed to the Internet
3. Firewall exceptions for home IPs

#### Social Engineering
1. Phishing for user administrators' credentials
2. Brand Impersonation (No SSL certification for users to differenciate; No cert? Bad site - gone)
3. Improper service cleanup/deprovisioning (IPs, DNS, service names) can let an attacker claim them

#### Confusing Authentication for Authorization 
1. Just because someone has an account doesn't mean they belong here..
2. Detirmining a user's role through user controlled fields
3. This applies to other identity fields as well

#### Gray Cloud 
1. Are security standards/policies followed?
2. Security monitoring
3. Compliant for regulatory compliance?
4. Using an unapproved vendor?

## Stopping a Red Teamer 
...and attackers tool

#### Monitoring 
1. The best offense is good defense
2. Not just see, but act
3. Need visibility across the whole graph
4. Alerting on single pane of glass

John Lambert Microsoft Security Consultant: *"Defenders think in lists, Attackers think in graphs"*

#### Multifactor Authentication
1.  Much harder to steal, guess, brute force...
2.  Not impossible, but attacker like low hanging fruit
3.  Make sure you're using across all services, Better yet...

#### Using a Unified Identity Solution
1. In the cloud, identity is the new Network Edge
2. Single Sign On elimates a patchwork of user accounts and password policies
3. Makes provisioning and deprovising simpler, consistent
4. Central source of logging monitoring 
5. Security features like Conditional Access

#### Administrator Account Hygiene

1. Just Enough Admin
2. Just in Time Access
3. Alternate Accounts
4. Privileged Access Workstations
5. Password Diversification

#### Exercise Zero Trust
1. Assume Breach
2. How much has your network change in 3 months?
3. Defense in Depth

#### User Education
1. Regualr security training for all users
2. Emphasize importance of unique passwords, MFA
3. Provide phising simulation execises
4. It's ok to make a mistake, but report it!


## References
[Matt Burrough Sans institute talk: Securing Cloud Deployments: A Red Team Perspective](https://www.youtube.com/watch?v=ZFanzuXHv3c)



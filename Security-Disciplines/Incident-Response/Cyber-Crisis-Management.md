# Cyber Crisis Management

[THM Cyber Crisis Management Room](https://tryhackme.com/room/cybercrisismanagement): CMT incidents are *"A critical incident where the CSIRT requires the ability to invoke nuclear actions, such as an incident where ransomware is being deployed and the CSIRT needs to take the environment offline to protect the rest of the estate"* 

Decision to determine the level of the issue is based on: 
- `number of affected users`
- `impact` being measure by the operability of system(s) affected and by how much

#### Process of CMT

[THM Cyber Crisis Management Room](https://tryhackme.com/room/cybercrisismanagement): *"It is important to note that during the entire process, the CMT remains static. Rather than have members of the main CMT split off and find information, SMEs are used to bring information to the CMT. This is because if the CMT team were to split off during a critical moment, it would waste time to assemble the team again. This model ensures that the CMT can always receive critical information from stakeholders and SMEs."*

1. Golden Hour
2. information Update <--> Triage
3. Action Discussion <--> Action Approval
	- Action Discussion:
		- Restricting remote access via VPN
		- Domain Takedowns of a Domain Controller
		- Switching a system to a disaster recovery environment
	- Action Approval - Time Sensitive ([[Ransomware]] encrypting an entire system, preventing total [[Data-Exfiltration]], etc)
		- Decisions will often be made very hierarchically and directly by the CEO
1. Documentation and Crisis Closure

#### Roles in the CMT

Hierarchy and Chain of command is best for CMT as democratised decision making in absolute crisis create divergent objectives and grouping of actions that are not coordinated. The table below is from [THM Cyber Crisis Management Room](https://tryhackme.com/room/cybercrisismanagement) :

|                         |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| ----------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Role/Responsibility** | **Description**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| CMT Chair               | The Chair is the person that leads the CMT. Usually, this role is fulfilled by either the CEO or the COO of an organisation. The Chair is responsible for leading the CMT and, as mentioned before, is usually responsible for having the final say in what actions will be implemented during the cyber crisis.                                                                                                                                                                                                                                                                                                |
| Executives              | Executives are usually part of the CMT. This includes the CEO, COO, CIO, CTO, CFO, and even the CISO. In cases where not just the CEO is responsible for decision-making, these executives would each be granted a voting right. As executives will ultimately be held accountable for what happened during the incident, they are involved in the CMT to ensure that the damage is kept as small as possible.                                                                                                                                                                                                  |
| Communication           | An important responsibility in the CMT is communication. This includes communications that are being sent both internally to employees and externally to customers. An important part of any CMT is staying in control of the narrative to help ensure that unnecessary panic is not created. Therefore, communication during the cyber crisis is incredibly vital.                                                                                                                                                                                                                                             |
| Legal                   | While we would like to believe that the CMT can take any action, it is important to ensure that these actions are actually legal. A very common discussion during certain cyber crisis scenarios is whether a ransom will be paid or whether the team will interact with the threat actors. It is important to note that in certain countries, these actions may not even be legal for the team to do.                                                                                                                                                                                                          |
| Operations              | One of the CMT member's sole responsibility is to concern themselves with the best possible approach to ensure that the operations of the organisation are affected the least amount possible during the cyber crisis. In certain cases, this role is fulfilled by the COO; however, it can also be fulfilled by an entire team of experts that are looking for ways that business can continue during the crisis.                                                                                                                                                                                              |
| Subject Matter Experts  | Most of the members of the CMT are not technical. These are members that are exceptional at business concerns but do not usually concern themselves with the day-to-day complexities of actually running the organisation's systems. During a cyber crisis, subject matter experts (SMEs) play a vital role in providing critical information to the members of the CMT. This information then helps inform the team about the crisis scope and which actions would be the best to perform. During a cyber crisis, this would most likely include the head of the SOC and/or the incident manager of the CSIRT. |
| Scribe                  | Note-taking is incredibly important during a cyber crisis. It is important to create a full timeline of events as this often has to be disclosed to other third parties, such as the government or regulator. The role of the scribe is therefore important to detail all events and conversations during the CMT session.                                                                                                                                                                                                                                                                                      |
|                         |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |

Subject Matter Experts are very important in aiding CMT in areas where the requirement for knowledge depth in subject is vital to the CMT to act effectively. A CMT is still a group, which teamed to provide breadth of mixed expertise and capabilities, but as a group are more effective than a straining a few SMEs to perform both roles. SMEs job is to provide information to the CMT to act upon it.

[THM Cyber Crisis Management Room](https://tryhackme.com/room/cybercrisismanagement) :
*The CMT can only take effective actions if the following is true:*
- *The CMT must have an accurate understanding of the scope of the incident, including what has happened and what the impact is on the business. It will never be possible to understand the full crisis scope as the investigation will still be ongoing, but having an as clear as possible picture is important.*  
- *The CMT has to understand what actions are available for them to take and what the impact vs effectiveness of these actions would be*
#### The Golden Hour

- Assembly
	- Initial phase to notify upon initial and reserve replacement members of the CMT and decide on playbook and call tree
- Information Gathering
	- Current summary of discovered information
	- Summary of actions taken and measured effectiveness
	- Recommended CMT actions to taken immediately 
- Crisis Triage
	- Considerations on actions to take to limit impact
	- Decision on additional stakeholders were involved
- Notifications - These are messages that do not divulge exactly what is happening
	- Controlling the narrative
	- Calming 

#### Actions of a CMT

- Internal Communication
- External Communication
- Informing Regulators
- Contacting Law Enforcement
- Exercising CMT

## References

[THM Cyber Crisis Management Room](https://tryhackme.com/room/cybercrisismanagement) 
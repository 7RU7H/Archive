# Software Development Lifecycle

As with all Development Philosophy, consider the [[Development-Philosphy-Disclaimer]] first.

Software Development Lifecycle (SDLC) is a DevOps concept and its aim is to:
- Provide analysis of each phase 
- Establish repeatable processes and predictable outcomes
- Improve the quality of the software
- Improve the quality of the development process	
- Meet deadlines
- Meet cost estimations

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

## References

[THM Software Develop Lifecycle](https://tryhackme.com/room/sdlc)
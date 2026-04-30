# Pipeline Automation

Dependency Management `->` Source Code Storage and Version Control `->` Continuous Integration (Including Automated Testing) `->` Deployment Environments

Source Code Storage and Version Control 
- Access
- Tracking changes
- Development tool Integration
- Multiple version usage
- Hosting
- Security
	- [[Git-Repository-Hacking]]

Dependency Management
- Internal Vs External


Automated Testing
- Unit Testing - focus on small parts of an application
- Integration Testing - focus of cohesion of parts of an application
- Security Testing
	- [[Static-Application-Security-Testing]]
	- [[Dynamic-Application-Security-Testing]]
	- Penetration Testing
- [[Snyk]]
- [[Sonarqube]]

[[CI-CD]] (Continuous Integration OR Continuous D`********`)

>*Note: The term CI/CD has changed quite a bit in recent years. Initially, the primary focus was just on making sure that development was performed using an Agile approach while delivery of the product still occurred using the waterfall model of only deploying final releases. During this time, it was common for CI/CD to mean Continuous Integration and Continuous Development. However, quickly it was realised that deployment itself could also be made Agile and the acronym changed to mean Continuous Integration and Continuous Deployment, with development now becoming part of the Integration component. Finally, they realised that it is not just the deployment, but all aspects around the delivery of the solution and how we monitor it after delivery and the acronym was again changed to now finally mean Continuous Integration and Continuous Delivery. So you might hear these terms used interchangeably, but they all actually refer to the same thing.

[THM Room Pipeline Automation](https://tryhackme.com/room/introtopipelineautomation) states the CI/CD pipeline is:
- Starting Trigger - The action that kicks off the pipeline process. 
- Building Actions - Actions taken to build both the project and the new feature.
- Testing Actions - Actions that will test the project to ensure that the new feature does not interfere with any of the current features of the application.
- Deployment Actions - Should a pipeline succeed, the deployment actions detail what should happen with the build. 
- Delivery Actions - As processes have evolved, the focus is now no longer just on the deployment itself, but all aspects of the delivery of the solution. This includes actions such as monitoring the deployed solution.

Build orchestrators directs various agents
CI/CD agents perform actions within the pipeline

Environments
- Dev for Development
- UAT - User Acceptance Testing for testing features before Prod
- PreProd for mimicing production environment
- Prod for actual active environment with real world concerns
	- Sometimes with Blue/Green deployment strategy
		- Blue is stable
		- Green is most new
	- Sometimes with Canary deployment strategy
		- To smooth release of Production deployments where migration to Production occurs over time
- Disaster Recovery or High Availability: 
	- For switchover in the event of a disaster or high traffic

[[CI-CD-Developer-Bypasses]]
## References

[THM Room Pipeline Automation](https://tryhackme.com/room/introtopipelineautomation)
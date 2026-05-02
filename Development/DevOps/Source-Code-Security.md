# Source Code Security


Version Control
- Centralised (Single Repo)
- Distributed (each user has fork to push to a centralised repo)

Cloud based version control
- [[GitHub]]
	- CI/CD ([[CI-CD]]) with [[Github]] actions
- [[GitLab]] for [[DevSecOps]]
	- CI/CD ([[CI-CD]]) with [[GitLab]] runners

#### Security Fails

Insufficient Credential Hygiene
[THM Room Source Code Security](https://tryhackme.com/room/sourcecodesecurity) Recommendations:
1. Ensure that credentials follow the principle of least privilege from code to deployment.
2. Avoid sharing the same credentials across multiple contexts to maintain accountability and simplify privilege management.
3. Use temporary credentials whenever possible, and establish procedures to rotate static credentials and detect stale credentials periodically.
4. Ensure credentials are only used under predefined conditions, such as limiting usage to a specific IP address or identity.  
5. Detect secrets pushed to and stored in code repositories using Integrated Development Environments (IDE) plugins, automatic scanning, and periodic repository commit scans.
6. Use built-in vendor options or third-party tools to prevent secrets from being printed to console outputs during builds and ensure existing outputs do not contain secrets.
7. Verify that secrets are removed from artefacts, such as image layers and binaries.

[THM Room Source Code Security](https://tryhackme.com/room/sourcecodesecurity) Environment Variables and Best Practices
1. Avoid hardcoding sensitive information in code; use environment variables instead.
2. Regularly review and rotate credentials stored in environment variables.
3. Limit access to environment variables to authorized personnel only.  
4. Environment variables should be set according to the principle of least privilege.
5. Implement monitoring and auditing mechanisms to track changes to environment variables.
6. If implementing a secrets manager solution (explained in the next task), review its encryption mechanisms and if it's a good fit for your development environments.

## References

[THM Room Source Code Security](https://tryhackme.com/room/sourcecodesecurity)
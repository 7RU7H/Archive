# SOC 

Detection

Response

Three pillars of SOC 
- People, Process, Technology

#### Logs

[THM Logs Fundamentals](https://tryhackme.com/room/logsfundamentals)

Logs Use Case

| Use Case                             | Description                                                                                                                                                                                          |
| ------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Security Events Monitoring           | Logs help us detect anomalous behavior when real-time monitoring is used.                                                                                                                            |
| Incident Investigation and Forensics | Logs are the traces of every kind of activity. It offers detailed information on what happened during the incident. The security team utilizes the logs to perform root cause analysis of incidents. |
| Troubleshooting                      | As the logs also record the errors in systems or applications, they can be used to diagnose issues and helpful in fixing them.                                                                       |
| Performance Monitoring               | Logs can also provide valuable insights into the performance of applications.                                                                                                                        |
| Auditing and Compliance              | Logs play a major role in Auditing and Compliance, making it easier with its capability to establish a trail of different kinds of activities.                                                       |
Types of Logs

|Log Type|Usage|Example|
|---|---|---|
|System Logs|The system logs can be helpful in troubleshooting running issues in the OS. These logs provide information on various operating system activities.|- System Startup and shutdown events  <br>- Driver Loading events  <br>- System Error events  <br>- Hardware events|
|Security Logs|The security logs help detect and investigate incidents. These logs provide information on the security-related activities in the system.|-Authentication events  <br>- Authorization events  <br>- Security Policy changes events  <br>- User Account changes events - Abnormal Activity events|
|Application Logs|The application logs contain specific events related to the application. Any interactive or non-interactive activity happening inside the application will be logged here.|- User Interaction events  <br>- Application Changes events  <br>- Application Update events  <br>- Application Error events|
|Audit Logs|The Audit logs provide detailed information on the system changes and user events. These logs are helpful for compliance requirements and can play a vital role in security monitoring as well.|- Data Access events  <br>- System Change events  <br>- User Activity events  <br>- Policy Enforcement events|
|Network Logs|Network logs provide information on the network’s outgoing and incoming traffic. They play crucial roles in troubleshooting network issues and can also be handy during incident investigations.|- Incoming Network Traffic events  <br>- Outgoing Network Traffic events  <br>- Network Connection Logs - Network Firewall Logs|
|Access Logs|The Access logs provide detailed information about the access to different resources. These resources can be of different types, providing us with information on their access.|- Webserver Access Logs  <br>- Database Access Logs - Application Access Logs  <br>- API Access Logs|
## References

[THM SOC FUndementals](https://tryhackme.com/room/socfundamentals)
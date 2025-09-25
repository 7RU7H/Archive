# Web Applications

Use the [[Client-Server-Model]] to host a service over [[HTTP]], but more recently [[HTTPS]] with [[SSL-TLS]].
## Structure of Web Application

Developers will use Frontend and Backend to refer to where in the application they develop for
- Frontend 
	- UI of the application
	- Communicates to the Backend via API
- Backend
	- Server-side component:
		- Processes user requests
		- Queries databases
		- Serves data to the Frontend  

Seperation of the Web application, by logic into a multi-tier architecture.
- Presentation Tier:
	- Rending of [[HTML]], [[CSS]] and [[JavaScript]]
- Application Tier:
	- Application’s business logic and functionality receiving client requests, processing requests, and interacting with the data tier
- Data tier:
	- Storing and modifying data in Databases

## References

[THM Room: File Inclusion, Path Traversal](https://tryhackme.com/room/filepathtraversal)
[THM Race Conditions](https://tryhackme.com/r/room/raceconditionsattacks)
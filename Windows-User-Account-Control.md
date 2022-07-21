# User Account Control

## Introduction

[User Account Control](https://docs.microsoft.com/en-us/windows/security/identity-protection/user-account-control/user-account-control-overview): *"User Account Control (UAC) helps prevent malware from damaging a PC and helps organizations deploy a better-managed desktop. With UAC, apps and tasks always run in the security context of a non-administrator account, unless an administrator specifically authorizes administrator-level access to the system. UAC can block the automatic installation of unauthorized apps and prevent inadvertent changes to system settings."* Essential is forces any new process to run within the security context of a non-privileged account, including if administrator creates a new process. If you are attempting to circumvent UAC see [[Bypassing-Windows-User-Account-Control]]

UAC has two modes:
1. Credential prompt - Provide credentials
2. Consent prompt - Consent to action

UAC logs activity on the machine to allow for the above and notifying Administrative Account to respond to incidents. Even some context where the users is an administrator the account has two security tokens one  on medium and the other on high integrity. Some actions required high integrity  level even as administrative user. 

## Integrity Levels

UAC is a Mandatory Integrity Control (MIC), a mechanicism that differentiates users, processes and resources by assigning each an Integrity Level. The higher the Integrity Level the higher the access token. MIC takes precedence over Windows DACL(see [[Windows-Discretionary-Access-Control-List]])

Integrity Level | Use
--- | ---
Low | Generally used for interaction with the Internet (i.e. Internet Explorer). Has very limited permissions.  
Medium | Assigned to standard users and Administrators' filtered tokens.  
High | Used by Administrators' elevated tokens if UAC is enabled. If UAC is disabled, all administrators will always use a high IL token.  
System | Reserved for system use.

## Filtered Tokens
To account for seperate roles:
1. Non-Administratorsrecieve a single access token when logged in with - Medium IL
2. Administrators recieve two tokens:
	1. Filter Token: Token with Administrator Privileges stripped for regular use - Medium IL
	2. Elevate Token: Token with full Administrator privileges used only when Adminstrator requires administrative privileges - High IL

## UAC Settings

1. Always notify: Install software or make changes to your computer, changing Windows settings, Freezes task until response.
1. Notify me only when programs try to make changes to my computer: Administrators won't be prompted when changing Windows settings.
3. Notify me only when programs try to make changes to my computer (do not dim my desktop): Same as above, but won't run the UAC prompt on a secure desktop.  
4. Never notify: Disables UAC prompt. Administrators will run everything using a high privilege token.

## UAC Internals 



## References
[UAC Documentation](https://docs.microsoft.com/en-us/windows/security/identity-protection/user-account-control/user-account-control-overview)
[UAC Settings Documentation](https://support.microsoft.com/en-us/windows/about-user-account-control-settings-d5b2046b-dcb8-54eb-f732-059f321afe18)
[MIC Documentation](https://docs.microsoft.com/en-us/windows/win32/secauthz/mandatory-integrity-control)
[THM Room](https://tryhackme.com/room/bypassinguac)
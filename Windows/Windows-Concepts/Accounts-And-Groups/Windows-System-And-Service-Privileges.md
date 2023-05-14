# Windows System And Service Privileges

Microsoft: *"A [Privilege](https://docs.microsoft.com/en-us/windows/win32/secauthz/privileges) is the right of an account, such as a user or group account, to perform various system-related operations on the local computer, such as shutting down the system, loading device drivers, or changing the system time. Privileges differ from access rights in two ways:*
- *Privileges control access to system resources and system-related tasks, whereas access rights control access to [securable objects](https://learn.microsoft.com/en-us/windows/win32/secauthz/securable-objects).*
-   *A system administrator assigns privileges to user and group accounts, whereas the system grants or denies access to a securable object based on the access rights granted in the [Access Control Entries (ACEs)](https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-entries) in the object's DACL...* - [security descriptor](https://docs.microsoft.com/en-us/windows/win32/secauthz/security-descriptors)
	- Consider reviewing:
		- [[Windows-Discretionary-Access-Control-List]] 
		- [[Windows-User-Account-Control]] and [[Bypassing-Windows-User-Account-Control]]
...*Each system has an account database that stores the privileges held by user and group accounts"* and each logon event produces an access token for that user. Most privileges are disabled by default and some can be modified with administrative terminal or manually. 

Consider the ramification with: [[SePrivilege-Token-Table]]

#### Local System

The [LocalSystem](https://docs.microsoft.com/en-us/windows/win32/services/localsystem-account?redirectedfrom=MSDN) account has the following privileges:

-   **SE_ASSIGNPRIMARYTOKEN_NAME** (disabled)
-   **SE_AUDIT_NAME** (enabled)
-   **SE_BACKUP_NAME** (disabled)
-   **SE_CHANGE_NOTIFY_NAME** (enabled)
-   **SE_CREATE_GLOBAL_NAME** (enabled)
-   **SE_CREATE_PAGEFILE_NAME** (enabled)
-   **SE_CREATE_PERMANENT_NAME** (enabled)
-   **SE_CREATE_TOKEN_NAME** (disabled)
-   **SE_DEBUG_NAME** (enabled)
-   **SE_IMPERSONATE_NAME** (enabled)
-   **SE_INC_BASE_PRIORITY_NAME** (enabled)
-   **SE_INCREASE_QUOTA_NAME** (disabled)
-   **SE_LOAD_DRIVER_NAME** (disabled)
-   **SE_LOCK_MEMORY_NAME** (enabled)
-   **SE_MANAGE_VOLUME_NAME** (disabled)
-   **SE_PROF_SINGLE_PROCESS_NAME** (enabled)
-   **SE_RESTORE_NAME** (disabled)
-   **SE_SECURITY_NAME** (disabled)
-   **SE_SHUTDOWN_NAME** (disabled)
-   **SE_SYSTEM_ENVIRONMENT_NAME** (disabled)
-   **SE_SYSTEMTIME_NAME** (disabled)
-   **SE_TAKE_OWNERSHIP_NAME** (disabled)
-   **SE_TCB_NAME** (enabled)
-   **SE_UNDOCK_NAME** (disabled)

#### Local Service

The [LocalService](https://docs.microsoft.com/en-us/windows/win32/services/localservice-account?redirectedfrom=MSDN) account has the following privileges:

-   **SE_ASSIGNPRIMARYTOKEN_NAME** (disabled)
-   **SE_AUDIT_NAME** (disabled)
-   **SE_CHANGE_NOTIFY_NAME** (enabled)
-   **SE_CREATE_GLOBAL_NAME** (enabled)
-   **SE_IMPERSONATE_NAME** (enabled)
-   **SE_INCREASE_QUOTA_NAME** (disabled)
-   **SE_SHUTDOWN_NAME** (disabled)
-   **SE_UNDOCK_NAME** (disabled)
-   Any privileges assigned to users and authenticated users


#### Network Service

The [NetworkService](https://docs.microsoft.com/en-us/windows/win32/services/networkservice-account?redirectedfrom=MSDN0) account has the following privileges:

-   **SE_ASSIGNPRIMARYTOKEN_NAME** (disabled)
-   **SE_AUDIT_NAME** (disabled)
-   **SE_CHANGE_NOTIFY_NAME** (enabled)
-   **SE_CREATE_GLOBAL_NAME** (enabled)
-   **SE_IMPERSONATE_NAME** (enabled)
-   **SE_INCREASE_QUOTA_NAME** (disabled)
-   **SE_SHUTDOWN_NAME** (disabled)
-   **SE_UNDOCK_NAME** (disabled)
-   Any privileges assigned to users and authenticated users


## References

[LocalSystem](https://docs.microsoft.com/en-us/windows/win32/services/localsystem-account?redirectedfrom=MSDN)
[LocalService](https://docs.microsoft.com/en-us/windows/win32/services/localservice-account?redirectedfrom=MSDN)
[NetworkService](https://docs.microsoft.com/en-us/windows/win32/services/networkservice-account?redirectedfrom=MSDN0)
[securable objects](https://learn.microsoft.com/en-us/windows/win32/secauthz/securable-objects)
[Privilege](https://docs.microsoft.com/en-us/windows/win32/secauthz/privileges) 
[Access Control Entries (ACEs)](https://docs.microsoft.com/en-us/windows/win32/secauthz/access-control-entries)
# Discretionary Access Control List

(DACL) An access control list that is controlled by the owner of an object and that specifies the access particular users or groups can have to the object. It can be attached to an object in Active Directory that specifies which users and groups can access the object and what kinds of operations they can perform. Whereas an (ACL) a list of security protections that applies to an object. (An object can be a file, process, event, or anything else having a security descriptor.) An entry in an access control list (ACL) is an access control entry (ACE). 

## Note on Security 
*"If a Windows object does not have a [discretionary access control list](https://docs.microsoft.com/en-us/windows/desktop/SecGloss/d-gly) (DACL), the system allows everyone full access to it. If an object has a DACL, the system allows only the access that is explicitly allowed by the [access control entries](https://docs.microsoft.com/en-us/windows/desktop/SecGloss/a-gly) (ACEs) in the DACL. If there are no ACEs in the DACL, the system does not allow access to anyone. Similarly, if a DACL has ACEs that allow access to a limited set of users or groups, the system implicitly denies access to all trustees not included in the ACEs."


## References

[Microsoft Glossary A](https://docs.microsoft.com/en-us/windows/win32/secgloss/a-gly)
[Microsoft Glossary D](https://docs.microsoft.com/en-us/windows/win32/secgloss/d-gly)
[Win32 app Documentation](https://docs.microsoft.com/en-us/windows/win32/secauthz/dacls-and-aces)
[networkencyclopedia](https://networkencyclopedia.com/discretionary-access-control-list-dacl/)
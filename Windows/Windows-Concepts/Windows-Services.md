## Windows Services

A _service application_ conforms to the interface rules of the Service Control Manager (SCM).
Services have a Discretionary Access Control List (DACL) indicating whom can start, stop, pause, query status, query configuration, or reconfigure privileges, etc. Service configuration are stored in the registry under: `HKLM\SYSTEM\CurrentControlSet\Services`.

```batch
sc qc <servicename>
SERVICE_NAME: #name ; The output below is corresponds to registry subkey anems
        TYPE               : 20  WIN32_SHARE_PROCESS
        START_TYPE         : 2   AUTO_START 
        ERROR_CONTROL      : # 0 IGNORE, 1 NORMAL
        BINARY_PATH_NAME   : # C:\path\to\parent_service.exe -flag <servicename>
        LOAD_ORDER_GROUP   : 
        TAG                : 0
        DISPLAY_NAME       : # Display name..
        DEPENDENCIES       :
        SERVICE_START_NAME : # Account used to run the service
```

Use `icalcs <*.exe>`  to check permissions.

## References
[Microsoft Docs](https://docs.microsoft.com/en-us/windows/win32/services/services)
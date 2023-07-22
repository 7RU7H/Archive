# Windows Services

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

Most services can be:
- Started
- Stopped
- Suspended (Paused) - see [Suspend-Service](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/suspend-service?view=powershell-7.3)
- Resumed


#### Print Spooler Service 

A Print Spooler Service is defined by Microsoft as: *"The [Print Spooler](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-prsod/b1e6690e-453a-4415-9506-2706ba31feac#gt_c6bde257-38a5-43bb-8d0e-204e226b3655) service is a service that is running on each computer that participates in the Print Services system. The Print Spooler service implements the [print client](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-prsod/b1e6690e-453a-4415-9506-2706ba31feac#gt_3b2da3d1-c159-4399-a6dd-dfd5f76fa2f5) and [print server](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-prsod/b1e6690e-453a-4415-9506-2706ba31feac#gt_59fb3ddc-63cf-45df-8a90-46a6af9e00cb) roles, by enabling each participating system to act as a print client, administrative client, or print server for the Print Services system."*


## References
[Microsoft Docs](https://docs.microsoft.com/en-us/windows/win32/services/services)
[Print Spooler Microsoft Documentation](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-prsod/b1e6690e-453a-4415-9506-2706ba31feac#gt_c6bde257-38a5-43bb-8d0e-204e226b3655)  
[Print client Microsoft Documentation](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-prsod/b1e6690e-453a-4415-9506-2706ba31feac#gt_3b2da3d1-c159-4399-a6dd-dfd5f76fa2f5) 
[Print server Microsoft Documentation](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-prsod/b1e6690e-453a-4415-9506-2706ba31feac#gt_59fb3ddc-63cf-45df-8a90-46a6af9e00cb) 
[Suspend-Service Microsoft PowerShell Documentation](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/suspend-service?view=powershell-7.3)
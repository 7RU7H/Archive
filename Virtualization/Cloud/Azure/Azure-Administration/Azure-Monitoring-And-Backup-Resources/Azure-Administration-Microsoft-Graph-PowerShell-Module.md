# Azure-Administration Microsoft.Graph PowerShell Module

For the deprecated [[Azure-PowerShell-Module]] follow the local link. [For a good explanation see - John Savill Azure AD PowerShell Module Migration](https://youtu.be/EiD6CbbBLMs)

![1080](microsoftgraphwhatis.png)


Setup
```powershell
# Minimum PowerShell version
Install-Module -Name Microsoft.Graph
# List all submodules in Microsoft.Graph
get-module -listavailable -name microsoft.graph.*
# Submodule command systax  
# BEWARE scripting in deprecated Azure Powershell module arguements and parametres HAVE CHANGED! no `sed 's/Az/Mg/g'` everything :(
Get-Mg # Retrieve information
New-Mg # Create Mgure X
Update-Mg # Update Mgure X
Add-Mg # Add X to Existing Mgure Y
Move-Mg # Move Mg X to Y
Export-Mg # Capture to a template
Import-Mg # Import config
Remove-Mg # Remove..
Select-Mg # Select != Get; Choose X
Invoke-Mg # Contruct and Perform X
Clear-Mg # Clear settable values
Set-Mg # Opposite of Clear, Set values
```


## References

[Microsoft Learn | Overview of Microsoft Graph](https://learn.microsoft.com/en-us/graph/overview?view=graph-rest-1.0)
[John Savill Youtube - Azure AD PowerShell Module Migration](https://youtu.be/EiD6CbbBLMs)

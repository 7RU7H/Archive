# Azure Administration- ARM Templates

#### Introduction to ARM Templates


[Template Specs](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/template-specs?tabs=azure-powershell) is a resource type for storing an Azure Resource Manager template (ARM template) in Azure for later deployment. This resource type enables you to share ARM templates with other users in your organization. Just like any other Azure resource, you can use Azure role-based access control (Azure RBAC) to share the template spec. Template Gallery is to deprecated by 2025 - [Convert portal template to template spec - Azure Resource Manager | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/template-spec-convert?WT.mc_id=Portal-HubsExtension)


ARM Templates are [[Infrastructure-As-Code]] (IaC) - the process of managing and provisioning computer data centers through machine-readable definition files (JSON files) rather than physical hardware configuration or interactive configuration tools - ARM is declarative, JSON files that define Azure Resources to provision and Azure services to configure. ARM template positives:
- Reduce Configuration Mistakes
- Stand up or Tear down or Sharing is quick
- Knownable definion of a stack
- Establishes baseline compliance
- Modular 
- Reusable - due to modularity
- Extensibility - Add Bash and Powershell scripting!
- Testing - ARM template Toolkit
- Preview Changes 
- Tracked Deployments
- Policy as Code - Application of Azure Policies
- Microsoft Blueprints - establish relationship between resource and template
- CI/CD integration
- Exportable Code - export current state of resource groups and resources
- Authoring Tools - Visual Studio Code has advanced features for authoring ARM templates

`Search -> Deploy custom template` - there are common templates:
-    [Create a Linux virtual machine](https://portal.azure.com/#)
-    [Create a Windows virtual machine](https://portal.azure.com/#)
-    [Create a web app](https://portal.azure.com/#)
-    [Create a SQL database](https://portal.azure.com/#)
-    [Azure landing zone](https://portal.azure.com/#)

You can also [Build your own template in the editor](https://portal.azure.com/#) 
- [ARM template documentation | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/)
- Add resource button can do lot heavy code lifting

When it deployment fails it does not perform cleanup - manual resource deletion or [roll back feature](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/rollback-on-error)

#### ARM Template Skeleton

Basic Skeleton of template with comments explaining use case
```json
{
  "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "apiProfile": "", // Valure to avoid having to specify API versions foreach resource in the template 
  "parameters": {}, //values passed to template 
  "variables": {}, // transform parameteres or resources properties using function expressions
  "functions": [], // User-Defined functions available within the template
  "resources": [] // Azure resource you want to deploy or update 
}
```

Example Resource use
```json
//...
  "resources": [
      {
          "type": "Microsoft.Storage/storageAccounts", // {ResourceProvider}/ResourceType
          "apiVersion": "2019-01-01", //resource proivdes provider their own API!
          "name": "{provide-unique-name}", // variable used here
          "location": "eastus", //region to be deployed
          "sku": {
              "name": "Standard_LRS"
          },
          "kind": "StorageV2",
          "properties": {
              "supportsHttpsTrafficOnly": true
          }
      }
  ]
//...
```
- Must lookup resource providers API version!

Example Parameter use:
```json
//...
// Set parameters in this block
"parameters": { 
	"storageName": {
		"type": "string",
		"minLength": 5,
		"maxlength": 20,
		"defaultValue": "DefaultStorage",
		//"minValue":
		//"maxValue":
		//"allowedValue"
		"Description": "This is example of parameter passed to this template" //Displayed in Azure Portal
	}
},
//...
// Accessing a paramater:
"resources" {
//...
	"name": "[parameters('storageName')]",
}
```

Functions
- Template Functions are builtin function - some available:
	- Array
	- Comparison
	- Date
	- Deployment - deployment, environment, parameteres and variables (the later can both be functions)
	- Logical
	- Numeric
	- Object - contains, empty, intersection, json, length, union
	- Resource: extensionResourceId, ListAccountSas, listKeys, listSecrets, list\*, picZone, providers, reference, resourceGroup, resourceID, subscription, subscriptionREsourceId, tenantResourceId 
	- String

- User-Defined Functions are creatable custom functions

Variables
```json
//...
"variables": {
	"storageName": "[concat(toLower(parameters('storageNAmePrefix')), uniqueString(resourceGRoup().id))]"
},
//...
"resources": [ 
	{
	"type": "Microsoft.Storage/storageAccounts",
	"name": "[variables('storageName')]",
	//...
	}
]


// Variable can be nested to scope variabels for multiple use cases:
// Parameter to choose environment:
"parameters": {
	"environmentName": {
		"type": "string",
		"allowedValue": [
			"test",
			"prod"
		]
	}
}
// Nested Variables for scoping: 
"variables": {
	"environmentSettings": {
		"test": {
			"instancesSize": "Small",
			"instanceCount": 1
		},
		"prod": {
			"instancesSize": "Large",
			"instanceCount": 1
		}
​￼￼￼References

	}
}
// Referencing nested variables:
"[variables('environmentSettings')[parameters('environmentNames')].instanceSize]"
```

ARM Template Outputs return values from deployed resources:
```json
"outputs": {
	"resourceID": {
		"type": "string",
		"value": "[resourceId('Microsoft.Netowkr/publiIPAddress', parameters('publicIPAddress_name'))]"
	}
}
```

​￼￼￼References

You can use Azure API via CLI,  PowerShell or SDK to fetch outputs. 

## References

[Create & deploy template specs - Azure Resource Manager | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/template-specs?tabs=azure-powershell)
[Create a Linux virtual machine](https://portal.azure.com/#)
[Create a Windows virtual machine](https://portal.azure.com/#)
[Create a web app](https://portal.azure.com/#)
[Create a SQL database](https://portal.azure.com/#)
[Azure landing zone](https://portal.azure.com/#)
[Build your own template in the editor](https://portal.azure.com/#) 
[ARM template documentation | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/)
[Roll back feature](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/rollback-on-error)
[Convert portal template to template spec - Azure Resource Manager | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/template-spec-convert?WT.mc_id=Portal-HubsExtension)
[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
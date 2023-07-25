# Azure-Administration Log Analytics

Log Analytics an Azure Portal Tool to **edit and run log queries** with data in Azure Monitor Logs -  Log Analytics use [KQL](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/query/) - Kusto Query Language

Log Analytics workspace is a unique environment for Azure monitor Log Data; each has its own data repository and configuration, data sources and solutions are configured to store their data in a workspace.

Azure Monitor Logs is based on Azure Data Explorer, and log queries are written using the same KQL
- KQL used in:
	- Log Analytics
	- Log Alert Rules
	- Workbooks
	- Azure Dashboards
	- Logic Apps
	- PowerShell
	- Azure Monitor Logs API

- Kusto is based on relational database management systems and supports entities such as databases, tables and columns
-  Kusto queries are read-only requests
	- Some query operators include:
		- Calculated columns, searching and filtering on rows, group by-aggregates, join functions
- Kusto queries execute in context of some Kusto database that is attached to a Kusto cluster
- Kusto is generally composed of the following entities:
	- Clusters - are entities that hold databases
	- Databases - are named entities that allow reuse of Kusto queries or query parts
	- Tables  - are named entities that hold data
	- Columns - columns are named entities that have a scalar data type
	- Stored Functions - are named  entities that allow reuse of Kusto queries or query parts 
	- External tables are entities that have a scalar data stored outside Kusto database
- You can and more:
	- Search and sort by value, time, property state, and more
	- Join data from multiple tables
	- Aggregate large sets of data
	- Perform intricate operations with minimal code
- Groups of series of tables are called a schema 

Scenarios:
- Assess update requirement and time-to-complete
- Track Changes and identiy access issues
- Security 

The following illustration highlights how KQL queries use the dedicated table data for your monitored services and resources.
![1080](azurekglqueries.png)

Correctly designing a Log Analytics workspace deployment is important. Log Analytics workspaces are containers where Azure Monitor data is collected, aggregated, and analyzed.
- Access mode
	- workspace-context: access to all log in workspace where the permission is assigned 
	- resource-context: provides access to view logs for resources in all tables you have access to
- Access control mode
	- how permissions work for any given Log Analytics workspace
		- Require workspace permissions - no granular RBAC
		- Use resource or workspace permissions - granular RBAC
- Table-level RBAC - Very granular RBAC at the table level

Azure Monitor data teirs:
![](azuremonitoringtier.png)

Tiering of Log data mapping:
![](azurelogeventtiering.png)

## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg)
[KQL](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/query/) 
[Azure Monitor Metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/data-platform-metrics)
[Azure Monitor Logs](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/data-platform-logs)
[Supported regions for linked Log Analytics workspace | Microsoft Learn](https://learn.microsoft.com/en-us/azure/automation/how-to/region-mappings)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
[John Savill](https://www.youtube.com/@NTFAQGuy) 
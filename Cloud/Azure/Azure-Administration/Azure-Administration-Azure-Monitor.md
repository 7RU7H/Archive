
# Azure Administration - Azure Monitor

Azure Monitor is the comprehensive solution for collecting, analyzing and acting on telemetry from cloud and on-premise linked environments. **Azure Monitor collects Logs and Metrics** and enables you to gather monitoring and diagnostic information about the health of your services. You can use this information to visualize and analyze the causes of problems that might occur in your app.

- Create Visual Dashboards
- Alerts
- Automated Actions
- Log Monitoring

To obtain observability you need to use Metrics, Logs (Metrics and Logs are two base data types) and Traces.
- You have to use them together, using them in isolate does not increase visibility
	- [Azure Monitor Metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/data-platform-metrics)
	- [Azure Monitor Logs](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/data-platform-logs)
		- Data logs are consolidated from differenct sources into workspaces
			- Platform logs from Azure services
			- Log and performance data from applcations can be consolidated
			- Usage and performance data from applications can be consolidated
			- In workspace so they can be analyzed together using a sophisticated query language capable of analyzing millions of records
	- Work with log queries and their resuls [KQL](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/query/)  interactively using Log Analytics
- Azure Monitor Metrics collects numeric data from monitored resources into a time series database. Analyze with **Metrics Explorer** 
	- Metrics are numerical values collected at regular intervals and describe some aspect of system at a particular time
	- Lightweight and capable of supporting near real-time
- Troubleshooting 
	- Traces:  A history request which travels through multiple Apps/services for troubleshooting failure
- [Azure Monitor Insights](https://learn.microsoft.com/en-us/azure/azure-monitor/insights/insights-overview)
	- Get insights
		-  Application Performance Monitoring (APM) tools monitor app performance and gather trace logging data.
	- Visualize
		- Power BI with the Azure Workbooks
	- Analyze 
		- Logs with queries I
		- Interactive analysis withAzureMonitor Metrics analysis engine
	- Alerts
	- Integrate data with Ingestor and Exportign log data with Azure CLI Powershell, and APIs.


![](azuremonitorcomponents.png)

All data collected by Azure Monitor is either a [metric or log](https://learn.microsoft.com/en-us/azure/azure-monitor/platform/data-collection) data type. 
- **Metrics** are numerical values that describe some aspect of a system at a particular point in time. Metrics are lightweight and capable of supporting near real-time scenarios.
	- 
- **Logs** contain different kinds of data organized into records with different sets of properties for each type. Data like events and traces are stored as logs along with performance data so all the data can be combined for analysis.
	- Log Events 
		- Includes a range of data at the subscription-level
		- Kept for 90 days
		- Log any write operation (PUT, POST, DELETE)
		- Status of resources
		- Activity logs of Azure Portal, CLI, Powershell cmdlets and Azure Monitor REST API
			- Filtered by:
				- Subscription
				- Timespan
				- Event severity
				- Resource Group
				- Resource
				- Resource type
				- Operation name - ARM operation
				- Event initation caller
			- Downloadable into a CSV file

Tiering of Log data mapping:
![](azurelogeventtiering.png)

Event Catergories
![](azurelogeventcatergories.png)

## Log Analytics

Log Analytics an Azure Portal Tool to **edit and run log queries** with data in Azure Monitor Logs -  Log Analytics use [KQL](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/query/) - Kusto Query Language

Log Analytics workspace is a unique environment for Azure monitor Log Data; each has its own data repository and configuration, data sources and solutions are configured to store their data in a workspace

Azure Monitor Logs is based on Azure Data Explorer, and log queries are written using the same KQL
- KQL used in:
	- Log Analytics
	- Log Alert Rules
	- Workbooks
	- Azure Dashboards
	- Logic Apps
	- PowerShell
	- Azure Monitor Logs API

- Kusto is based on relational database management systems and supports entirties such as databases, tables and columns
	- Some query operators include:
		- Calculated columns , searching and filtering on rows, group by-aggregates, join functions
- Kusto queries execute in context of some Kust database that is attached to a Kusto cluster
- Kusto is generally composed of the follwing entites:
	- Clusters - are entities that hold databases
	- Databases - are named entities that allow reuse of Kusto queries or query parts
	- Tables  - are named entities that hold data
	- Columns - columns are named entities that have a scalar data type
	- Stored Functions - are named  entities that allow reuse of Kusto queries or query parts 
	- External tables are entities that have a scalar data stored outside Kusto database

## Metric Explorer
 
 **Metric Explorer** is a sub-service of Azure Monitor that allows you to plot charts, visualize correlating trends, and investigate spikes and dips in metrics value. To visualize a metric you need to define:
	- Scope: You can select \*resource(s)
	- Namespace: A specific group of metric data within a resource
	- Metric: Value to visualize
	- Aggregation: groups of values

## Alerts

Alert notification for issues are found on infrastructure or application
- Identify and address issues before the users of your system notice them.
- Azure has 3 kinds of Alerts
	1. Metric Alerts
	2. Log Alerts
	3. Activity Log Alerts

## Dashboards 

Azure Dashboards are virtual workspaces - day-to-day operations and monitor resources
Azure Workbooks - visual reporting
Application Insights is a Application Permformance Management (APM) service it is a sub-service of Azure Monitor
- Automatic performa anomaly reporting
- Analytics and diagnostic tooling
- Works for apps for .NET, Node.js, Java and Python hosted on-premises, hybrid or any public cloud
- Integrates with DevOps process
- Can monitor and analyze telemetry from mobile apps by integrating with Visual Studio App Center

## Insights

To use Application insights you need to instrument your application
- To instrument you need to install the instrument package (SDK)
- Or enable Application Insights using the Application Insights Agents when supported
- Apps can be instrumented from anywhere
- When you set up Application Insights monitoring for your web app, you create an Application Insights resource in Microsoft Azure
- You open this resource in the Azure portal in order to see and analyze the telemety collected your app.
The resource is identified by an instrumentation key (ikey)

## Workflows

Access Azure Monitor
`Search -> Monitor`

Register the Microsoft.Insights and Microsoft.AlertsManagement resource providers 
```powershell
Register-AzResourceProvider -ProviderNamespace Microsoft.Insights
Register-AzResourceProvider -ProviderNamespace Microsoft.AlertsManagement
```

Metrics 
`Search -> Monitor -> Metrics -> Select a Scope (Tree View)`

Create an (metric) Alert 
`Search -> Monitor -> Alerts -> Create

Create an (metric) Alert 
`Search -> Monitor -> Metrics -> New Alert Rule

Log Analytics Querying - Has drop down listing of useful input!
`Search -> Monitor -> Logs -> Select a scope -> (Tables | Queries | Functions | Filters)  -> Run Query`
- You can click to collapse the left panel

Create and Configure Log Analytics workspaces
`Search Log Analytics workspaces -> Log Analytics workspaces -> Create`
`Search Automation Accounts -> Create -> $LAWrGroup` - check [supported mappings](https://learn.microsoft.com/en-us/azure/automation/how-to/region-mappings) then `$AutomationAccount -> Inventory -> Select Log Analytics workspace -> $LAW & Enable` then `Update Management -> Enable`

Configure VM for Log Analytics
`Search -> Virtual Machines -> $VM -> (Metrics - for default Monitoring) Diagnostic settings -> Select a Diagnostics storage account & Enable guest-level monitoring` then configure: 
- Performance Counters
- Logs
- Crash dumps Sinks 
- Agent
Then `$VM -> Logs -> Enable -> chooose a Log Analytucs Workspace -> Enable `

## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg)
[KQL](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/query/) 
[Azure Monitor Metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/data-platform-metrics)
[Azure Monitor Logs](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/data-platform-logs)
[Azure Monitor Insights](https://learn.microsoft.com/en-us/azure/azure-monitor/insights/insights-overview)
[Supported regions for linked Log Analytics workspace | Microsoft Learn](https://learn.microsoft.com/en-us/azure/automation/how-to/region-mappings)
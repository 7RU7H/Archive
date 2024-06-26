# Azure Administration - Azure Monitor

Azure Monitor is the comprehensive solution for collecting, analysing and acting on telemetry from cloud and on-premise linked environments. **Azure Monitor collects Logs and Metrics** and enables you to gather monitoring and diagnostic information about the health of your services. You can use this information to visualise and analyse the causes of problems that might occur in your app.

- Create Visual Dashboards
	- Monitor and visualise metrics
	- Query and analyse Logs
- Alerts and Action groups
- Log Monitoring
- Agents and Extension disambiguation
	- Azure Monitor Agent - Collects monitoring data 
		- Will replace the both Log Analytics Agent and Azure diagnostic at some point:
		- Azure Diagnostic Extension - Enables customers to receive extra data from guest OSes and Workload on Azure resource
		- Log Analytics agent - Collects logs and performance data for Azure Resources
			- for Linux as part of a solution to collect JSON output
	- Azure Custom Script Extension
		- is used for post-deployment configuration, software installation, or any other configuration or management task.
	- Desired State Configuration (DSC) 
		- is a management platform to manage an IT and development infrastructure with configuration as code.
	- Dependency Agent 
		- Collects discovered data about certain processes to maps all dependencies between virtual machines and any external process dependencies.
	- Azure VMAccess extension
		- acts as a KVM switch that allows you to access the console to reset access to Linux or perform disk-level maintenance.

![](azuremonitorcollectionagents.png)

To obtain observability you need to use Metrics, Logs (Metrics and Logs are two base data types) and Traces.
- You have to use them together, using them in isolate does not increase visibility
	- [Azure Monitor Metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/data-platform-metrics)
	- [Azure Monitor Logs](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/data-platform-logs)
		- Data logs are consolidated from different sources into workspaces
			- Platform logs from Azure services
			- Log and performance data from applications can be consolidated
			- Usage and performance data from applications can be consolidated
			- In workspace so they can be analysed together using a sophisticated query language capable of analysing millions of records
	- Work with log queries and their results [KQL](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/query/)  interactively using Log Analytics
- Azure Monitor Metrics collects numeric data from monitored resources into a time series database. Analyse with **Metrics Explorer** 
	- Metrics are numerical values collected at regular intervals and describe some aspect of system at a particular time
	- Lightweight and capable of supporting near real-time
- Troubleshooting 
	- Traces:  A history request which travels through multiple Apps/services for troubleshooting failure
- [Azure Monitor Insights](https://learn.microsoft.com/en-us/azure/azure-monitor/insights/insights-overview)
	- Get insights - Author joke-note: reminder to play Paranoid by Black Sabbath whenever opening this article or Azure Monitor
		-  Application Performance Monitoring (APM) tools monitor app performance and gather trace logging data.
	- Visualise
		- Power BI with the Azure Workbooks
	- Analyse 
		- Logs with queries 
		- Interactive analysis with Azure Monitor Metrics analysis engine
	- Alerts - Respond every 5 minutes to SMS 
	- Integrate data with Ingestor and Exporting log data with Azure CLI PowerShell, and APIs.

Components of Azure Monitor:
![](azuremonitorcomponents.png)
Azure Monitor can collect log data from any REST client by using the Data Collector API.

Azure Monitor collects data automatically from a range of components:
- **Application data**: Data that relates to your custom application code.
- **Operating system data**: Data from the Windows or Linux virtual machines that host your application.
- **Azure resource data**: Data that relates to the operations of an Azure resource, such as a web app or a load balancer.
- **Azure subscription data**: Data that relates to your subscription. It includes data about Azure health and availability.
- **Azure tenant data**: Data about your Azure organisation-level services, such as Azure Active Directory.
- **Custom Sources**:
	- Azure Monitor can collect log data from any REST client by using the Data Collector API, you can create custom monitoring scenarios

All data collected by Azure Monitor is either a [metric or log](https://learn.microsoft.com/en-us/azure/azure-monitor/platform/data-collection) data type. 
- **Metrics** are numerical values that describe some aspect of a system at a particular point in time. Metrics are lightweight and capable of supporting near real-time scenarios. Viewable:
	- Metrics are displayed on Overview page for a resource in Azure portal
	- Azure Monitor metrics explorer
- **Logs** contain different kinds of data organised into records with different sets of properties for each type. Data like events and traces are stored as logs along with performance data so all the data can be combined for analysis.
	- Log Events 
		- Includes a range of data at the subscription-level
		- Kept for 90 days
		- Log any write operation (PUT, POST, DELETE)
		- Status of resources
		- Activity logs of Azure Portal, CLI, PowerShell cmdlets and Azure Monitor REST API
			- Filtered by:
				- Subscription
				- Time span
				- Event severity
				- Resource Group
				- Resource
				- Resource type
				- Operation name - ARM operation
				- Event initiation caller
			- Downloadable into a .csv file

Azure Monitor data teirs:
![](azuremonitoringtier.png)

Activity Logs
- Determine the "what, who, and when" for any write operation (PUT, POST, DELETE) performed on resources in your subscription.
- Kept for 90 days
- Retrieve events from activity logs with:
	- Azure portal
	- the Azure CLI
	- PowerShell cmdlets
	- Azure Monitor REST API

Tiering of Log data mapping:
![](azurelogeventtiering.png)

Event Categories
![](azurelogeventcatergories.png)

## Metric Explorer
 
 **Metric Explorer** is a sub-service of Azure Monitor that allows you to plot charts, visualize correlating trends, and investigate spikes and dips in metrics value. To visualize a metric you need to define:
- Scope: You can select \*resource(s)
- Namespace: A specific group of metric data within a resource
- Metric: Value to visualize
- Aggregation: groups of values

## Azure Alerts

Azure Administrators use Azure Monitor to receive alerts for their monitored applications and resources. Consider reading [[Azure-Administration-Azure-Monitor]] for further Azure Monitor details as Azure Monitor captures logs and metrics telemetry data for administed infrastructure or applications that can then be analyzed and used to identify potential problems. Alert notification for issues are found on infrastructure or application, but require you to configure Azure Monitor to capture telemetry data for your Azure services, resources, and applications.

![1080](azurealertsdescriptionimage.png)

- Identify and address issues before the users of your system notice them.
- Azure has 3 kinds of Alerts
	1. Metric Alerts trigger when a specified threshold is exceeded
		- Metric based data is the numerical time-sensitive values that represent some aspect of the target resource 
	1. Log Alerts notify you when Azure resources change state
		- Log based data is the querying of content data held in structured, record-based log files that are relevant to the target resource.
	2. Activity Log events  notify you when Azure resources change state
- Other include
	- Smart detection alerts - Automatic warnings about issues in web apps through Application insights 
		- Migrate smart detection tyo create alert rules. 
- An alert consists of Alert Rules that combine the settings and conditions you want to monitor, including:    
	- `Resource` to monitor
	- `Condition` to match
		- Signal type  - Metric, Logs, Acticity log
		- Alert Logic
	- `Action` Group are invoked unpon alerting to fulfill responsive steps when an alert triggers
	- `Alert Detaails`
		- Severity
		- Name and description
- When monitoring multiple resources, the system evaluates your conditions separately for each resource, and alerts trigger for each resource separately.
- Alert states
	- New - not in review
	- Acknowledged - in review
	- Closed - issue is complete, can be reopened 
- An Alert History retains information about state changes
- Stateful Alerts - Activity logs are always stateless!
	- Trigger when alert rule condition matches data and a duplicate alert does not exist.
	- Does not trigger more action until current alert conditions are clear
- Stateless Alerts
	- Triggers when alert rule condition matches your data and a duplicate alert does not exist
- Alert Rules:
	- Target resource 
		- scope and signal available for Alert Operation
	- Alert Signal
		- Emitted signal can be 
		- Metric 
		- Activity log 
		- Application Insights 
		- Log 
	- Rule Criteria
	- Issue Severity - ranges from 0 to 4
	- Name and Description
- Action Group - collection of notification preferences that you define as an Azure subscription owner
	- Action Type:
		- **Automation runbook**: An automation runbook is the ability to define, build, orchestrate, manage, and report on workflows that support welcome-pack system and network operational processes. A runbook workflow can potentially interact with all types of infrastructure elements, such as applications, databases, and hardware.
		- **Azure Functions**: Azure Functions is a serverless compute service that lets you run event-triggered code without having to explicitly provision or manage infrastructure.
		- **ITSM**: The action can connect Azure and a supported IT Service Management (ITSM) product or service. This action requires an ITSM connection.
		- **Logic Apps**: Azure Logic Apps connects your business-critical apps and services by automating your workflows.
		- **Webhook**: A webhook is an HTTPS or HTTP endpoint that allows external applications to communicate with your system.

- Metric Alerts
	- Static threshold metric alerts - `IF $resource == $NUM { DO X }`
	- Dynamic threshold metric alerts (Azure ML!) - just define these parameters
		- Look-back period - defines how many previous periods need to be evaluated
		- Number of Violations
	- Scaling is limited to VMs

- Log Alerts
	- Log query
	- Time period
	- Frequency
	- Threshold
	-  `number-of-records` type of log search returns a single alert when the number of records in a search result reaches or exceeds the value
	
	- `metric-measurement` logs require addiitional criteria to be set
		- Aggregate function 
			- calculation made against result data, result of this function is called AggregatedValue 
		- Group field
			- Field by which the result will be grouped
		- Interval
			- Time interval  by which the data is aggregated
		- Threshold
			- A point defined by an aggregated value and the total number of breaches.

- Activity Log Alerts
	- Specific operations
	- Service health events
		- Include notice of incidents and maintenance of target resources.
	- Composition
		- **Category**: Administrative, service health, autoscale, policy, or recommendation
		- **Scope**: Resource level, resource group level, or subscription level
		- **Resource group**: Where the alert rule is saved
		- **Resource type**: Namespace for the target	- Dependency Agent 
		- Collects discovered data about certain processes to maps all dependencies between virtual machines and any external process dependencies.
	- Azure VMAccess extension
		- acts as a KVM switch that allows you to access the console to reset access to Linux or perform disk-level maintenance. of the alert
		- **Operation name**: Operation name
		- **Level**: Verbose, informational, warning, error, or critical
		- **Status**: Started, failed, or succeeded
		- **Event initiated by**: Email address or Azure Active Directory identifier (known as the "caller") for the user

## Dashboards 

Azure Dashboards are virtual workspaces - day-to-day operations and monitor resources
Azure Workbooks - visual reporting
Application Insights is a Application Performance Management (APM) service it is a sub-service of Azure Monitor
- Automatic performance anomaly reporting
- Analytics and diagnostic tooling
- Works for apps for .NET, Node.js, Java and Python hosted on-premises, hybrid or any public cloud
- Integrates with DevOps process
- Can monitor and analyse telemetry from mobile apps by integrating with Visual Studio App Center

## Azure Monitor Logs

Azure Monitor Logs collects and organises log data generated from Azure resources that is then stored in a Log Analytics workspace. See [[Azure-Administration-Log-Analytics]]. Azure Monitor Logs can store Azure Monitor Metrics data and various other data types, each using their own structure.

## Azure Monitor VM Insights 

Azure Monitor VM Insights  is a feature of Azure Monitor  provides access to log data without exposing the user to underlying queries. Azure Monitor VM Insights relies on Azure Monitor Logs. It is a predefined, curated monitoring experience. Azure Monitor VM Insights use a table named `InsightsMetric`.

To use Application insights you need to instrument your application
- To instrument you need to install the instrument package (SDK)
- Or enable Application Insights using the Application Insights Agents when supported
- Apps can be instrumented from anywhere
- When you set up Application Insights monitoring for your web app, you create an Application Insights resource in Microsoft Azure
- You open this resource in the Azure portal in order to see and analyse the telemetry collected your app.
The resource is identified by an instrumentation key (ikey)

Azure Insights VM prevent user from accessing data they should not have access to

## Workflows

Access Azure Monitor
`Search -> Monitor`

[Diagnostic Extension]([Azure Diagnostics extension overview - Azure Monitor | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/diagnostics-extension-overview)) -  or Boot Diagnostics, Storage Explorer, Metrics - Autoscaling and Alerts, Data for [Azure Event Hubs](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/diagnostics-extension-stream-event-hubs)
- **Only Azure Resources and Azure Monitor Logs**
Configure VM for Log Analytics - Install and Configure Azure Diagnostics for Windows (WAD)
`Search -> Virtual Machines -> $VM -> (Metrics - for default Monitoring) Diagnostic settings -> Select a Diagnostics storage account & Enable guest-level monitoring` then configure: 
- Performance Counters
- Logs
- Crash dumps Sinks 
- Agent
Then `$VM -> Logs -> Enable -> chooose a Log Analytucs Workspace -> Enable `


[IT Service Management Connector](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/itsmc-definition#install-it-service-management-connector) - Integrate Azure Monitor with (non)Azure (only ITSM supported products) to resolve issues; can installed on LA Workspaces
`Markplace -> ITSMC`; to connect `Resources -> $resource (include LA Workspaces) -> ITSM Connections`

Register the Microsoft.Insights and Microsoft.AlertsManagement resource providers 
```powershell
Register-AzResourceProvider -ProviderNamespace Microsoft.Insights
Register-AzResourceProvider -ProviderNamespace Microsoft.AlertsManagement
```

Metrics 
`Search -> Monitor -> Metrics -> Select a Scope (Tree View)`

Create an (metric) Alert 
`Search -> Monitor -> Alerts -> Create 
`Search -> Monitor -> Metrics -> New Alert Rule
- Select scope, filter times..., then configure

Create a metric alert; examlpe VM CPU is greater than 80% 
```bash
az monitor metrics alert create \
    -n "Cpu80PercentAlert" \
    --resource-group $rGroup \
    --scopes $VMID \
    --condition "max percentage CPU > 80" \
    --description "Virtual machine is running at or greater than 80% CPU utilization" \
    --evaluation-frequency 1m \
    --window-size 1m \
    --severity 3
```


Log Analytics Querying - Has drop down listing of useful input!
`Search -> Monitor -> Logs -> Select a scope -> (Tables | Queries | Functions | Filters)  -> Run Query`
- You can click to collapse the left panel

Create and Configure Log Analytics workspaces - [[Azure-Administration-Log-Analytics]]
`Search Log Analytics workspaces -> Log Analytics workspaces -> Create`
`Search Automation Accounts -> Create -> $LAWrGroup` - check [supported mappings](https://learn.microsoft.com/en-us/azure/automation/how-to/region-mappings) then `$AutomationAccount -> Inventory -> Select Log Analytics workspace -> $LAW & Enable` then `Update Management -> Enable`

KGL Log queries 
- Schema 
- Filter
- Explorer

Log Analytic log queries can be found:
- Alert Rules
- Dashboards
- Export
- Powershell
- Azure Monitor Logs API

```sql
// Syntax
// Count by Rows:
$Table | count 

// Count by Column:
$Table 
| count

// Control Commands 
.create table Logs (Level:string, Text:string)


// Queries - I will use row queries for space, unless it is required
$table | count
$table | top 3 by event severity duration
$table | where StartTime between (datetime(2007-11-01) .. datetime(2007-12-01))
$table | where $Column == "Something" 

// Top most security events by time generated
SecurityEvents 
	| take 10 by TimeGenerated

// In the last 24 hours records of "Clicked Schedule Button"
AppEvents 
    | where TimeGenerated > ago(24h)
    | where Name == "Clicked Schedule Button"

# Heartbeat data source reports the health of all computers that report to LA Workspace
Heartbeat | summarize arg_max(TimeGenerated, *) by ComputerIP

// Aggregate content by specifications using using summarize 
$table | summarize count(), avg(severity) by $column, $column

// Create a Column Chart from $event 
$table | where isnotempty($event) | summarize event_count=count() by $event | top 10 by event_count | render columnchart

// Chat CPU usage trends by computer
InsightsMetrics
| where TimeGenerated > ago(1h)
| where Origin == "vm.azm.ms"
| where Namespace == "Processor"
| where Name == "UtilizationPercentage"
summarize avg(Val) by bin(TimeGenerated, 5m), Computer
render timechart
```

Onboard virtual machines to Azure Monitor VM Insights
`Monitor -> Monitoring -> Insights -> Select Enable & Refresh`; available Graphs:
- Logical Disk Performance
- CPU Utilisation
- Available Memory
- Logical Disk IOPS
- Logical Disk MB/s
- Logical Disk Latency (ms)
- Max Logical Disk Used %
- Bytes Sent Rate
- Bytes Received Rate

## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg)
[KQL](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/query/) 
[Azure Monitor Metrics](https://learn.microsoft.com/en-us/azure/azure-monitor/essentials/data-platform-metrics)
[Azure Monitor Logs](https://learn.microsoft.com/en-us/azure/azure-monitor/logs/data-platform-logs)
[Azure Monitor Insights](https://learn.microsoft.com/en-us/azure/azure-monitor/insights/insights-overview)
[Supported regions for linked Log Analytics workspace | Microsoft Learn](https://learn.microsoft.com/en-us/azure/automation/how-to/region-mappings)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
[Azure Diagnostics extension overview - Azure Monitor | Microsoft Learn](https://learn.microsoft.com/en-us/azure/azure-monitor/agents/diagnostics-extension-overview)
[John Savill](https://www.youtube.com/@NTFAQGuy) 
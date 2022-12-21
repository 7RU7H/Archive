
# Azure Adminstration - Azure Monitor

Azure Monitor is the comprehensive solution for collecting, analyzing and acting on telemetry from cloud and on-premise linked environments. **Azure Monitor collects Logs and Metrics**
- Create Visual Dashboards
- Alerts
- Automated Actions
- Log Monitoring
To obtain observability you need to use Metrics, Logs and Traces.
- You have to use them together, using them in isolate does not gain you observability
	- Metrics
	- Azure Monitor Logs:
		- Data logs are consolidated from differenct sources into workspaces
			- Platform logs from Azure services
			- Log and performance data from applcations can be consolidated
			- Usage and performance data from applications can be consolidated
			- In workspace so they can be analyzed together using a sophisticated query language capable of analyzing millions of records
	- Work with log queries and their resuls interactively using Log Analytics
- Azure Monitor Metrics collects numeric data from monitored resources into a time series database. Analyze with **Metrics Explorer** 
	- Metrics are numerical values collected at regular intervals and describe some aspect of system at a particular time
	- Lightweight and capable of supporting near real-time
- Traces: A history request which travels through multiple Apps/services for troubleshooting failure

Log Analytics an Azure Portal Tool to **edit and run log queries** with data in Azure Monitor Logs -  Log Analytics use [KQL](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/query/) - Kusto Query Language

Log Analytics workspace is a unique environment for Azure monitor Log Data; each has its own data repository and configuration, data sources and solutions are configured to store their dat in a workspace

Azure Monitor Logs is based on Azure Data Explorer, and log queries are written  using the same KQL
- KQL used in:
	- Log Analytics
	- Log Alert Rules
	- Workbooks
	- Azure Dashboards
	- Logic Apps
	- PowerShell
	- Azure Monitor Logs API
[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
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
- **Metric Explorer** is a sub-service of Azure Monitor that allows you to plot charts, visualize correlating trends, and investigate spikes and dips in metrics value. To visualize a metric you need to define:
	- Scope: You can select \*resource(s)
	- Namespace: A specific group of metric data within a resource
	- Metric: Value to visualize
	- Aggregation: groups of values

Alert notification for issues are found on infrastructure or application
- Identify and address issues before the users of your system notice them.
- Azure has 3 kinds of Alerts
	1. Metric Alerts
	2. Log Alerts
	3. Activity Log Alerts
Azure Dashboards are virtual wrokspaces - day-to-day operations and monitor resources
Azure Workbooks - visual reporting
Application Insights is a Application Permformance Management (APM) service it is a sub-service of Azure Monitor
- Automatic performa anomaly reporting
- Analytics and diagnostic tooling
- Works for apps for .NET, Node.js, Java and Python hosted on-premises, hybrid or any public cloud
- Integrates with DevOps process
- Can monitor and analyze telemetry from mobile apps by integrating with Visual Studio App Center
To use Application insights you need to instrument your application
- To instrument you need to install the instrument package (SDK)
- Or enable Application Insights using the Application Insights Agents when supported
- Apps can be instrumented from anywhere
- When you set up Application Insights monitoring for your web app, you create an Application Insights resource in Microsoft Azure
- You open this resource in the Azure portal in order to see and analyze the telemety collected your app.
The resource is identified by an instrumentation key (ikey)


## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
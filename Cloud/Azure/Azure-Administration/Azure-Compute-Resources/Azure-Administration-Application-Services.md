
# Azure Administration - Application Services

Azure App Service is an HTTP-based service for hosting web applications, REST APIs, and mobile back ends. An App Service plan defines a set of compute resources for a web application to run; the compute resources are analogous to a server farm in conventional web hosting:
- Choose your own programming language for Windows or Linux
	- Azure App Services you supports the following runtimes: .NET, .NET Core, Java Ruby, node.js, PHP, Python
- Platform as a Service
	- Region
	- Number of VMs
	- Size of VMs
- Azure App services can also run docker single or multi-containers
- Builtin auto scale support
	- Increase or decrease the resources allocated to run your app as needed, depending on the demand.
- Deployment Slots
- Continuous integration/deployment support

Azure App service makes it easy to implement common:
- Azure DevOps 
- Github integration
- Docker hub integration
- Package Management
- Easy to setup staging environments
- Custom Domains
- Attaching TLS/SSL certificates

Limitations:
- Not supported on Shared pricing tier 
- Builtin Images have an allocated storage, disk latency of this volume is higher and more variable than the latency of the container filesystem
	- May require custom container option
- Azure portal shows only features that currently work for Linux apps 

The Azure app service Benefits
![1080](azureappservicesbenefits.png)

An App Server will always run within an App Service plan that defines a set of compute resources for a web app to run. Defined by:
- Operating System (Windows, Linux)
- Region (West US, East US, etc.)
- Number of VM instances
- Size of VM instances (Small, Medium, Large)
- Pricing tier (Free, Shared, Basic, Standard, Premium, PremiumV2, PremiumV3, Isolated, IsolatedV2) - list below by incremental cost:
- Shared Compute Tier -  same Azure VM as other App Service apps, including apps of other customers:
	- Free 
	- Shared (Linux not supported)
- Dedicated Compute Tier - Only app in the same App Service plan run dedicated Azure VMs:
	- Basic 
	- Standard 
	- Premium - legacy:  PremiumV2, PremiumV3
- Isolated Tier - dedicated Azure VMs on dedicated Azure Virtual Networks for highest performance, security, isolation:
	- Isolated
	- Isolated V2 

![1080](azureappservicespricetier.png)


**Custom Containers** are supported, create docker file, upload to Azure Container Registry and deploy
	
**Deployment Slots** allows you create different environemtns of your web-application, can also swap environments - potential [Blue/Green deploy](https://en.wikipedia.org/wiki/Blue-green_deployment) 
- Connections strings follow the content across the swap, Scale and Domains do not.
	
App Service Environment (ASE) is an Azure App Service feature that provides a fully isolated and dedicated environment for securely running App Service apps at high scale
- Customers can create multiple ASEs:
	- Within a single Azure Region
	- Across Multiple Azure Region making ASEs
- Idea for horizontally scaling stateless application tiers in support of high requests per second (RPS) workloads
- ASE comes with its own pricing tier (Isolated Tier)
- ASEs can be used to configure security architecture
- Apps running on ASEs can have their access gated by upstream devices, such as web applcation firewalls (WAFs)
- App Services Environments can be deployed  into AZ using zone pinning
- Deployments types ASE:
	- External ASE
	- [Internal Load Balancing ILB ASE](https://azure.microsoft.com/en-gb/blog/internal-load-balancing/)

Azure App services provides many ways to deploy your applications:
- WebJobs is feature of Azure App Service that enables you to run a program or script in the same instance as  a web app, API app, or mobile app.
	- No additional cost for WebJobs!

## Deployment

#### Automated Deployment 

Azure supports automated deployment directly from several sources. The following options are available:

-  **Azure DevOps**: You can push your code to Azure DevOps (previously known as Visual Studio Team Services), build your code in the cloud, run the tests, generate a release from the code, and finally, push your code to an Azure Web App.
-  **GitHub**: Azure supports automated deployment directly from GitHub. When you connect your GitHub repository to Azure for automated deployment, any changes you push to your production branch on GitHub will be automatically deployed for you.
-  **Bitbucket**: With its similarities to GitHub, you can configure an automated deployment with Bitbucket.
-  **OneDrive**: OneDrive is Microsoft's cloud-based storage. You must have a Microsoft Account linked to a OneDrive account to deploy to Azure.
-  **Dropbox**: Azure supports deployment from Dropbox, which is a popular cloud-based storage system that is similar to OneDrive.

####  Manual Deployment

There are a few options that you can use to manually push your code to Azure:

-   **Git**: App Service web apps feature a Git URL that you can add as a remote repository. Pushing to the remote repository will deploy your app.
-   _**az webapp up**_: `webapp up` is a feature of the `az` command-line interface that packages your app and deploys it. Unlike other deployment methods, `az webapp up` can create a new App Service web app for you if you haven't already created one.
-   **ZIP deploy**: You can use `az webapp deployment source config-zip` to send a ZIP of your application files to App Service. You can also access ZIP deploy via basic HTTP utilities such as `curl`.
-   **WAR deploy**: WAR deploy is an App Service deployment mechanism designed for deploying Java web applications using WAR packages. You can access WAR deploy using the Kudu HTTP API located at `http://<your-app-name>.scm.azurewebsites.net/api/wardeploy`. If that fails, try: `https://<your-app-name>.scm.azurewebsites.net/api/wardeploy`.
-   **Visual Studio**: Visual Studio features an App Service deployment wizard that can walk you through the deployment process.
-   **FTP/S**: FTP or FTPS is a traditional way of pushing your code to many hosting environments, including App Service.****

#### Authentication and Authorisation in App Service Plans

Use Identity Providers:

|Provider|Sign-in endpoint|How-To guidance|
|---|---|---|
|Microsoft Identity Platform|`/.auth/login/aad`|[App Service Microsoft Identity Platform login](https://learn.microsoft.com/en-us/azure/app-service/configure-authentication-provider-aad)|
|Facebook|`/.auth/login/facebook`|[App Service Facebook login](https://learn.microsoft.com/en-us/azure/app-service/configure-authentication-provider-facebook)|
|Google|`/.auth/login/google`|[App Service Google login](https://learn.microsoft.com/en-us/azure/app-service/configure-authentication-provider-google)|
|Twitter|`/.auth/login/twitter`|[App Service Twitter login](https://learn.microsoft.com/en-us/azure/app-service/configure-authentication-provider-twitter)|
|Any OpenID Connect provider|`/.auth/login/<providerName>`|[App Service OpenID Connect login](https://learn.microsoft.com/en-us/azure/app-service/configure-authentication-provider-openid-connect)|
|GitHub|`/.auth/login/github`|[App Service GitHub login](https://learn.microsoft.com/en-us/azure/app-service/configure-authentication-provider-github)|

The authentication and authorisation module runs in the same sandbox as your application code, it handles every incoming HTTP request:
- Authenticates users and clients with the specified identity provider(s)
- Validates, stores, and refreshes OAuth tokens issued by the configured identity provider(s)
- Manages the authenticated session
- Injects identity information into HTTP request headers

Either Authentication Flow with or without Provider SDK:

|Step|Without provider SDK|With provider SDK|
|---|---|---|
|Sign user in|Redirects client to `/.auth/login/<provider>`.|Client code signs user in directly with provider's SDK and receives an authentication token. For information, see the provider's documentation.|
|Post-authentication|Provider redirects client to `/.auth/login/<provider>/callback`.|Client code posts token from provider to `/.auth/login/<provider>` for validation.|
|Establish authenticated session|App Service adds authenticated cookie to response.|App Service returns its own authentication token to client code.|
|Serve authenticated content|Client includes authentication cookie in subsequent requests (automatically handled by browser).|Client code presents authentication token in `X-ZUMO-AUTH` header (automatically handled by Mobile Apps client SDKs).|

### Token store

App Service provides a built-in token store, which is a repository of tokens that are associated with the users of your web apps, APIs, or native mobile apps. When you enable authentication with any provider, this token store is immediately available to your app.

### Logging and tracing

If you enable application logging, authentication and authorization traces are collected directly in your log files. If you see an authentication error that you didn't expect, you can conveniently find all the details by looking in your existing application logs.

#### DevOps and Continuous deployment

Deployment slots are configured in the Azure portal. You can swap your app content and configuration elements between deployment slots, including the production slot.
![1080](azureappservicesslotsvsswapped.png)

## Insights

App Services are integratable with Azure Insights to automatically detect performance anomalies in your apps. Language agnostic, on-off cloud location agnostics, DevOps integration and monitor and analyze data from mobile apps. Consider reviewing [[Azure-Administration-Azure-Monitor]].

![1080](azureappserviesinsightpluses.png)

#### App Services Networking

Control the inbound and outbound network traffic for either multi-tenant or single-tenant. Networking features:

|Inbound features|Outbound features|
|---|---|
|App-assigned address|Hybrid Connections|
|Access restrictions|Gateway-required virtual network integration|
|Service endpoints|Virtual network integration|
|Private endpoints| ...

Your Application is your Application you control your Application's features and problems

## Workflows

Azure Portal for development slots for management - although you can create APp services with CLI or scripting
Azure App Services  -  Create a Web app
`All resources -> Create a Resource -> Create a web app` 
or 
`Search -> App Services + Create`
Basics 
- Resource Group
- Publish: Code, Docker Container or Static Web App
- Runtime stack
Deployment 
- Automated 
	- Azure DevSec Ops Service
	- Github
		- Github actions - continuous deployment!
	- Bitbucket similar to Github 
- Manual
	- Git
	- CLI
	- [[Microsoft-Visual-Studios]]
	- Zip Deployment
	- FTP/S - please use encrypted FTP or you will be in a lot of trouble.
- Use Deployment slot
	- Swapping between staging and production environments 
	- Development slots are live apps with their own hostnames - ``
Networking - Public access and network injection toggles
Monitoring - Insights
Tags - TAGS TAGS TAGS!
`App services` authorisation behaviours:
- Allow unauthenticated requests
- Require authentication
- Extras
	- Always On: keep application loaded even when there is no traffic
	- ARR Affinity - in multi-instance deployment ensure app client is routed to same instance for life of the session
	- Connection strings: encrypted at rest and transmitted over encryption

Create a staging deployment slot and configure deployment 
`App Services -> $App -> Deployment Slots -> + Add Slot`
Then
`$App -> Deplyment Centre -> Select a Source -> Save`

Scale up/out Azure App Services
`Search -> App Services -> Manual scale / Custom Autoscale`
- For Custom Autoscale:
	- Minimum instance count
	- Maximum instance count
	- Adequate scale margin
	- Scale rule combinations
	- Metric statistics
	- Default instance count
	- Notifications

Deploy Code to a Azure App Service configure to deploy git source code.
```powershell
Set-Location-Path $pathToSourceCode
git remote add $Repository $AzureAppServiceDeployURL.git 
git push $Repository $Branch
# Authenticate
```

Deployment Slots 
`Search -> App Services -> $App -> Deployment Slots -> + Add slot  

Deployment Swaps - swap between slots
`Search -> App Services -> $App -> Deployment Slots -> Swap`
- Select Source and Target
[Swap operations](https://learn.microsoft.com/en-us/azure/app-service/deploy-staging-slots):
1. Target requires, then wait: 
	- Slot-specific app settings and connection strings
	- Continuous deployment
	- App Services authentication 
2. If local cache is enabled 
	- trigger local cache initialisation - HTTP request to root `/` on each app 
3. If Auto swap is enabled with custom warm-up trigger `applicationInitialization` (if not specified)
4. All warmed up? - Swap slots by switching the routing rules for the two slots
5. Source slot has pre-swap app previously in the target slot, perform the same operation by applying all settings and restarting the instances. No need to to re-route, it is stored
- BEWARE - Slot != App; Slot is more like a host:
![](azslotswappedsettingsvsslotspecificsettings.png)


Create a Custom Domain for Azure App Service
`Search -> App Services -> Custom Domains`
- `Search -> Domain Names` and reserve directly in the Azure portal
- Create DNS records - either `A` or `CNAME`
- Enable

Backup Azure App Service (App configuration settings, File content, connected Databases) - requires:
- Standard or Premium tier App Service plan 
- Storage Container - [[Azure-Administration-Storage-Accounts]]
Provide the in `App Services -> $App -> Backup `

Deploy Code to a Azure App Service configure to deploy git source code.
```powershell
Set-Location-Path $pathToSourceCode
git remote add $Repository $AzureAppServiceDeployURL.git 
git push $Repository $Branch
# Authenticate
```

Send HTTP requests with `Get-AzWebApp`
```powershell
$webapp = Get-AzWebApp -ResourceGroupName $rgName
Invoke-WebRequest -Uri $webapp.DefaultHostName
# Send infinite request to test with while loop and powershell code blocks
while ($true) { Invoke-WebRequest -Uri $webapp.DefaultHostName }
```

Bootstrap web applications
```bash
# C#
# Install dotnet
wget -q -O - https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.sh | bash -s -- --version 6.0.404
export PATH="~/.dotnet:$PATH"
echo "export PATH=~/.dotnet:\$PATH" >> ~/.bashrc
# create a ASP.NET Core MVC application
dotnet new mvc --name $webappName
cd $webappName/
dotnet run

# Java - with maven-archetype-webapp template
cd ~
mvn archetype:generate -DgroupId=example.demo -DartifactId=$webappName -DinteractiveMode=false -DarchetypeArtifactId=maven-archetype-webapp -DarchetypeVersion=1.4
cd $webappName
mvn package
# the result will be .war file to be deploy

# Node.js
mkdir $path/$WebApp
cd $WebApp
npm init -y
# start Web App
npm start
# Python - with flask
python3 -m venv venv 
source venv/bin/activate
pip install flask
mkdir $path/$WebApp
cd $WebApp
# Add applications to requirements.txt
pip freeze > requirements.txt
# Test
export FLASK_APP=application.py
flask run
# Adding code to source control with git
git init
git add .
git commit -m "Initial commit"
```

Deploying a WebApp
```bash
# C# 
cd $webappName
# Publish to build and zip to package
dontnet publish -o pub
cd pub
zip -r site.zip *
# Deply with the az cli
az webapp deployment source config-zip \
    --src site.zip \
    --resource-group $rgName \
    --name $appName

# Java
# CLI credentials required
az webapp deployment user set --user-name <username> --password <password>
# WAR deploy
cd $webappName/target
curl -v -X POST -u <username>:<password> https://<your-app-name>.scm.azurewebsites.net/api/wardeploy --data-binary @$webappName.war

# Node.js
export APPNAME=$(az webapp list --query [0].name --output tsv)
export APPRG=$(az webapp list --query [0].resourceGroup --output tsv)
export APPPLAN=$(az appservice plan list --query [0].name --output tsv)
export APPSKU=$(az appservice plan list --query [0].sku.name --output tsv)
export APPLOCATION=$(az appservice plan list --query [0].location --output tsv)

az webapp up --name $APPNAME --resource-group $APPRG --plan $APPPLAN --sku $APPSKU --location "$APPLOCATION"

# Python 
export APPNAME=$(az webapp list --query [0].name --output tsv)
export APPRG=$(az webapp list --query [0].resourceGroup --output tsv)
export APPPLAN=$(az appservice plan list --query [0].name --output tsv)
export APPSKU=$(az appservice plan list --query [0].sku.name --output tsv)
export APPLOCATION=$(az appservice plan list --query [0].location --output tsv)

cd path/$webappName
az webapp up --name $APPNAME --resource-group $APPRG --plan $APPPLAN --sku $APPSKU --location "$APPLOCATION"
```

Find outbound IPs of App Service Plan
```bash
# Same information as Azure Portal on Outbound IPs
az webapp show \
    --resource-group <group_name> \
    --name <app_name> \ 
    --query outboundIpAddresses \
    --output tsv
# All possible outbound IPs
az webapp show \
    --resource-group <group_name> \ 
    --name <app_name> \ 
    --query possibleOutboundIpAddresses \
    --output tsv
```


## References

[Internal Load Balancing](https://azure.microsoft.com/en-gb/blog/internal-load-balancing/)
[Blue/Green deploy](https://en.wikipedia.org/wiki/Blue-green_deployment)
[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)

# Azure Administration - Application Services

Azure App Service is an HTTP-based service for hosting web applications, REST APIs, and mobile back ends. An App Service plan defines a set of compute resources for a web application to run; the compute resources are analogous to a server farm in conventional web hosting:
- Choose your own programming lanaguage for Windows or Linux
- Platform as a Service
	- Region
	- Number of VMs
	- Size of VMs
- Azure App Services you supports the following runtimes: .NET, .NET Core, Java Ruby, node.js, PHP, Python
- Azure App services can also run docker single or multi-containers

Azure App services has built-in auto scaling support that can increase or decrease the resources allocated to run your app as needed, depending on the demand.

Azure App service makes it easy to implement common:
- Azure DevOps 
- Github integration
- Docker hub integration
- Package Management
- Easy to setup staging environments
- Custom Domains
- Attaching TLS/SSL certificates

The Azure app service Benefits
![1080](azureappservicesbenefits.png)


You pay based on an Azure App Servies Plan - list below by incremental cost:
- Shared Tier 
	- Free 
	- Shared (Linux not supported)
- Dedicated Teir 
	- Basic 
	- Standard 
	- Premium - legacy:  PremiumV2, PremiumV3
	- Isolated Tier - High performance, security, isolation

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

-   **Azure DevOps**: You can push your code to Azure DevOps (previously known as Visual Studio Team Services), build your code in the cloud, run the tests, generate a release from the code, and finally, push your code to an Azure Web App.
-   **GitHub**: Azure supports automated deployment directly from GitHub. When you connect your GitHub repository to Azure for automated deployment, any changes you push to your production branch on GitHub will be automatically deployed for you.
-   **Bitbucket**: With its similarities to GitHub, you can configure an automated deployment with Bitbucket.
-   **OneDrive**: OneDrive is Microsoft's cloud-based storage. You must have a Microsoft Account linked to a OneDrive account to deploy to Azure.
-   **Dropbox**: Azure supports deployment from Dropbox, which is a popular cloud-based storage system that is similar to OneDrive.

####  Manaual Deployment

There are a few options that you can use to manually push your code to Azure:

-   **Git**: App Service web apps feature a Git URL that you can add as a remote repository. Pushing to the remote repository will deploy your app.
-   _**az webapp up**_: `webapp up` is a feature of the `az` command-line interface that packages your app and deploys it. Unlike other deployment methods, `az webapp up` can create a new App Service web app for you if you haven't already created one.
-   **ZIP deploy**: You can use `az webapp deployment source config-zip` to send a ZIP of your application files to App Service. You can also access ZIP deploy via basic HTTP utilities such as `curl`.
-   **WAR deploy**: WAR deploy is an App Service deployment mechanism designed for deploying Java web applications using WAR packages. You can access WAR deploy using the Kudu HTTP API located at `http://<your-app-name>.scm.azurewebsites.net/api/wardeploy`. If that fails, try: `https://<your-app-name>.scm.azurewebsites.net/api/wardeploy`.
-   **Visual Studio**: Visual Studio features an App Service deployment wizard that can walk you through the deployment process.
-   **FTP/S**: FTP or FTPS is a traditional way of pushing your code to many hosting environments, including App Service.****

#### DevOps and Continous deployment

Deployment slots are configured in the Azure portal. You can swap your app content and configuration elements between deployment slots, including the production slot.
![1080](azureappservicesslotsvsswapped.png)

## Insights

App Services are integratable with Azure Insights to automatically detect performance anomalies in your apps. Language agnostic, on-off cloud location agnostics, DevOps integration and monitor and analyze data from mobile apps. Consider reviewing [[Azure-Administration-Azure-Monitor]]

![1080](azureappserviesinsightpluses.png)

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
- Github actions - continuous deployment!
- Devlopment slots are live apps with their own hostnames - ``
Networking - Public access and network injection toggles
Monitoring - Insights
Tags - TAGS TAGS TAGS!

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

Deployment Swaps
`Search -> App Services -> $App -> Deployment Slots -> Swap`
Select Source and Target

Create a Custom Domain for Azure App Service
`Search -> App Services -> Custom Domains`
- `Search -> Domain Names` and reserve directly in the Azure portal
- Create DNS records
- Enable

Backup Azure App Service (App configuration settings, File content, connected Databases)- requires:
- Standard or Premium tier App Service plan 
- Storage Container - [[Azure-Administration-Storage-Accounts]]
Provide the in `App Services -> $App -> Backup `

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


## References

[Internal Load Balancing](https://azure.microsoft.com/en-gb/blog/internal-load-balancing/)
[Blue/Green deploy](https://en.wikipedia.org/wiki/Blue-green_deployment)
[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
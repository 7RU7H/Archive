# Azure Administration - Container Apps

Azure Container Apps provides the flexibility you need with a serverless container service built for microservice applications and robust autoscaling capabilities without the overhead of managing complex infrastructure. Azure Container Apps enables you to run microservices and containerized applications on a serverless platform that runs on top of Azure Kubernetes Service. Common uses of Azure Container Apps include:
- Deploying API endpoints
- Hosting background processing applications
- Handling event-driven processing
- Running microservices

Microservice architectures allow:
- Independent scaling, versioning, and upgrades
- Service discovery
- Native [Dapr](https://docs.dapr.io/concepts/overview/) integration

Limitations:
- **Privileged containers**: Azure Container Apps can't run privileged containers. If your program attempts to run a process that requires root access, the application inside the container experiences a runtime error.
- **Operating system**: Linux-based (`linux/amd64`) container images are required.

For more detailed possibilities with Azure Container Apps:
- Run multiple container revisions and manage the container app's application lifecycle.
- Autoscale your apps based on any KEDA-supported scale trigger. Most applications can scale to zero. (Applications that scale on CPU or memory load can't scale to zero.)
- Enable HTTPS ingress without having to manage other Azure infrastructure.
- Split traffic across multiple versions of an application for Blue/Green deployments and A/B testing scenarios.
- Use internal ingress and service discovery for secure internal-only endpoints with built-in DNS-based service discovery.
- Build microservices with [Dapr](https://docs.dapr.io/concepts/overview/) and access its rich set of APIs.
- Run containers from any registry, public or private, including Docker Hub and Azure Container Registry (ACR).
- Use the Azure CLI extension, Azure portal or ARM templates to manage your applications.
- Provide an existing virtual network when creating an environment for your container apps.
- Securely manage secrets directly in your application.
- Monitor logs using Azure Log Analytics.

Applications built on Azure Container Apps can dynamically scale based on: HTTP traffic, event-driven processing, CPU or memory load, and any [KEDA-supported scaler](https://keda.sh/docs/scalers/).

- Templatable with ARM templates -  [[Azure-Administration-ARM-Templates]]
- Multiple containers with [sidecar pattern](https://learn.microsoft.com/en-us/azure/architecture/patterns/sidecar)

## Authentication and Authorisation
#### Identity Providers

|Provider|Sign-in endpoint|How-To guidance|
|---|---|---|
|Microsoft Identity Platform|`/.auth/login/aad`|[Microsoft Identity Platform](https://learn.microsoft.com/en-us/azure/container-apps/authentication-azure-active-directory)|
|Facebook|`/.auth/login/facebook`|[Facebook](https://learn.microsoft.com/en-us/azure/container-apps/authentication-facebook)|
|GitHub|`/.auth/login/github`|[GitHub](https://learn.microsoft.com/en-us/azure/container-apps/authentication-github)|
|Google|`/.auth/login/google`|[Google](https://learn.microsoft.com/en-us/azure/container-apps/authentication-google)|
|Twitter|`/.auth/login/twitter`|[Twitter](https://learn.microsoft.com/en-us/azure/container-apps/authentication-twitter)|
|Any OpenID Connect provider|`/.auth/login/<providerName>`|[OpenID Connect](https://learn.microsoft.com/en-us/azure/container-apps/authentication-openid)|

Authentication Flow differ based on SDK:
- **Without provider SDK** (server-directed flow or server flow): The application delegates federated sign-in to Container Apps. Delegation is typically the case with browser apps, which presents the provider's sign-in page to the user.
- **With provider SDK** (client-directed flow or client flow): The application signs users in to the provider manually and then submits the authentication token to Container Apps for validation. This approach is typical for browser-less apps that don't present the provider's sign-in page to the user. An example is a native mobile app that signs users in using the provider's SDK.

#### Container Secrets

Azure Container Apps allows your application to securely store sensitive configuration values. Once secrets are defined at the application level, secured values are available to container apps. Specifically, you can reference secured values inside scale rules. A revision is a immutable snapshot of a container app version.

- Secrets are scoped to an application, outside of any specific revision of an application.
- Adding, removing, or changing secrets doesn't generate new revisions.
- Each application revision can reference one or more secrets.
- Multiple revisions can reference the same secret(s).

An updated or deleted secret doesn't automatically affect existing revisions in your app. When a secret is updated or deleted, you can respond to changes in one of two ways:

1. Deploy a new revision.
2. Restart an existing revision.

## Dapr

Possibly at some point...
## Workflows

```bash
# Install Azure Container Apps Extension
az extension add --name containerapp --upgrade
# register namespace
az provider register --namespace Microsoft.App
# Add Monitor Logs Analytics workspace
az provider register --namespace Microsoft.OperationalInsights
# Create resource Group for container apps
az group create \
    --name $RG \
    --location $region
# Create an environment 
az containerapp env create \
    --name $EnvName \
    --resource-group $RG \
    --location $region
# Deploy app --ingress external exposes it to public requests
az containerapp create \
    --name $ContainerAppName \
    --resource-group $RG \
    --environment $EnvName \
    --image mcr.microsoft.com/azuredocs/containerapps-helloworld:latest \
    --target-port 80 \
    --ingress 'external' \ 
    --query properties.configuration.ingress.fqdn
# Update Container App
az containerapp update \
  --name $ApplicationName \
  --resource-group $ResourceGroupName \
  --image $ImageName
# List all Revisions
az containerapp revision list \
  --name $ApplicationName \
  --resource-group $ResourceGroupName \
  -o table
# Define a secret
# Add for application level declaration:
# --env-vars "QueueName=$name" "ConnectionString=secretref:queue-connection-string"
az containerapp create \
  --resource-group  $resourceGroup \
  --name $appName \
  --environment $EnvName \
  --image $imageName \
  --secrets "queue-connection-string=$CONNECTION_STRING"
```

## References

[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
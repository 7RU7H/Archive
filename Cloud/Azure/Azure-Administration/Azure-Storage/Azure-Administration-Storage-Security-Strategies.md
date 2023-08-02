# Azure-Administration Storage Security Strategies


- Encryption 
	- Secure data in transit - HTTPS, SMB 3+
	- Secure data at rest - decrypted on retrieval
- Shared access signatures
- Authorisation: All requests to secured resources must be authorised
- Authentication:
	-  Assign RBAC roles scoped to an Azure storage account to security principals, and use Azure AD to authorise resource management operations like key management.
	- Azure AD integration is supported for data operations on Azure Blob Storage and Azure Queue Storage.
- Shared Access Signature: SAS

Configure Azure Storage Encryption:
`Storage accounts -> $storage_accounts -> Encryption`

Customer Managed Keys for greater control:
- Create, disable, audit, rotate and define access controls. Choose:
	- Encryption Type
	- Encryption Key

Consideration regarding Storage Security
![1000](azurestorageauthorizationstrategies.png)

Microsoft's Recommendations:
- Always use HTTPS
- Reference stored access policies
- Set near-term expiry for unplanned SAS
- Require client renew SAS
- Set SAS start time to avoid clock skew -  set: -15 minutes ago 
- Define *minimum* and limit access permissions for resource
	- Consider costs of over provisioning
- Do not assume a SAS is always correct choice
- Monitor applications
#### Shared Access Signatures

Create a SAS
`Storage Accounts -> $storage_account -> search SAS`

A shared access signature (SAS) is URI that grants restricted temporary access to Azure Storage resources:
- **Signing method**: Choose the signing method: Account key or User delegation key.
	- Account-level SAS - access to one or more storage services 
	- Service-level SAS - access to single storage services with storage account key
	- User delegation SAS - A SAS that's secured with Azure AD credentials
		- Azure AD credentials for access to storage account
		- Limited to only Blobs and Containers
		- Best practice methods
- **Signing key**: Select the signing key from your list of keys.
- **Permissions**: Select the permissions granted by the SAS, such as read or write.
- **Start and Expiry date/time**: Specify the time interval for which the SAS is valid. Set the start time and the expiry time.
	- Ad hoc 
		- Start, expiry times plus permission are part of the URI
		- Any SAS type 
- **Optional SAS configuration settings**: 
	- **Allowed IP addresses**: (Optional) Identify an IP address or range of IP addresses from which Azure Storage accepts the SAS.
	- **Allowed protocols**: (Optional) Select the protocol over which Azure Storage accepts the SAS.


- Service SAS with stored access policy
	- Stored access policy is defined on a resource container
	- Stored access policy can be associated to multiple SAS to managed constraints


URI Format with parameters explained
```powershell
# Resource URI
https://myaccount.blob.core.windows.net/$containerName/file.txt/?restype=service&comp=properties&....SAS
&sv= # Storage services version
&ss= # Storage service
&sip= # IP range
&spr= # Protocol
&st= # Start Time
&se= # Expiration Time
&sr= # Storage Resource - b for blob, q for queue 
&sp= # permissions  r, wr
&sig= # SHA256 hash - the signature
```

Create SAS In  .NET

Create a blob container to connect to the storage account on Azure
```C#
BlobContainerClient container = new BlobContainerClient( "ConnectionString", "Container" );
```

Retrieve the blob you want to create a SAS token for and create a BlobClient
```C#
foreach (BlobItem blobItem in container.GetBlobs())
{
    BlobClient blob = container.GetBlobClient(blobItem.Name);
}
```

Create a BlobSasBuilder object for the blob you use to generate the SAS token
```C#
BlobSasBuilder sas = new BlobSasBuilder
{
    BlobContainerName = blob.BlobContainerName,
    BlobName = blob.Name,
    Resource = "b",
    ExpiresOn = DateTimeOffset.UtcNow.AddMinutes(1)
};

// Allow read access
sas.SetPermissions(BlobSasPermissions.Read);
```

Authenticate a call to the `ToSasQueryParameters` method of the `BlobSasBuilder` object
```C#
StorageSharedKeyCredential storageSharedKeyCredential = new StorageSharedKeyCredential( "AccountName", "AccountKey");

sasToken = sas.ToSasQueryParameters(storageSharedKeyCredential).ToString();
```

Create a SAS for a Blob
```C#
// Build a SAS token for the given blob
private string GetBlobSas(BlobClient blob)
{
    // Create a user SAS that only allows reading for a minute
    BlobSasBuilder sas = new BlobSasBuilder 
    {
        BlobContainerName = blob.BlobContainerName,
        BlobName = blob.Name,
        Resource = "b",
        ExpiresOn = DateTimeOffset.UtcNow.AddMinutes(1)
    };
    // Allow read access
    sas.SetPermissions(BlobSasPermissions.Read);

    // Use the shared key to access the blob
    var storageSharedKeyCredential = new StorageSharedKeyCredential(
        _iconfiguration.GetValue<string>("StorageAccount:AccountName"),
        _iconfiguration.GetValue<string>("StorageAccount:AccountKey")
    );

    return '?' + sas.ToSasQueryParameters(storageSharedKeyCredential).ToString();
}
```

## Azure Storage Encryption

Configure Storage encryption
`Search  "Storage Accounts" -> Encrytion -> Select Type` either:
- Microsoft-Managed Keys
- Customer-Managed Keys:
	- **Encryption type**: Choose how the encryption key is managed: by Microsoft or by yourself (customer).
	- **Encryption key**: Specify an encryption key by entering a URI, or select a key from an existing key vault.

## Microsoft's Recommendations for Managing Storage Account Risks

|Recommendation|Description|
|---|---|
|**Always use HTTPS for creation and distribution**|If a SAS is passed over HTTP and intercepted, an attacker can intercept and use the SAS. These _man-in-the-middle_ attacks can compromise sensitive data or allow for data corruption by the malicious user.|
|**Reference stored access policies where possible**|Stored access policies give you the option to revoke permissions without having to regenerate the Azure storage account keys. Set the storage account key expiration date far in the future.|
|**Set near-term expiry times for an unplanned SAS**|If a SAS is compromised, you can mitigate attacks by limiting the SAS validity to a short time. This practice is important if you can't reference a stored access policy. Near-term expiration times also limit the amount of data that can be written to a blob by limiting the time available to upload to it.|
|**Require clients automatically renew the SAS**|Require your clients to renew the SAS well before the expiration date. By renewing early, you allow time for retries if the service providing the SAS is unavailable.|
|**Plan carefully for the SAS start time**|If you set the start time for a SAS to now, then due to clock skew (differences in current time according to different machines), failures might be observed intermittently for the first few minutes. In general, set the start time to at least 15 minutes in the past. Or, don't set a specific start time, which causes the SAS to be valid immediately in all cases. The same conditions generally apply to the expiry time. You might observe up to 15 minutes of clock skew in either direction on any request. For clients that use a REST API version earlier than 2012-02-12, the maximum duration for a SAS that doesn't reference a stored access policy is 1 hour. Any policies that specify a longer term will fail.|
|**Define minimum access permissions for resources**|A security best practice is to provide a user with the minimum required privileges. If a user only needs read access to a single entity, then grant them read access to that single entity, and not read/write/delete access to all entities. This practice also helps lessen the damage if a SAS is compromised because the SAS has less power in the hands of an attacker.|
|**Understand account billing for usage, including a SAS**|If you provide write access to a blob, a user might choose to upload a 200-GB blob. If you've given them read access as well, they might choose to download the blob 10 times, which incurs 2 TB in egress costs for you. Again, provide limited permissions to help mitigate the potential actions of malicious users. Use a short-lived SAS to reduce this threat, but be mindful of clock skew on the end time.|
|**Validate data written by using a SAS**|When a client application writes data to your Azure storage account, keep in mind there can be problems with the data. If your application requires validated or authorized data, validate the data after it's written, but before it's used. This practice also protects against corrupt or malicious data being written to your account, either by a user who properly acquired the SAS, or by a user exploiting a leaked SAS.|
|**Don't assume a SAS is always the correct choice**|In some scenarios, the risks associated with a particular operation against your Azure storage account outweigh the benefits of using a SAS. For such operations, create a middle-tier service that writes to your storage account after performing business rule validation, authentication, and auditing. Also, sometimes it's easier to manage access in other ways. If you want to make all blobs in a container publicly readable, you can make the container Public, rather than providing a SAS to every client for access.|
|**Monitor your applications with Azure Storage Analytics**|You can use logging and metrics to observe any spike in authentication failures. You might see spikes from an outage in your SAS provider service or to the inadvertent removal of a stored access policy.|
## References

[FreeCodeCamp.org - AZ 104 Course](https://www.youtube.com/watch?v=10PbGbTUSAg&t=3458s)
[Microsoft Technical Documentation](https://learn.microsoft.com/en-us/docs/)
[Microsoft Learn](https://learn.microsoft.com/en-us/)
[Create a user delegation SAS - Azure Storage | Microsoft Learn](https://learn.microsoft.com/en-us/rest/api/storageservices/create-user-delegation-sas)
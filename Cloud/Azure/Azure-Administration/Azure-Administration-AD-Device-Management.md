# Azure Administration AD Device Management


Device Identity management is the management of physical devices such as phones, tablets, laptops and desktop computers, which are grant access to Cloud company resources. With configuration the possibility of managing employee's personal equipment - Bring Your Own Device (BYOD) - can be through Azure to keep assets safe.

1. Azure AD Registered - Windows 10, iOS, Android, MacOS
	- Personally owned or mobile devices
	- Signed in with personal Microsoft or local account
2. Azure AD Joined - Windows 10, Server 2019 or greater VMs running in Azure
	- Owned by organiztion
	- And signed in with an Azure AD account belonging to organization
	- They exist only in the cloud
3.  Hybrid Azure AD Joined - Windows 7 -10, Server 2008 or later
	- Owned by an organization
	- Signed in with an Active Directory Services Account belonging to that organization
	- They exist in the cloud and on-premises

#### Azure AD Registered Device

Definition - Registered to Azure AD without requiring organizational account to sign in to the device
Primary audience - BYOD
Device Ownship - User or Organization
Provision 
- Windows 10 - Settings
- iOS/Android - Company Portal or Microsoft Authenticator app
- MacOS - Company Portal
Device sign in options
- End-user local credentials, Password, Windows Hello, PIN
	- Windows 10 Hello is alternative way to log into devices with fingerprint, iris scan and facial recognition
- Biometrics or Pattern for other devices
Device Management
- Mobile Device Management
- Mobile Application Management
Key capabilities
- SSO to cloud resources
- Conditional Access when Enrolled into Intune
- Conditional Access vai App protection policy
- Enables Phone sign in with Microsoft Authenticator app

Intune = Microsoft Endpoint Manager = Microsoft Enterprise Mobility + Security 

Microsoft Enterprise Mobility + Security (EMS) is umbrella term for multiple Microsoft and Azure services:
- Azure AD
- Microsoft Endpoint Configuration Manager
- Microsoft Intune 
- Azure Information Protection
- Microsoft Cloud App Security 
- Microsft Advanced Threat Analytics
- Microsoft Defender for Identity 
- Microsoft Secure Score


Both MDM and MAM is managed Via Microsoft Intune, part of Microsoft Endpoint Manager (which both part of Microsoft Enterprise Mobility + Security (EMS)) - must have Azure AD Premium 2
- Mobile Device Management (MDM) - control the entire device, can wipe data from it, and also reset it to factory  settings

Mobile Application Management (MAM) - Publish, push configure, secure, monitor and update mobile apps for your users.

Microsoft Authenicated App is for secure sign-ins for all your online account using MFA, passwordless and password autofill - found on Appstores.'

#### Azure AD Joined Devices

Devices are owned by organization and are joined only to Azure AD requiring organization account to sign in to device; suitable for:
- Cloud-only and Hybrid organizations
- Application to all users in an organization

All Windows 10 devices, except Home, Server 2019 and beyond running in Azure - Server Core is not supported
- Self-Sevice Provisioning  - Windows OOBE or Settings, Bulk Enrollment, Windows Autopilot.
- Device Sign in options: Organizational accounts using - Password, Windows Hello for Businesss, FIDO2.0 security keys
- Device management 
	- Mobile Device Management (Intune)
	- Co-management with Intune and Microsot Endpoint Configuration Manager
- Key Capabilites
	- SSO to both cloud and on-premises resources
	- Conditional Access through MDM enrollment and MDM compliance evaluation
	- Self-service Password Reset and Windows Hello PIN reset on lock screen
	- Enterprise State Roaming across devices

#### FIDO2.0 Security Keys

Fast Identity Online (FIDO) Alliance - An open industry association whoase mission is to develop and promote authenication standards  that help reduce the world's over-reliance on passwords. Security Keys are a secondary physcial device used a second stop in authentication - supports FIDO/WebAuthn, UF2; are waterproff and crush resistant, USB-A and NFC dual connectors on a single key; work with most major outlets - Google, Facebook,etc. FIDO Alliance has published three sets of open specifications:
- FIDO Universal Second Factor (FIDO U2F)
- FIDO Universal Authenication Framework (FIDO UAF)
- Client to Authenicator Protocola (CTAP)
- CTAP is complementary to W3C's Web Authentication (WebAuthn) specification; together, they are known as FIDO2

#### Hybrid Azure AD Joined DEvices

Device joined to on-premises AD and Azure requiring organizational account to sign in to the device, primary use case is for hybrid organizations with exist on-premises AD infrastructure. 
- Operating Systems supported: Windows 7 - 10 and Server 2008 - 2022
- Provisioning:
	- Windows 10, Server 2016/2019
	- Domain join by IT and autojoin via Azure Connect or ADFS config
	- Domain join by Windows Autopilot and autojoin via Azure AD Connect or ADFS config
	- Windows 8.1, 7, Server 2012 (and R2),  Server 2008 R2 - Require MSI
- Device sign in options - Organizational accounts using:
	- Password 
	- Windows Hello for business for Windows 10
- Device Management 
	- Group Policy, Configuration Manager standalone or co-management with Microsoft Intune
- Key capabilities
	- SSO to both cloud and on-premises resources
	- Conditional Access through Domain Join or through Intune if co-managed
	- Self-service Password Reset and Windows Hello PIN reset on lock screen
	- Enterprise State Romaing across devices


#### Windows Autopilot

Windows Autopilot is a collection of technogies used to set up and pre-configure new devices. Initial deployment of new Windows devices:
- Autopilot use OEM-optimizaed Version of Windows 10
- This version is preinstalled on the device, so you don't have to maintain custom images and drivers for every device model
- Instead or re-imaging the device, your existing Windows 10 installation can be transformed into a "business-ready" state that can once deployed managed with:
	- Microsoft Intune
	- Windows Update for Business
	- Microsoft Endpoint Configuration Manager

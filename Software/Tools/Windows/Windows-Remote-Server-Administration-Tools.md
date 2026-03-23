# Remote Server Administration Tools (RSAT)

[Documentation](https://docs.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2022-ps)

## Installation
-   Press **Start**
-   Search **"Apps & Features"** and press enter
-   Click **Manage Optional Features**
-   Click **Add a feature**
-   Search for **"RSAT"**
-   Select "**RSAT: Active Directory Domain Services and Lightweight Directory Tools"** and click **Install**

## Configuration for AD Enumeration
Search -> Run -> MMC
First we must configure MMC by attaching in the AD RSAT Snap-In and assign values to target domain:

1.  Click **File** -> **Add/Remove Snap-in**
2.  Select and **Add** all three Active Directory Snap-ins
3.  Click through any errors and warnings  
4.  Right-click on **Active Directory Domains and Trusts** and select **Change Forest**
5.  Enter target `Domain` as the **Root domain** and Click **OK**
6.  Right-click on **Active Directory Sites and Services** and select **Change Forest**
7.  Enter arget `Domain` as the **Root domain** and Click OK
8.  Right-click on **Active Directory Users and Computers** and select **Change Domain**
9.  Enter arget `Domain` as the **Domain** and Click **OK**
10.  Right-click on **Active Directory Users and Computers** in the left-hand pane  
11.  Click on **View** -> **Advanced Features**

## References
[Documentation](https://docs.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2022-ps)
[THM AD enumeration Room](https://tryhackme.com/room/adenumeration)
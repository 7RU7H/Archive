# Mobile Application Testing

This is a updated markdown mirror of [GitHub OlivierLaflamme/Cheatsheet-God/ - Cheatsheet_MobileAppTesting.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_MobileAppTesting.txt), which will probably end being split, but not forgotten. All links have been updated to HTTPS and checked whether they exist still in 2024. The primary header reference of the original: `http://pen-testing.sans.org/blog/pen-testing/2013/12/02/mobile-device-tips-tricks-and-resources` does not exist.

## Mobile Application Test Notes (iPhone)

Prepping Device and Application:

1. Jailbreak iPhone/iPad - Green Poison / Absinthe 2.04
1. Enable SSH on iPhone/iPad
1. Install `iFunbox` to install the application at [https://www.i-funbox.com/en/index.html](https://www.i-funbox.com/en/index.html)
1. Connect device to lab wireless network
1. Add web proxy settings - IP address of attacking machine port 8080
1. Ensure connection and SSH is working


### Prepping [[BurpSuite]]:

1. Open Burp Suite and navigate to Proxy->Options,
	- Edit proxy listeners – enter ‘port’ as 8080, disable ‘loopback only’ and select ‘support invisible’.
1. Download and install burp certificate (.crt) onto ipad.

#### Mobile Application Penetration Testing:
1. Browse the following Directory for insecure storage
	-  `/private/var/mobile/applications/`

1. Easy way:
	- Place attacking machine and apple device on wireless network with app installed.
	- Email burps .cer to apple device and install
	- Start burp and disable firewall on listening machine.
	- Change proxy settings on apple device to point to listening burp machine/port.
#### Notes

- Application file type - `x.ipa`


## Mobile Application Test Notes (Android)

#### Prepping the application
(After Android Nougat, Apps need to repackaged since they don't trust user certificates by default)
- https://android-developers.googleblog.com/2016/07/changes-to-trusted-certificate.html

1. `apktool d <path of the .apk file>`
1. Update AndroidManifest.xml
	- Add `android:networkSecurityConfig="@xml/network_security_config"` to application tag in xml
1. Add `network_security_config.xml` to `res/xm`l folder
	- "Trusting user-added CAs for all secure connections" section in: [https://android-developers.googleblog.com/2016/07/changes-to-trusted-certificate.html](		https://android-developers.googleblog.com/2016/07/changes-to-trusted-certificate.html)
1. Repackage the application 
	- `apktool b unpacked_apk_folder -o <output path to new apk file>`
1. Signing the application
	- Create a keystore using `keytool`
	- `jarsigner -keystore <path to your keystore> -storepass <password> -keypass <password> <path to apk> android

#### Creating an emulator and installing the application

1. Create a virtual device:
	- `android avd`
1. Start the emulator:
	- `emulator –avd testavd`
1. Install the application:
	- `adb install <path of the .apk file>`
1. Open [[BurpSuite]] and navigate to `Proxy` -> `Options`,
	- Edit proxy listeners – enter ‘port’ as 8080, disable ‘loopback only’ and select ‘support invisible’.
1. Start the emulator and proxy:
	- `emulator –avd testavd –http-proxy http://localhost:8080`
1. Download and install burp certificate (.crt) onto the emulator using the push shell command.
#### Notes:

- Application file type - `x.apk`

Tooling
- Installing Certifcates: https://www.realmb.com/droidCert/
- SQLite Database Browser: https://sourceforge.net/projects/sqlitebrowser/?source=pdlp
Best Practices
- [Mcafee White Paper on Pentesting Android Applications](https://www.mcafee.com/uk/resources/white-papers/foundstone/wp-pen-testing-android-apps.pdf) - NOT FOUND


## References

https://android-developers.googleblog.com/2016/07/changes-to-trusted-certificate.html
[https://android-developers.googleblog.com/2016/07/changes-to-trusted-certificate.html](               https://android-developers.googleblog.com/2016/07/changes-to-trusted-certificate.html)
[GitHub OlivierLaflamme/Cheatsheet-God/ - Cheatsheet_MobileAppTesting.txt](https://github.com/OlivierLaflamme/Cheatsheet-God/blob/master/Cheatsheet_MobileAppTesting.txt)
[Mcafee White Paper on Pentesting Android Applications](https://www.mcafee.com/uk/resources/white-papers/foundstone/wp-pen-testing-android-apps.pdf) - NOT FOUND
[https://www.i-funbox.com/en/index.html](https://www.i-funbox.com/en/index.html)
https://www.realmb.com/droidCert/
https://sourceforge.net/projects/sqlitebrowser/?source=pdlp
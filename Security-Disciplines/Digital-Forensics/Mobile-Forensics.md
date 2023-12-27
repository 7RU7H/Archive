# Mobile Forensics



#### Encryption

**Obtaining or discovering the encryption key or bypassing encryption somehow (and is proven possible on selected versions) is necessary for a complete digital forensic investigation**

- iOS 
	- [darthnull's iOS Primer on iOS encryption (A MUST READ)](https://darthnull.org/ios-encryption/): *Since the iPhone 3GS, all iOS devices have used a hardware-based AES full-disk encryption that prevents storage from being moved from one device to another, and facilitates a fast wipe of the disk.*


- Android
	- Android 4.4 introduced **full-disk encryption**
	- Android 6.0, encryption is **mandatory**
	- Android 7.0 introduced _Direct Boot_, a **file-based encryption** mode
	- Android 9.0 and higher can encrypt an SD card

#### Tools

Android Debug Bridge
```bash
 adb shell

# Find mounted storaged devices
mount | grep data

# Get raw dump of /dev/block/dm-0
adb pull /dev/block/dm-0 $savePathWithExtIMG.img

# Limitation on some applications explicitly disallow backups `allowBackup=false`
# Option is restricted since Android 12
adb backup -all -f android_backup.ab
```

- [[Autopsy]]
- [MVT](https://github.com/mvt-project/mvt)*(Mobile Verification Toolkit) helps with conducting forensics of mobile devices in order to find signs of a potential compromise.*

## References

[MVT](https://github.com/mvt-project/mvt)
[darthnull's iOS Primer on iOS encryption](https://darthnull.org/ios-encryption/)
[THM AoC 2023](https://tryhackme.com/room/adventofcyber2023)
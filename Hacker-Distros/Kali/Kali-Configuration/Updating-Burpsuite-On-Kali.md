# Updating Burpsuite On Kali

[Need to test but you can revert back to older burp with spider as part of community](https://neversecure.ca/2021/07/12/changing-burpsuite-versions-on-kali-linux/)

Burpsuite is pre-installed in a slightly unusual manner on Kali Linux it is a scripted startup so do not remove the script file - `/usr/bin/burpsuite`
This is the file : `/usr/bin/burpsuite`
```bash
#!/usr/bin/env sh

set -e

export JAVA_CMD=java

# Include the wrappers utility script
. /usr/lib/java-wrappers/java-wrappers.sh

run_java -jar /usr/share/burpsuite/burpsuite.jar "$@"
```

1. Download the JAR file from portswigger
2. Move the older burpsuite file from /usr/share/burpsuite to .old
```bash
sudo mv /usr/share/burpsuite /usr/share/burpsuite.old
```
3. Move the newer version in place of the previous version
```bash
sudo mv burpsuite_WHAT_EVER_VERSION_TAB_AUTOCOMPLETE.jar /usr/share/burpsuite
```
4. Change ownership and permissions for target user usage
```bash
sudo chown root:root /usr/share/burpsuite 
sudo chmod +x /usr/share/burpsuite
```

## Reference

[Ben (Portswigger Agent)'s Response to Troubleshooting](https://forum.portswigger.net/thread/burpsuite-not-running-eaa56c63b2a51e)
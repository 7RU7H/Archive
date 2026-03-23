# DAVtest

[Quote](https://www.kali.org/tools/davtest/): *"DAVTest tests WebDAV enabled servers by uploading test executable files, and then (optionally) uploading files which allow for command execution or other actions directly on the target. It is meant for penetration testers to quickly and easily determine if enabled DAV services are exploitable."*

[Supported by Kali](https://www.kali.org/tools/davtest/)
```bash
davtest -url "http://${TARGET_IP}:${TARGET_PORT}" -sendbd auto -cleanup
```

## References

[Kali Tools DAVtest](https://www.kali.org/tools/davtest/)
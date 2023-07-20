# Process Doppelganging

[From Ozan Unal](https://medium.com/@ozan.unal/process-injection-techniques-bc6396929740)
Process Doppelgänging is implemented in 4 steps:

-   **Transact** — Create a TxF transaction using a legitimate executable then overwrite the file with malicious code. These changes will be isolated and only visible within the context of the transaction.
-   **Load** — Create a shared section of memory and load the malicious executable.
-   **Rollback** — Undo changes to original executable, effectively removing malicious code from the file system.
-   **Animate** — Create a process from the tainted section of memory and initiate execution.


## References

[Ozan Unal](https://medium.com/@ozan.unal/process-injection-techniques-bc6396929740)
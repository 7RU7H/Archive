# Authentication


## Secrets 

#### [NIST Special Publication (SP) 800-63B](https://pages.nist.gov/800-63-4/sp800-63b.html) Summary of Secrets Table

| Type of Secret | Purpose |
| --- | --- | 
| Password                       | A subscriber-chosen secret used as an authentication factor |
| Look-up secret                 | A secret issued by a verifier and used only once to prove possession of the secret                                     | 
| Out-of-band secret             | A short-lived secret generated by a verifier and independently sent to a subscriber’s device to verify its possession  |
| One-time passcodes (OTP)       | A secret generated by an authenticator and used only once to prove possession of the authenticator                     |
| Activation secret              | A password that is used locally as an activation factor for a multi-factor authenticator                               |
| Long-term authenticator secret | A secret embedded in a physical authenticator to allow it to function for authentication                               |
| Recovery code                  | A secret issued to the subscriber to allow them to recover an account at which they are no longer able to authenticate | 
| Session secret                 | A secret issued by the verifier at authentication and used to establish the continuity of authenticated sessions       |
Follow link for the [NIST Special Publication (SP) 800-63B (Requirements by Authenticator Type)](https://pages.nist.gov/800-63-4/sp800-63b.html#reqauthtype)
## References

[NIST Special Publication (SP) 800-63B](https://pages.nist.gov/800-63-4/sp800-63b.html)
[NIST Special Publication (SP) 800-63B (Requirements by Authenticator Type)](https://pages.nist.gov/800-63-4/sp800-63b.html#reqauthtype)
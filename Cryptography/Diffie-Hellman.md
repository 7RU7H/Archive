# Diffie-Hellman 

#### Diffie-Hellman Key Exchange

Diffie-Hellman is an asymmetric encryption algorithm. The key exchange is prone to a [[MITM-Attacks]].

Use openssl to generate and view keys
```bash
# Generate a diffie-helman key
openssl dhparam -out dhparams.pem $size
# View the prime number `P` and generator `G`
openssl dhparam -in dhparams.pem -text -noout
```

[The mathematics below is noted from the youtube video Diffie Hellman -the Mathematics bit- Computerphile](https://www.youtube.com/watch?v=Yjrfm_oRO0w&t=1s):

Alice | Public  |Bob
--- | --- |---
`a`| `g`, `n`, | `b`
- `g` - small prime number
- `n` - a very large 2000-4000 bits long number
- `a` - private number of Alice between 1 and `n`
- `b` - private number of Bob between 1 and `n`
1. Alice calculates `g^a mod n = A`  - [Discrete log problem](https://en.wikipedia.org/wiki/Discrete_logarithm)
1. Bob calculates `g^b mod n = B`  
1. Then each shares `A and B`
2. Alice `(g^B)^a mod n` - each has (due to power of exponentiation is just) `g^ab mod n`
3. Bob `(g^A)^b mod n`  - each has (due to power of exponentiation is just) `g^ab mod n`

## References

[Secret Key Exchange (Diffie-Hellman) - Computerphile](https://www.youtube.com/watch?v=NmM9HA2MQGI)
[Youtube - Diffie Hellman - the Mathematics bit- Computerphile](https://www.youtube.com/watch?v=Yjrfm_oRO0w&t=1s):
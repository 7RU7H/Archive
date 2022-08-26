# RSA Encryption

This article makes extensive use of the [RSA Wikipedia article](https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Operation)

## Key Generation 

1. Choose two distint prime numbers `p` and `q
    - Choose at random with both similar, but still differ in length - use [primality test](https://en.wikipedia.org/wiki/Primality_test)
	- Keep `p` and `q` secret
2. Compute `n` = `pq`
	- `n` is modulus for public and private keys
	- `n` is released a part of the public key
3.   Compute _λ_(_n_), where _λ_ is [Carmichael's totient function](https://en.wikipedia.org/wiki/Carmichael%27s_totient_function "Carmichael's totient function"). Since _n_ = _pq_, _λ_(_n_) = [lcm](https://en.wikipedia.org/wiki/Least_common_multiple "Least common multiple")(_λ_(_p_), _λ_(_q_)), and since _p_ and _q_ are prime, _λ_(_p_) = _[φ](https://en.wikipedia.org/wiki/Euler_totient_function "Euler totient function")_(_p_) = _p_ − 1, and likewise _λ_(_q_) = _q_ − 1. Hence _λ_(_n_) = lcm(_p_ − 1, _q_ − 1).
    -   _λ_(_n_) is kept secret.
    -   The lcm may be calculated through the [Euclidean algorithm](https://en.wikipedia.org/wiki/Euclidean_algorithm "Euclidean algorithm"), since lcm(_a_, _b_) = |_ab_|/gcd(_a_, _b_).
4. Choose an integer _e_ such that 1 < _e_ < _λ_(_n_) and [gcd](https://en.wikipedia.org/wiki/Greatest_common_divisor "Greatest common divisor")(_e_, _λ_(_n_)) = 1; that is, _e_ and _λ_(_n_) are [coprime](https://en.wikipedia.org/wiki/Coprime "Coprime").
    -   _e_ having a short [bit-length](https://en.wikipedia.org/wiki/Bit-length "Bit-length") and small [Hamming weight](https://en.wikipedia.org/wiki/Hamming_weight "Hamming weight") results in more efficient encryption – the most commonly chosen value for _e_ is 216 + 1 = 65537. The smallest (and fastest) possible value for _e_ is 3, but such a small value for _e_ has been shown to be less secure in some settings.
    -   _e_ is released as part of the public key.
5. Determine _d_ as _d_ ≡ _e_−1 (mod _λ_(_n_)); that is, _d_ is the [modular multiplicative inverse](https://en.wikipedia.org/wiki/Modular_multiplicative_inverse "Modular multiplicative inverse") of _e_ modulo _λ_(_n_).
    -   This means: solve for _d_ the equation _d_⋅_e_ ≡ 1 (mod _λ_(_n_)); _d_ can be computed efficiently by using the [extended Euclidean algorithm](https://en.wikipedia.org/wiki/Extended_Euclidean_algorithm "Extended Euclidean algorithm"), since, thanks to _e_ and _λ_(_n_) being coprime, said equation is a form of [Bézout's identity](https://en.wikipedia.org/wiki/B%C3%A9zout%27s_identity "Bézout's identity"), where _d_ is one of the coefficients.
    -   _d_ is kept secret as the _private key exponent_.


### Encryption

After Bob obtains Alice's public key, he can send a message M to Alice.

To do it, he first turns M (strictly speaking, the un-padded plaintext) into an integer m (strictly speaking, the padded plaintext), such that 0 ≤ _m_ < _n_ by using an agreed-upon reversible protocol known as a [padding scheme](https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Padding_schemes). He then computes the ciphertext c, using Alice's public key e, corresponding to:

![{\displaystyle c\equiv m^{e}{\pmod {n}}.}](https://wikimedia.org/api/rest_v1/media/math/render/svg/2e52f73642221fad08a441c70d514ae06600cc4b) 

This can be done with [modular exponentiation](https://en.wikipedia.org/wiki/Modular_exponentiation "Modular exponentiation"). Bob then transmits c to Alice. Note that at least nine values of _m_ will yield a ciphertext c equal to _m_, but this is very unlikely to occur in practice.

## Decryption

- **Regular Decryption**
Alice can recover m from c by using her private key exponent d by computing

![{\displaystyle c^{d}\equiv (m^{e})^{d}\equiv m{\pmod {n}}.}](https://wikimedia.org/api/rest_v1/media/math/render/svg/111a80bbccad42f94fe247a2b3cc68664e682744) 

Given m, she can recover the original message M by reversing the padding scheme.

- **Irregular Decryption**

For the Brainfuck machine avaliable on HackTheBox the challenge involves decrypting a RSA key with all the components. This is also provides a great explanation as to why private keys and there parts in software, memory or store away unsafely is a bad idea for developer or handlers of data. 

[[Useful_Python]] for help if required.



To decrypt RSA [StackOverFlow](https://stackoverflow.com/questions/58750417/how-to-decrypt-an-rsa-encryption) or 
[Euler constant with Python](https://datagy.io/python-e-euler/)
[SageMath FAQ](https://doc.sagemath.org/html/en/faq/faq-usage.html)



## References
[Primality test Wikipedia article](https://en.wikipedia.org/wiki/Primality_test)
[RSA Wikipedia article](https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Operation)
[StackOverFlow](https://stackoverflow.com/questions/58750417/how-to-decrypt-an-rsa-encryption)
[Euler constant with Python](https://datagy.io/python-e-euler/)
[Python Math](https://docs.python.org/3/library/math.html)
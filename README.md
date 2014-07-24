PayloadBruteforce
=================

This is a proof of concept for a self decrypting program for it's payload that bruteforces the key itself for the payload to be decrypted. Improvment of https://www.christophertruncer.com/developing-self-brute-forcing-payload-veil/.

Instead of using the method of comparing to a known, plain text key, which IMHO defeats the purpose of decrypting the payload in general, this instead uses the fact that the payload itself HAS to be executable to be the payload.

For that to work, it can thusly, grab a random number, attempt to decrypt with said random number, and then attempt to execute the decrypted string. An error on execute loop catches it and tries again if it doesn't execute, and the likely hood of a random decryption variable causing even a small executable aspect, is minimal at best.

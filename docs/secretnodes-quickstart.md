# Enigma Nodes Overview

Enigma performs privacy-preserving computations across a network of computational nodes, taking this demand off of the blockchain. By doing so, Enigma is solving for both scalability and privacy.

Computational fees in the Enigma network are paid with ENG tokens, giving an economic incentive to nodes that perform private computations and form consensus on state. Enigma’s “secret nodes” are similar to masternodes, requiring the ENG token to be staked in order to ensure computations are performed correctly and to secure the network’s integrity. **Staking more ENG gives nodes a higher chance of selection for computational tasks and thus receiving ENG as fees.** The ENG token can be thought of like Gas on the Ethereum protocol: users pay the nodes on the network to run computations. The minimum stake for a secret node is 25,000 ENG.

Mainnet secret nodes are being selected during a testnet period called the **Genesis Game**. During this period, the nodes with the most staked testnet tokens and uptime will qualify as **Genesis Nodes**. Genesis nodes are the first nodes in our network and the only ones eligible for block rewards and fees in the early stages of the protocol. If you’re interested in becoming a secret node runner, [please read this information thoroughly](/genesisgames-overview.md), as it contains critical information on participating in the Genesis Game!

# Enigma Node Types

As Enigma proceeds along its roadmap, nodes will be divided into two types, outlined below.

**Secret nodes:** Secret nodes are network participants that run a node in the Enigma network and ensure secret contracts are executed in a privacy preserving manner. Nodes in Enigma network can be thought of as performing a function similar to miners in Bitcoin.

**Consensus nodes:** Consensus nodes will operate the Enigma blockchain itself — they validate computations and set the final ordering of state changes. (In our first release, Discovery, these type of nodes are not yet available to run as we instead rely on Ethereum for verification.)

# Computations over encrypted data

[Source](https://blog.enigma.co/computing-over-encrypted-data-d36621458447)

Often described as the holy grail of security, computing over encrypted data, or more aptly defined in the literature as secure computation, asks the question — _how can we compute a function over hidden inputs?_ In other words, how can we process information we cannot see, while still obtaining an intelligible outcome.

Akin to a chef preparing a meal without seeing the ingredients, secure computation presents a seemingly impossible problem. How can someone, even if that someone is the world’s most advanced supercomputer, make sense of data that’s unobservable? Luckily, cryptography has some neat tricks under its belt that defy intuition.

Computing over encrypted data presents many interesting applications. Conceptually, if we can keep information private and secure even when it’s being used, keeping security and privacy become a much more manageable problem.

As it turns out, there are several ways to compute over encrypted data — each with a unique approach and different tradeoffs. In the rest of this post we’ll skim through the different options out there.

## Fully Homomorphic Encryption (FHE)
Before we explain what a (fully) homomorphic encryption scheme, it seems appropriate for completeness to remind how a plain encryption scheme is defined. An encryption scheme is given by two algorithms Encrypt and Decrypt, that works as follows:

>ciphertext = Encrypt(key, message) — given a secret key and a plaintext message, one can obtain a ciphertext that reveals nothing (on its own) about the message

>message = Decrypt(key, ciphertext) — given a secret key and ciphertext, one can obtain the original plaintext message.

>In the case of public-key crypto, the encryption and decryption keys differ. For the sake of this article, this distinction is not important.

In simpler terms, an encryption allows us to hide data in a way that appears meaningless to anyone except those who have access to the secret decryption key. Without the key, the data is meaningless. One shortcoming of encryption is that generally, doing a computation over the ciphertext-space does not affect the ciphertexts in the same way as doing the computation over the plaintext data. If, however, it does, then we call this scheme homomorphic.

For example, imagine we have two values a and b, and using a homomorphic encryption algorithm we obtain the encrypted values ea and eb. If we attempt to add ec = ea + eb together, then ec would equal an encryption of the sum of a + b. In other words, when ec is decrypted, it would result in the sum of the two integers.

To make matters more complicated, note that in general, mapping from plaintext space to encrypted space may involve different operations. In the commonly used Paillier cryptosystem, a multiplication of ciphertexts in the encrypted space results in an addition of the underlying plaintext values.

Paillier cryptosystem is an example of an additively homomorphic encryption scheme. An encryption scheme that supports computing addition and summation over encrypted data. It is therefore a partially homomorphic encryption scheme. To obtain a fully homomorphic scheme, one needs to find an encryption that supports both addition and multiplication on the ciphertexts. These two operations are complete in the sense that any other computational task could be constructed from these two operators alone.

It therefore appears that finding a fully homomorphic encryption scheme (FHE) should not be a difficult task. However, until Gentry’s superb work in 2009, we only theorized that such schemes existed, but did not know of any in practice. Unfortunately, despite many refinements and improvements since, FHE remains a theoretical advancement, and making these schemes practical is as elusive as finding a solution to the strong AI problem. The currently proposed schemes are so impractical, that nothing but very simple computations can be performed in reasonable time.

## Secure Multi-party Computation (MPC)

A second approach to realizing computation over encrypted data is called _Secure Multi-party Computation_, or MPC for short. MPC is the distributed systems answer to solving the problem, and is slightly more complicated to explain.

MPC starts by asking a philosophical question. Is there any trusted third party, a supercomputer of sorts, that we can send our data to and trust it to perform computations on our behalf, without potentially leaking our private information? This is the equivalent of envisioning a server that can never be hacked or compromised (internally or externally). Since this is not possible in reality (or else we wouldn’t need security at all), we call this the ideal world and aspire to simulate such an omnipotent and trustworthy machine.

MPC then proposes to emulate such a trusted third party by using a bunch of untrusted parties. In other words, we can design a network of computers that will ensure that no data leaks during computation. Each computer in the network only sees encrypted bits of data — but never anything meaningful. The only way to recover the plaintext data is by controlling enough systems in the network (as opposed to gaining control of a secret key). The number of systems needed to reconstruct the data is a tunable parameter that can range from some portion of the system up to all of them.

There are two main ways to implement MPC — Secret Sharing and Garbled Circuits. We will focus on the secret sharing version here, as that’s what Enigma uses, and is also more suited for performance-sensitive applications. Like in the encryption case, we can define secret sharing using a set of two distributed algorithms — Share (the equivalent of Encrypt) and Reconstruct (the equivalent of Decrypt):

>m1 , m2, …, mn = Share(m, n, t)

>m = Reconstruct(m1 , m2, …, mk)

Instead of creating a single ciphertext using a key, the share function splits a message into n encrypted shares of the message. Each message on its own is meaningless, but any set of t or more such shares can be used to reconstruct the original message back. No keys are needed! If you were paying attention, you could already imagine how this works in production. If you want to protect some data, simply call Share on the client-side, and transmit one resultant share to each computer in the network. An attacker would need to compromise t servers at any given point in time to get the data back, which is highly unlikely for a large t.

As it turns out, secret sharing is also additively homomorphic. This means that to compute the sum of two secret-shared integers, each computer in the network needs to sum up their two shares of these integers. To obtain the raw output, one needs to obtain enough shares of the outcome and call Reconstruct.

To summarize, MPC provides the same guarantees as FHE, but the security model depends on having a network of non-colluding computers as opposed to using cryptographic keys.

## Zero-Knowledge Proofs (ZKP)

A specific, narrower aspect of Secure Computation is Zero-Knowledge Proofs (ZKP), which focuses on proving/disproving statements (i.e., yes/no questions only). The formulation of ZKP involves two parties of interest — a prover and a verifier. The goal is to have the prover prove to the verifier some argument, without revealing any other information.

The simplest type of ZKP are proofs of knowledge. In this version, the prover must show that he possesses knowledge of some secret information, without revealing it. If the rules of the game were different and we didn’t care about revealing the secret information, then the solution would be trivial — simply show the secret to the verifier. One significant real life example where ZKP are useful is authentication. One could prove his or her identity by showing they have knowledge of some secret passphrase or a key, without actually providing that secret directly.

Zero knowledge proofs could be summarized into three properties of interest –

* **Completeness** — If the statement is true, the verifier will be convinced.
* **Soundness** — If the statement is false, then the prover cannot convince the verifier (except for some negligible probability).
* **Zero-knowledge** — The verifier will only learn if the statement is true — and nothing else.

These properties capture well the intuition of ZKPs — proving statements without revealing any side-information is possible.

Despite popular belief, the concept of ZKPs is not new and dates back to the 80s of the previous century. ZKPs have long been associated with MPC. The reason the two are interconnected is because both deal with private computation in an environment where multiple parties exist. In fact, ZKP is an important tool in implementing MPC that is also secure against byzantine faults — a generic term for describing nodes in a network that can behave in arbitrary (including malicious) ways. In this threat model, ZKP is used internally by the nodes running the secure multi-party computation protocols, to prove to each other that they have correctly performed the computational task at hand and that they have not revealed any secret information. On the flipside, MPC itself can be used to instantiate zero-knowledge protocols.

The recent interest in ZKP stems from the introduction of zk-SNARKs (zero-knowledge Succinct Non-interactive Arguments of Knowledge). zk-SNARKs are a special form of ZKP that is also non-interactive — the prover and verifier aren’t required to be online at the same time, and succinct — the proofs are small in size, which makes verification fast. The two big shortcomings of the technology are that generating the proof is still incredibly slow (proving relatively simple statements would still take minutes) and that the cryptographic assumptions used are fairly new and not well established in academia or industry.

zk-SNARKs have found at least one interesting application of creating a truly anonymous cryptocurrency. Z.Cash is an adaptation of the Bitcoin blockchain to include zk-SNARKs built-in, with the goal of encrypting the transactional entries in the ledger, while still proving that no double-spending occurs. Z.Cash (originally known as Zerocash in academia), seems to have found an interesting use-case that is able to make good use of the practical limitations of the technology — holding succinct proofs in a permanent ledger might be worth the overhead involved with generating the proofs in the first place. Another interesting bit of information is that launching the Z.Cash blockchain involved a ceremony to generate the public parameters used throughout the system. _That ceremony was an implementation of a MPC protocol, used in order to decentralize the trust across several participants and not just a single one._

## Deterministic and Order-preserving Encryption (OPE)

Deterministic and Order-preserving Encryptions are sorts of partial encryptions that allow some types of operations (not all). These methods of encryption have been employed in academia in CryptDB and more recently in production in systems such as Numer.ai. Unlike the methods mentioned above, these techniques are not truly secure in the way we define acceptable security for encryption and MPC, and they provide weaker guarantees. They are also limited in functionality. However, they are much easier to implement and are significantly faster.

To understand why these schemes are insecure, one needs to realize that they still leak a meaningful portion of the data. For example, OPE is defined as an encryption that preserves the ordering of the element. Specifically, given two ciphertexts c1, c2, corresponding to messages m1, m2 then if c1 < c2 so does m1 < m2. Now imagine that you have an encrypted column representing people’s age. Ages are integral types with a small range of typically 0–100. Given sufficiently many rows (even as little as 1000 should be enough), one could easily map back the encrypted values into integers with high accuracy and likelihood of being correct. Therefore, while tempting from an implementation perspective, these techniques are discouraged and are only brought here for completeness.



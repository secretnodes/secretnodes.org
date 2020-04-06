# Enigma Nodes Overview

Enigma performs privacy-preserving computations across a network of computational nodes, taking this demand off of the blockchain. By doing so, Enigma is solving for both scalability and privacy.

Computational fees in the Enigma network are paid with ENG tokens, giving an economic incentive to nodes that perform private computations and form consensus on state. Enigma’s “secret nodes” are similar to masternodes, requiring the ENG token to be staked in order to ensure computations are performed correctly and to secure the network’s integrity. **Staking more ENG gives nodes a higher chance of selection for computational tasks and thus receiving ENG as fees.** The ENG token can be thought of like Gas on the Ethereum protocol: users pay the nodes on the network to run computations. The minimum stake for a secret node is 25,000 ENG.

Mainnet secret nodes are being selected during a testnet period called the **Genesis Game**. During this period, the nodes with the most staked testnet tokens and uptime will qualify as **Genesis Nodes**. Genesis nodes are the first nodes in our network and the only ones eligible for block rewards and fees in the early stages of the protocol. If you’re interested in becoming a secret node runner, [please read this information thoroughly](https://secretnodes.org/#/genesisgames-overview), as it contains critical information on participating in the Genesis Game!

# What are Secret Nodes?

As Enigma proceeds along its roadmap, nodes will be divided into two types, outlined below.

**Secret Nodes:** Secret nodes are network participants that run a node in the Enigma network and ensure secret contracts are executed in a privacy preserving manner. Nodes in Enigma network can be thought of as performing a function similar to miners in Bitcoin. Secret Nodes also operates the consensus layer of the Enigma blockchain — they validate computations and set the final ordering of state changes. Note: Nodes on the Enigma mainnet will be referred to as Enigma Nodes until secret contracts are live on the enigma mainnet.

# Computations over encrypted data

[Source](https://blog.enigma.co/computing-over-encrypted-data-d36621458447)

Often described as the holy grail of security, computing over encrypted data, or more aptly defined in the literature as secure computation, asks the question — _how can we compute a function over hidden inputs?_ In other words, how can we process information we cannot see, while still obtaining an intelligible outcome.

Akin to a chef preparing a meal without seeing the ingredients, secure computation presents a seemingly impossible problem. How can someone, even if that someone is the world’s most advanced supercomputer, make sense of data that’s unobservable? Luckily, cryptography has some neat tricks under its belt that defy intuition.

Computing over encrypted data presents many interesting applications. Conceptually, if we can keep information private and secure even when it’s being used, keeping security and privacy become a much more manageable problem.

As it turns out, there are several ways to compute over encrypted data — each with a unique approach and different tradeoffs. In the rest of this post we’ll skim through the different options out there.
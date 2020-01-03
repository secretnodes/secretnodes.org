# Instructions for ETH node.
While there is no requirement to run an ETH Node on the same machine as your Secret Node, these instructions assume you are using the same machine. This will be updated as we get closer to the Genesis Game.

## Download and Launch Parity ETH Node

Open a terminal session, login with the user you created in the NUC or Vultr Guide, then proceed to run the following 2 scripts.

```bash
wget -O parity-eth-node.sh https://raw.githubusercontent.com/secretnodes/scripts/master/parity-eth-node.sh
```

Launch the Parity ETH Node Script

```bash
bash parity-eth-node.sh
```

Going forward you should only need to run the 2nd command to launch your eth node.

> Note : If you run into permissions issues, be sure that you've already followed either the NUC or Vultr guide I have exactly and be sure you are using ubuntu Server 18.04. You must use a correctly permissioned user account that has access to docker, which our guides walk you through. To further troubleshoot try searching your issue on a popular search engine, asking someone in the community for assistance, or if you have followed our guides exactly.

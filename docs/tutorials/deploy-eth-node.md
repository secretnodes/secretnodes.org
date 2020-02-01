# Instructions for ETH node.
While there is no requirement to run an ETH Node on the same machine as your Secret Node, these instructions assume you are using the same machine, that you set up that machine using one of our guides, and that you're using the user account my guides instruct you to create. If that doesn't match your setup then this may not work. This page will be further updated as we get closer to the Genesis Game.

!>Note: Currently this guide only works consistently when running these commands as root. Running through root during the Genesis Game or on Mainnet is not advisable but if you'd like to test before then feel free to do so!

## Download and Launch Parity ETH Node

Open a terminal session, login with the user you created in the NUC or Vultr Guide, then proceed to run the following 2 scripts.

```bash
wget -O parity-eth-node.sh https://raw.githubusercontent.com/secretnodes/scripts/master/eth-provision.sh
```

Launch the Parity ETH Node Script

```bash
bash eth-start.sh
```

Going forward you should only need to run the 2nd command to launch your eth node.

> Note : If you run into permissions issues, be sure that you've already followed either the NUC or Vultr guide I have exactly and be sure you are using ubuntu Server 18.04. You must use a correctly permissioned user account that has access to docker, which our guides walk you through. To further troubleshoot try searching your issue on a popular search engine or asking someone in the community for assistance.

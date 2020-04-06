# How to join Kamut Enigma Blockchain Testnet as a Validator or Fullnode

This document details how to join the Kamut Enigma Blockchain `Testnet` as a validator.

## Requirements

- Ubuntu/Debian host (with ZFS or LVM to be able to add more storage easily)
- A public IP address
- Open ports `TCP 26656 & 26657` _Note: If you're behind a router or firewall then you'll need to port forward on the network device._
- Reading https://docs.tendermint.com/master/tendermint-core/running-in-production.html

## Installation

### 1. Download the [Kamut Testnet package installer](https://github.com/chainofsecrets/KamutBlockchain/releases/download/v0.9.0/kamut-blockchain_0.9.0_amd64.deb) (Debian/Ubuntu):

```bash
wget https://github.com/chainofsecrets/KamutBlockchain/releases/download/v0.9.0/kamut-blockchain_0.9.0_amd64.deb
```

### 2. Install the Kamut Testnet package:

```bash
sudo dpkg -i kamut-blockchain_0.9.0_amd64.deb
```

### 3. Update the configuration file that sets up the system service with your current user as the user this service will run as.

_Note: Even if we are running this command and the previous one with sudo, this package does not need to be run as root_.

```bash
sudo perl -i -pe "s/XXXXX/$USER/" /etc/systemd/system/kamut-node.service
```

### 5. Change `[moniker]` to a name you want to have your node seen in public as

```bash
kamutd init [moniker] --chain-id kamut-1
```
### 6. Download a copy of the Kamut Testnet Genesis Block file: `genesis.json`

```bash
wget -O ~/.kamutd/config/genesis.json "https://raw.githubusercontent.com/chainofsecrets/KamutBlockchain/master/genesis/genesis.json"
```
### 7. Valid Genesis
```bash
kamutd validate-genesis
```

### 8. Setting Persistent Node to Kamut Bootstrap 
```bash
perl -i -pe 's/persistent_peers = ""/persistent_peers = "7c22a072fe43a3c5771e00646b1cef0c1d41f459\@78.47.43.118:26656"/' ~/.kamutd/config/config.toml
```
### 9. Replace `<keyalias>` with your friendly key name.

```bash
kamutcli keys add <keyalias>
```

### 10. Enable kamut-node as a system service:

```bash
sudo systemctl enable kamut-node
```

### 11. Start kamut-node as a system service:

```bash
sudo systemctl start kamut-node
```

### 12. If everything above worked correctly, the following command will show your node streaming blocks after all genesis validators come up (this is for debugging purposes only, kill this command anytime with Ctrl-C):

```bash
journalctl -f -u kamut-node
```

### 13. Add the following configuration settings (some of these avoid having to type some flags all the time):

```bash
kamutcli config chain-id kamut-1
```

```bash
kamutcli config output json
```

```bash
kamutcli config indent true
```

```bash
kamutcli config trust-node true # true if you trust the full-node you are connecting to, false otherwise
```


# Join as Kamut Testnet as new Validator

Firstly, please run the following and paste the address into testnet telegram so we can give you some SCRT tokens in this account to create your validator.

```bash
kamutcli keys show -a <key-alias>
```

After you have a private node up and running, run the following command:

```bash
kamutcli tx staking create-validator \
  --amount=100000uscrt \ # This is the amount of coins you put at stake. i.e. 100000uscrt
  --pubkey=$(kamutd tendermint show-validator) \
  --moniker="<change-to-name-of-your-moniker>" \
  --chain-id=kamut-1 \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation="1" \
  --gas="auto" \
  --from=<name or address> # Name or address of your existing account
```

To check if you got added to the validator-set by running:

```bash
kamutcli q tendermint-validator-set
```

For support on the Kamut Testnet please visit [Kamut Enigma Testnet](https://t.me/enigmatestnet)

[Original Source](https://raw.githubusercontent.com/chainofsecrets/kamut-testnet/master/docs/validators-and-full-nodes.md)
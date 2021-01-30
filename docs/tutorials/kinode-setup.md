Run a Full Node

This document details how to join kichain `mainnet` as a validator.

#### ⚙️ Recommended hardware specs
To participate in this Mainnet you must have a server with the minimum following specifications:

- Up to date SGX ([Read this](https://learn.scrt.network/sgx.html), [Setup](setup-sgx.md), [Verify](verify-sgx.md))
- 1GB RAM
- 100GB HDD
- 1 dedicated core of any Intel Skylake processor (Intel® 6th generation) or better

#### Recommended requirements

- Ubuntu 18.04 OS
- 2 CPUs (recommended 4CPUs)
- 4GB RAM
- 40GB SSD (recommended 80GB SSD)

### Installation

#### ✅ Install Golang

To install Go, visit the Go download page and copy the link of the following Go release for Linux systems:

```bash
cd ~

wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz

sudo tar -C /usr/local -xzf go1.13.5.linux-amd64.tar.gz
```

#### Finally, export the Go paths like so:

```bash
mkdir -p $HOME/go/bin

PATH=$PATH:/usr/local/go/bin

echo "export PATH=$PATH:$(go env GOPATH)/bin" >> ~/.bash_profile

source ~/.bash_profile
```

#### To test the Go installation, use the version command to check the downloaded version as follows :

```bash
go version
```

#### This should output :

```bash
go version go1.13.5 linux/amd64

```


##### 🛠 Install ki-tools

Start by clone this repository. If you are here, you most likely have git installed already, otherwise just run:

```bash
sudo apt install git
```

And now you can clone the repository as follows:

```bash
git clone https://github.com/KiFoundation/ki-tools.git
```

Make sure your are on the master branch. Indeed, this branch contains the tools for the mainnet validator installation, while the testnet branch holds the tools for installing Testnet validators.


```bash
cd ki-tools

git checkout master

```

If your are starting with a clean ubuntu (which is recommended) install you might need to install the build-essential package:

```bash
sudo apt update

sudo apt install build-essential
```

Finally, install the tools as follows:

```bash
make install
```

To test the installation, check the downloaded version as follows :

```bash
kid version --long
```

It must output something like this :

```bash
name: ki-tools
server_name: kid
client_name: kicli
version: 0.1–14-g5814c4b-Mainnet
commit: 5814c4bd64a2a2f7d388d9155c2d4b69b11fb03c
build_tags: netgo,ledger
go: go version go1.13.5 linux/amd64
```

##### 🚀 Deploy a Kichain node

And follow the dedicated tutorial hereunder.

Once done, create a folder to contain your node information:

```bash
export NODE_ROOT=/home/<username>/kifolder
mkdir -p $NODE_ROOT/kid $NODE_ROOT/kicli $NODE_ROOT/kilogs
cd $NODE_ROOT
```

Initiate the needed configuration files using the unsafe-reset-allcommand:

```bash
kid unsafe-reset-all --home ./kid
```

Copy the genesis file to the ./kid/config/ folder:

```bash
cd <location of your choice>/kid/config/

wget https://raw.githubusercontent.com/KiFoundation/ki-networks/v0.1/Mainnet/kichain-1/genesis.json
```

Once done, you need to give a name to your node and indicate the seed server to which it should connect to join the network. All of this can be done in the config.toml that can be found in the ./kid/config/ directory. Change the default moniker to whatever you want (the default name is the machine name).
Since the network infrastructures can vary from one node to the other, we recommend that you manually set your external listen address. This can be done by filling in the external_address field as follows:


```bash
external_address="tcp://IP:PORT"
```

Where, IP is the public IP of your node and PORT is your listen address that defaults to 26656.
To allow your node to connect to the network, provide the following seed node address in the seeds field:

```bash
seeds="24cbccfa8813accd0ebdb09e7cdb54cff2e8fcd9@51.89.166.197:26656"
```

Then provide in the field persistent_peers the address of the following persistent peers to ensure that your node is always connected to the network:

```bash
persistent_peers="81396d4703a2e3cbd136c7324e4df5686fd48218@35.180.8.214:26656,c597db55d9a609b8b77c3d37ecf1fa9a67117cc0@144.217.82.4:26656,e195adf87e7ee724d21cacc9c59c74fd6d7977c0@54.37.233.162:26656"
```

🛑 To protect your node from being spammed by empty transactions, we recommend you to set a minimum gas price. For this, edit the minimum-gas-price parameter in the file ./kid/config/app.toml as follows:

```bash
minimum-gas-price="0.025uxki"
```

Now that the node is configured, you can create a systemd file.

```bash
sudo nano /etc/systemd/system/ki-node.service
```

Enter this into the file, replace <username> with your username, and save.

```bash
[Unit]
Description=KI Node Daemon
After=network-online.target

[Service]
User=ki-nuc
WorkingDirectory=/home/<username>/kifolder
ExecStart=/home/<username>/go/bin/kid start --home /home/<username>/kifolder/.kid/
Restart=always
RestartSec=3
LimitNOFILE=4096
[Install]
WantedBy=multi-user.target
```

Now enable the new service.

```bash
sudo systemctl enable ki-node
```

Then start the ki-node service.

```bash
sudo systemctl start ki-node
```

To see if you are streaming blocks you can run this

```bash
journalctl -u ki-node.service -f
```

If you set things up correctly you should see an output similar to this

```bash
ki@ki-server:~/kifolder/.kid/config$ journalctl -u ki-node.service -f
-- Logs begin at Fri 2021-01-29 19:48:31 UTC. --
Jan 30 06:49:07 ki-server kid[20869]: I[2021-01-30|06:49:07.181] Executed block                               module=state height=64 validTxs=0 invalidTxs=0
Jan 30 06:49:07 ki-server kid[20869]: I[2021-01-30|06:49:07.184] Committed state                              module=state height=64 txs=0 appHash=35B20F66799B6E56F8F4196B849C88B5DC95385F8351DEE45ED8D408E259E64D
Jan 30 06:49:07 ki-server kid[20869]: I[2021-01-30|06:49:07.191] Executed block                               module=state height=65 validTxs=0 invalidTxs=0
Jan 30 06:49:07 ki-server kid[20869]: I[2021-01-30|06:49:07.194] Committed state                              module=state height=65 txs=0 appHash=E84C29DA730653A2E15D1562C7008559D0F89C7DED46C8440CDD59813FF8964B
Jan 30 06:49:07 ki-server kid[20869]: I[2021-01-30|06:49:07.201] Executed block                               module=state height=66 validTxs=0 invalidTxs=0
Jan 30 06:49:07 ki-server kid[20869]: I[2021-01-30|06:49:07.204] Committed state                              module=state height=66 txs=0 appHash=1C50D05F86C7FF8300175F351820B5280B67C72AE06368E4200C0E6A6BF047D2
Jan 30 06:49:07 ki-server kid[20869]: I[2021-01-30|06:49:07.211] Executed block                               module=state height=67 validTxs=0 invalidTxs=0
Jan 30 06:49:07 ki-server kid[20869]: I[2021-01-30|06:49:07.214] Committed state                              module=state height=67 txs=0 appHash=BA555EA2AC6515222AD3BF22ACCCBAF8E13F47B7BF2E0A6AAF66E54705B2AD4B
Jan 30 06:49:07 ki-server kid[20869]: I[2021-01-30|06:49:07.223] Executed block                               module=state height=68 validTxs=0 invalidTxs=0
Jan 30 06:49:07 ki-server kid[20869]: I[2021-01-30|06:49:07.226] Committed state                              module=state height=68 txs=0 appHash=0AF8FB4840639A915DE2984B2F5749C3B54A3AB8F4B43BF8C432EC7E97AECB07
Jan 30 06:49:07 ki-server kid[20869]: I[2021-01-30|06:49:07.234] Executed block                               module=state height=69 validTxs=0 invalidTxs=0
Jan 30 06:49:07 ki-server kid[20869]: I[2021-01-30|06:49:07.238] Committed state                              module=state height=69 txs=0 appHash=188C30877AB8C48F47984A5FA5F0EC8520C73F09C8562DDE8AA77DA5D0359796
Jan 30 06:49:07 ki-server kid[20869]: I[2021-01-30|06:49:07.248] Executed block                               module=state height=70 validTxs=0 invalidTxs=0
Jan 30 06:49:07 ki-server kid[20869]: I[2021-01-30|06:49:07.251] Committed state                              module=state height=70 txs=0 appHash=987E9D2F7545658A84F05DC273B86BC714306613754DE379BDD6C97F8EDB5339
```

Note : You will need to wait for the end of the synchronisation process before proceeding to the validator creation.

The previous steps will start the node in a relay mode. That is, it is relaying transactions and blocks, but note validating new blocks. To enable the validation process, you need to create and declare your own validator. Start by create your validator wallet by generating a new key pair as follows (Here we call it wallet-1 but you can call it whatever you want):

```bash
kicli keys add wallet-1 --home ./kicli/
```

Enter your password twice and then save the generated addresses, keys and passphrase.


##### 🏆 Initiate your validator

Now that your wallet has a positive balance, you can create your validator through a staking transaction:

```bash
kicli tx staking create-validator \
            --commission-max-change-rate=0.1 \
            --commission-max-rate=0.1 \
            --commission-rate=0.05 \
            --min-self-delegation=1 \
            --amount=1000000uxki \
            --pubkey `kid tendermint show-validator --home ./kid/` \
            --moniker=<moniker-no-carrots> \
            --chain-id=kichain-1 \
            --gas-prices=0.025uxki \
            --from=<wallet-name-no-carrots> \
            --home ./kicli/
```

To know more about the various possible configurations of your validator, please refer to the dedicated documentation. Once this transaction has passed, and if the bonded amount is sufficient to be in the active validator list, your validator will automatically start validating new blocks. You can check the list of active validators and a bunch of details on the blockchain's transactions, blocks and accounts on the Ki Explorer.

Bonus: To make your validator more identifiable and to attach additional information to it (e.g., a website), you can use an editing transaction as follow :

```bash
kicli tx staking edit-validator  \
                  --identity=<Keybase Key> \
                  --chain-id=kichain-1 \
                  --from=wallet-1 \
                  --gas-prices=0.025uxki \
                  --home ./kicli/
```

This will refer to an existing Keybase account and use its associated information (e.g. avatar image) as meta data for you validator.

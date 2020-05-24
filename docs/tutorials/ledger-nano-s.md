# Use your Ledger with the Secret Network

Note: This guide is for Ledger Nano S or Ledger Nano X.

## Prerequisites

- This guide assumes you have a verified, genuine Ledger Nano S or X device.
- If you don't, or you using your Ledger device for the first time, you should check Ledger's [Getting Started](https://support.ledger.com/hc/en-us/sections/360001415213-Getting-started) guide.
- We also advise you to check your Ledger's genuineness and upgrade your firmware to the newest one available (`v1.6.0+`).
- Have a machine with [Ledger Live](https://www.ledger.com/ledger-live) installed.
- Have the latest version of our latest binaries installed. You can get it [here](https://github.com/enigmampc/EnigmaBlockchain/releases/latest).

## Install Cosmos Ledger App

- Open Ledger Live and go to Settings (gear icon on the top right corner):
  ![](https://raw.githubusercontent.com/cosmos/ledger-cosmos/master/docs/img/cosmos_app1.png)

- Enable developer mode:  
  ![](https://raw.githubusercontent.com/cosmos/ledger-cosmos/master/docs/img/cosmos_app2.png)

- Now go to Manager and search "Cosmos":
  ![](https://raw.githubusercontent.com/cosmos/ledger-cosmos/master/docs/img/cosmos_app3.png)

- Our binaries require Cosmos App Version `1.5.1` (if you only see a lower version available, like `1.0.0`, then you need to upgrade your Ledger firmware).

- Hit "Install" and wait for the process to complete.

_Ref: https://github.com/cosmos/ledger-cosmos_

## Common commands

These are some basic examples of commands you can use with your Ledger. You may notice that most commands stay the same, you just need to add the `--ledger` flag.

**Note: To run these commands below, or any command that requires signing with your Ledger device, you need your Ledger to be opened on the Cosmos App:**  
![](https://miro.medium.com/max/1536/1*Xfi5_ScAiFn6rr9YBjgFFw.jpeg)
_Ref: https://medium.com/cryptium-cosmos/how-to-store-your-cosmos-atoms-on-your-ledger-and-delegate-with-the-command-line-929eb29705f_

# Install the `enigmacli` Secret Network light client

1. Get the latest release of `enigmacli` for your OS: https://github.com/enigmampc/EnigmaBlockchain/releases/latest.

2) Install:

   - Mac/Windows: Rename it from `enigmacli-${VERSION}-${OS}` to `enigmacli` or `enigmacli.exe` and put it in your path.
   - Ubuntu/Debian: `sudo dpkg -i enigma*.deb`

3) Configure:

   ```bash
   # Set the mainnet chain-id
   enigmacli config chain-id enigma-1
   ```

   ```bash
   enigmacli config output json
   ```

   ```bash
   enigmacli config indent true
   ```

   ```bash
   # Set the full node address
   enigmacli config node tcp://client.secretnodes.org:26657
   ```

   ```bash
   # Verify everything you receive from the full node
   enigmacli config trust-node false
   ```

4) Check the installation:

   ```bash
   enigmacli status
   ```

### Send tokens

```bash
enigmacli tx send <account name or address> <to_address> <amount> --ledger
```

### Delegate SCRT to a validator

```bash
enigmacli tx staking delegate <validator address> <amount to bond> --from <account key> --gas auto --gas-prices <gasPrice> --ledger
```

### Collect rewards and commission

```bash
enigmacli tx distribution withdraw-all-rewards --from <account name> --gas auto --commission --ledger
```

### Vote on proposals

```bash
enigmacli tx gov vote <proposal-id> <vote> --from <account name> --ledger
```

[Original Source](https://github.com/enigmampc/EnigmaBlockchain/blob/master/docs/ledger-nano-s.md)
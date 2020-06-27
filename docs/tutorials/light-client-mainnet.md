# How to use secretcli as an Enigma Blockchain light client

1. Download the [Secret Network package installer](https://github.com/secretnodes/TheRomulusUpgrade/releases/download/v0.2.0/secretnetwork_0.2.0_amd64.deb) (Debian/Ubuntu):

```bash
wget https://github.com/secretnodes/TheRomulusUpgrade/releases/download/v0.2.0/secretnetwork_0.2.0_amd64.deb
```

2) Install:

   - Mac/Windows: Rename it from `secretcli-${VERSION}-${OS}` to `secretcli` or `secretcli.exe` and put it in your path.
   - Ubuntu/Debian: `sudo dpkg -i SecretNetwork*.deb`

3) Configure:

   ```bash
   # Set the mainnet chain-id
   secretcli config chain-id secret-1
   ```

   ```bash
   secretcli config output json
   ```

   ```bash
   secretcli config indent true
   ```

   ```bash
   # Set the full node address
   secretcli config node tcp://bootstrap.mainnet.enigma.co:26657
   ```

   ```bash
   # Verify everything you receive from the full node
   secretcli config trust-node false
   ```

4) Check the installation:

   ```bash
   secretcli status
   ```

[Original Source](https://github.com/enigmampc/EnigmaBlockchain/blob/master/docs/ligth-client-mainnet.md)

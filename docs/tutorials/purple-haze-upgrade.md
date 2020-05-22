# Purple Haze Upgrade Proposal

![logo](_media/swap-kamut.png ':size=50x100')

The following document describes the necessary steps involved that full-node operators
must take in order to upgrade from `enigma` to `secret`. The Tendermint team
will post an official updated genesis file, but it is recommended that validators
execute the following instructions in order to verify the resulting genesis file.

There is a strong social consensus around proposal `Cosmos Hub 3 Upgrade Proposal E`
on `cosmoshub-2`. This indicates that the upgrade procedure should be performed
on `December 11, 2019 at or around 14:27 UTC` on block `2,902,000`.

  - [Preliminary](#preliminary)
  - [Major Updates](#major-updates)
  - [Risks](#risks)
  - [Recovery](#recovery)
  - [Upgrade Procedure](#upgrade-procedure)
  - [Notes for Service Providers](#notes-for-service-providers)

This proposal must specify perfectly:
- Block number to fork from (can roughly be calculated)
- Exactly what binaries are going to be used... how to compile or acquired
- What commands each validator must execute, in which order, and how to verify that each command was successfully executed
- How to backup important files (like private keys) and how to revert to the old chain in case of a hard fork failure
- Where and when can all validators coordinate the hard fork (preferably a single location to prevent fragmented coordination)

## Preliminary

Many changes have occurred to the Cosmos SDK and the Gaia application since the latest
major upgrade (`cosmoshub-2`). These changes notably consist of many new features,
protocol changes, and application structural changes that favor developer ergonomics
and application development.

First and foremost, the [Cosmos SDK](https://github.com/cosmos/cosmos-sdk/) and the
[Gaia](https://github.com/cosmos/gaia) application have been split into separate
repositories. This allows for both the Cosmos SDK and Gaia to evolve naturally
and independently. Thus, any future [releases](https://github.com/cosmos/gaia/releases)
of Gaia going forward, including this one, will be built and tagged from this
repository not the Cosmos SDK.

Since the Cosmos SDK and Gaia have now been split into separate repositories, their
versioning will also naturally diverge. In an attempt to decrease community confusion and strive for
semantic versioning, the [Cosmos SDK](https://github.com/cosmos/cosmos-sdk/) will continue
on its current versioning path (i.e. v0.36.x ) and the [Gaia](https://github.com/cosmos/gaia)
application will become v2.0.x.

__[Gaia](https://github.com/cosmos/gaia) application v2.0.3 is
what full node operators will upgrade to and run in this next major upgrade__.

## Major Updates

There are many notable features and changes in the upcoming release of the SDK. Many of these
are discussed at a high level in July's Cosmos development update found
[here](https://blog.cosmos.network/cosmos-development-update-july-2019-8df2ade5ba0a).

Some of the biggest changes to take note on when upgrading as a developer or client are the the following:

- **Tagging/Events**: The entire system of what we used to call tags has been replaced by a more
  robust and flexible system called events. Any client that depended on querying or subscribing to
  tags should take note on the new format as old queries will not work and must be updated. More in
  depth docs on the events system can be found [here](https://github.com/tendermint/tendermint/blob/master/rpc/core/events.go).
  In addition, each module documents its own events in the specs (e.g. [slashing](https://github.com/cosmos/cosmos-sdk/blob/v0.36.0/docs/spec/slashing/06_events.md)).
- **Height Queries**: Both the CLI and REST clients now (re-)enable height queries via the
  `--height` and `?height` arguments respectively. An important note to keep in mind are that height
  queries against pruning nodes will return errors when a pruned height is queried against. When no
  height is provided, the latest height will be used by default keeping current behavior intact. In
  addition, many REST responses now wrap the query results in a new structure `{"height": ..., "result": ...}`.
  That is, the height is now returned to the client for which the resource was queried at.

### 0. How to Rebranding

The [rebranding proposal](https://explorer.cashmaney.com/proposals/7) passed on-chain, and required changes are inlcluded on this hard fork.

The network needs to decide on a block number to fork from.
Since most nodes use `--pruning syncable` configuration, the node prunes most of the blocks, so state should be exported from a height that is a multiple of 100 (e.g. 100, 500, 131400, ...).

### 1. Export `genesis.json` for the new fork:

```bash
sudo systemctl stop enigma-node
enigmad export --for-zero-height --height <agreed_upon_block_height> > exported_state.json
```

### 2. Inside `exported_state.json` Rename `chain_id` from `enigma-1` to the new agreed upon Chain ID

For example:

```bash
perl -i -pe 's/"enigma-1"/"bla-bla"/' exported_state.json
```

### 3. Convert all `enigma` addresses to `secret` adresses

Using the CLI:

```bash
wget https://github.com/enigmampc/bech32.enigma.co/releases/download/cli/bech32-convert
chmod +x bech32-convert

cat exported_state.json | ./bech32-convert > new_genesis.json
```

Or you can just paste `exported_state.json` into https://bech32.enigma.co and paste the result back into `new_genesis.json`.

### 4. Compile the new `secret` binaries with `make deb` (or distribute them precompiled).

### 5. Setup new binaries:

```bash
sudo dpkg -i precompiled_secret_package.deb # install secretd & secretcli and setup secret-node.service

secretcli config chain-id <new_chain_id>
secretcli config output json
secretcli config indent true
secretcli config trust-node true
```

### 6. Setup the new node/validaor:

```bash
# args for secretd init doesn't matter because we're going to import the old config files
secretd init <moniker> --chain-id <new_chain_id>

# import old config files to the new node
cp ~/.enigmad/config/{app.toml,config.toml,addrbook.json} ~/.secretd/config

# import node's & validator's private keys to the new node
cp ~/.enigmad/config/{priv_validator_key.json,node_key.json} ~/.secretd/config

# set new_genesis.json from step 3 as the genesis.json of the new chain
cp new_genesis.json ~/.secretd/config/genesis.json

# at this point you should also validate sha256 checksums of ~/.secretd/config/* against ~/.enigmad/config/*
```

### 7. Start the new Blockchain! :tada:

```bash
sudo systemctl enable secret-node # enable on startup
sudo systemctl start secret-node
```

Once more than 2/3 of voting power comes online you'll start seeing blocks streaming on:

```bash
journalctl -u secret-node -f
```

If something goes wrong the network can relaunch the `enigma-node`, therefore it's not advisable to delete `~/.enigmad` & `~/.enigmacli` until the new chain is live and stable.

### 8. Import wallet keys from the old chain to the new chain:

(Ledger Nano S/X users shouldn't do anything, just use the new CLI with `--ledger --account <number>` as usual)

```bash
enigmacli keys export <key_name>
# this^ outputs stuff to stderr and also exports the key to stderr,
# so copy only the private key output to a file named `key.export`

secretcli import <key_name> key.export
```

### 9. When the new chain is live and everything works well, you can delete the files of the old chain:

- `rm -rf ~/.enigmad`
- `rm -rf ~/.enigmacli`
- `sudo dpkg -r enigma-blockchain`

## Risks

As a validator performing the upgrade procedure on your consensus nodes carries a heightened risk of
double-signing and being slashed. The most important piece of this procedure is verifying your
software version and genesis file hash before starting your validator and signing.

The riskiest thing a validator can do is discover that they made a mistake and repeat the upgrade
procedure again during the network startup. If you discover a mistake in the process, the best thing
to do is wait for the network to start before correcting it. If the network is halted and you have
started with a different genesis file than the expected one, seek advice from a Tendermint developer
before resetting your validator.

## Recovery

Prior to exporting `cosmoshub-2` state, validators are encouraged to take a full data snapshot at the
export height before proceeding. Snapshotting depends heavily on infrastructure, but generally this
can be done by backing up the `.gaiacli` and `.gaiad` directories.

It is critically important to back-up the `.gaiad/data/priv_validator_state.json` file after stopping your gaiad process. This file is updated every block as your validator participates in a consensus rounds. It is a critical file needed to prevent double-signing, in case the upgrade fails and the previous chain needs to be restarted.

In the event that the upgrade does not succeed, validators and operators must downgrade back to
v0.34.6+ of the _Cosmos SDK_ and restore to their latest snapshot before restarting their nodes.

## Upgrade Procedure

__Note__: It is assumed you are currently operating a full-node running v0.34.6+ of the _Cosmos SDK_.

- The version/commit hash of Gaia v2.0.3: `2f6783e298f25ff4e12cb84549777053ab88749a`
- The upgrade height as agreed upon by governance: **2,902,000**
- You may obtain the canonical UTC timestamp of the exported block by any of the following methods:
  - Block explorer (e.g. [Hubble](https://hubble.figment.network/cosmos/chains/cosmoshub-2/blocks/2902000?format=json&kind=block))
  - Through manually querying an RPC node (e.g. `/block?height=2902000`)
  - Through manually querying a Gaia REST client (e.g. `/blocks/2902000`)

1. Verify you are currently running the correct version (v0.34.6+) of the _Cosmos SDK_:

   ```shell
   $ gaiad version --long
   cosmos-sdk: 0.34.6
   git commit: 80234baf91a15dd9a7df8dca38677b66b8d148c1
   vendor hash: f60176672270c09455c01e9d880079ba36130df4f5cd89df58b6701f50b13aad
   build tags: netgo ledger
   go version go1.12.2 linux/amd64
   ```

2. Export existing state from `cosmoshub-2`:

   **NOTE**: It is recommended for validators and operators to take a full data snapshot at the export
   height before proceeding in case the upgrade does not go as planned or if not enough voting power
   comes online in a sufficient and agreed upon amount of time. In such a case, the chain will fallback
   to continue operating `cosmoshub-2`. See [Recovery](#recovery) for details on how to proceed.

   Before exporting state via the following command, the `gaiad` binary must be stopped!

   ```shell
   $ gaiad export --for-zero-height --height=2902000 > cosmoshub_2_genesis_export.json
   ```

3. Verify the SHA256 of the (sorted) exported genesis file:

   ```shell
   $ jq -S -c -M '' cosmoshub_2_genesis_export.json | shasum -a 256
   [PLACEHOLDER]  cosmoshub_2_genesis_export.json
   ```

4. At this point you now have a valid exported genesis state! All further steps now require
v2.0.3 of [Gaia](https://github.com/cosmos/gaia).

   **NOTE**: Go [1.13+](https://golang.org/dl/) is required!

   ```shell
   $ git clone https://github.com/cosmos/gaia.git && cd gaia && git checkout v2.0.3; make install
   ```

5. Verify you are currently running the correct version (v2.0.3) of the _Gaia_:

   ```shell
   $ gaiad version --long
   name: gaia
   server_name: gaiad
   client_name: gaiacli
   version: 2.0.3
   commit: 2f6783e298f25ff4e12cb84549777053ab88749a
   build_tags: netgo,ledger
   go: go version go1.13.3 darwin/amd64
   ```

6. Migrate exported state from the current v0.34.6+ version to the new v2.0.3 version:

   ```shell
   $ gaiad migrate v0.36 cosmoshub_2_genesis_export.json --chain-id=cosmoshub-3 --genesis-time=[PLACEHOLDER]> genesis.json
   ```

   **NOTE**: The `migrate` command takes an input genesis state and migrates it to a targeted version.
   Both v0.36 and v0.37 are compatible as far as state structure is concerned.

   Genesis time should be computed relative to the blocktime of `2,902,000`. The genesis time
   shall be the blocktime of `2,902,000` + `60` minutes with the subseconds truncated.

   An example shell command(tested on OS X Mojave) to compute this values is:

   ```shell
   curl https://stargate.cosmos.network:26657/block\?height\=2902000 | jq -r '.result["block_meta"]["header"]["time"]'|xargs -0 date -v +60M  -j  -f "%Y-%m-%dT%H:%M:%S" +"%Y-%m-%dT%H:%M:%SZ"
   ```

7. Now we must update all parameters that have been agreed upon through governance. There is only a
single parameter, `max_validators`, that we're upgrading based on [proposal 10](https://www.mintscan.io/proposals/10)

   ```shell
   $ cat genesis.json | jq '.app_state["staking"]["params"]["max_validators"]=125' > tmp_genesis.json && mv tmp_genesis.json genesis.json
   ```

8. Verify the SHA256 of the final genesis JSON:

   ```shell
   $ jq -S -c -M '' genesis.json | shasum -a 256
   [PLACEHOLDER]  genesis.json
   ```

9. Reset state:

   **NOTE**: Be sure you have a complete backed up state of your node before proceeding with this step.
   See [Recovery](#recovery) for details on how to proceed.

   ```shell
   $ gaiad unsafe-reset-all
   ```

10. Move the new `genesis.json` to your `.gaiad/config/` directory
11. Replace the `db_backend` on `.gaiad/config/config.toml` to:

    ```toml
    db_backend = "goleveldb"
    ```

12. Note, if you have any application configuration in `gaiad.toml`, that file has now been renamed to `app.toml`:

    ```shell
    $ mv .gaiad/config/gaiad.toml .gaiad/config/app.toml
    ```

## Notes for Service Providers

1. The transition from `enigma` to `secret` causes both the prefix and tail end of the address change due to a checksum change.
2. (change) We highly recommend standing up a [testnet](https://github.com/cosmos/gaia/blob/master/docs/deploy-testnet.md)
   with the `gaia-2.0` release or joining the gaia-13006 testnet. More info for joining the testnet can be
   found in the [riot validator room](https://riot.im/app/#/room/#cosmos-validators:matrix.org).
5. (change) We expect that developers with iOS or Android based apps may have to notify their users of downtime
   and ship an upgrade for cosmoshub-3 compatibility unless they have some kind of switch they can throw
   for the new tx formats. Server side applications should experience briefer service interruptions and
   be able to just spin up new nodes and migrate to the new apis.

### Final Step Listen to Purple Haze.
(This step is *required* for the upgrade to activate.)

<iframe allowFullScreen="allowFullScreen" src="https://www.youtube.com/embed/WGoDaYjdfSg?ecver=1&amp;iv_load_policy=3&amp;yt:stretch=16:9&amp;autohide=1&amp;color=red&amp;width=560&amp;width=560" width="560" height="315" allowtransparency="true" frameborder="0"><script type="text/javascript">function execute_YTvideo(){return youtube.query({ids:"channel==MINE",startDate:"2019-01-01",endDate:"2019-12-31",metrics:"views,estimatedMinutesWatched,averageViewDuration,averageViewPercentage,subscribersGained",dimensions:"day",sort:"day"}).then(function(e){},function(e){console.error("Execute error",e)})}</iframe>

Adapting from the [Cosmos Hub Upgrade Instructions 2](https://raw.githubusercontent.com/cosmos/gaia/master/docs/migration/cosmoshub-2.md) and the [EnigaBlockchain Secret Rebranding Readme](https://github.com/enigmampc/EnigmaBlockchain/tree/secret-rebranding).
# Commands to run on your Enigma Blockchain node

## Check the total supply

```bash
secretcli q supply total
```

## See all validators

```bash
secretcli q staking validators | grep moniker
```

## Check the balance of the community pool
```bash
secretcli q distribution community-pool
```

## Check your validator address.
```bash
secretcli keys show <keyalias> --bech=val -a
```

## Follow node logs to debug (exit with Ctrl-C)
```bash
journalctl -f -u enigma-node
```

## Query account
```bash
secretcli q account $(secretcli keys show -a <key_alias>)
```

## Staking more tokens

(remember 1 SCRT = 1,000,000 uSCRT)

```bash
secretcli tx staking delegate $(secretcli keys show <key-alias> --bech=val -a) <amount>uscrt --from <key-alias>
```

## Renaming your moniker

```bash
secretcli tx staking edit-validator --moniker <new-moniker> --from <key-alias>
```

## Seeing your rewards from being a validator

```bash
secretcli q distribution rewards $(secretcli keys show -a <key-alias>)
```

## Seeing your commissions from your delegators

```bash
secretcli q distribution commission $(secretcli keys show -a <key-alias> --bech=val)
```

## Withdrawing rewards

```bash
secretcli tx distribution withdraw-rewards $(secretcli keys show --bech=val -a <key-alias>) --from <key-alias>
```

## Withdrawing rewards+commissions

```bash
secretcli tx distribution withdraw-rewards $(secretcli keys show --bech=val -a <key-alias>) --from <key-alias> --commission
```

# Extra Commands for Validators Only to Run

#### View proposals in deposit period

```bash
secretcli query gov proposals --status deposit_period
```

#### View proposals in voting period

```bash
secretcli query gov proposals --status voting_period
```

#### Creating a Proposal & depositing 1SCRT (1000SCRT Required for proposal to go into voting process)

```bash
secretcli tx gov submit-proposal --title="Title HERE" --description="The BODY HERE" --type="Text" --deposit="1000000uscrt" --from <keyalias>
```

#### Help & Info on Creating a Proposal

```bash
secretcli tx gov submit-proposal --help
```

#### Send Tokens

```bash
secretcli tx send <sender_key_name_or_address> <recipient_address>
```
  





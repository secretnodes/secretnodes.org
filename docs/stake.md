# Stake

secretnodes.org and the community pool is owned and operated by Secret LLC. We are a community member owned LLC with no external investors.

To stake into the secretnodes.org community pool, all you must do is delegate to our Enigma Validator Address : `secretvaloper1hjd20hjvkx06y8p42xl0uzr3gr3ue3nkvd79jj`.

You can delegate to secretnodes.org by running the following command from a full node.

```bash
secretcli tx staking delegate secretvaloper1hjd20hjvkx06y8p42xl0uzr3gr3ue3nkvd79jj <amountToBond>uscrt --from <delegator-Key-Name>  --gas auto
```

You can redelagate from another validator to secretnodes.org by running the following command from a full node.

```bash
secretcli tx staking redelegate <current-validator-enigmavaloper-address> secretvaloper1hjd20hjvkx06y8p42xl0uzr3gr3ue3nkvd79jj <amount>uscrt --from <delegator-Key-Name> --gas auto
```

You can withdraw your staking rewards by running the following command with the CLI.

```bash
secretcli tx distribution withdraw-all-rewards --from <delegator-Key-Name> --gas auto
```
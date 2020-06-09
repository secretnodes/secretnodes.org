# Stake

secretnodes.org and the community pool is owned and operated by Secret LLC [via secretnodes.org](https://chat.secret.foundation). We are a community member owned LLC with no external investors.

To stake into the secretnodes.org community pool, all you must do is delegate to our Enigma Validator Address : `enigmavaloper1hjd20hjvkx06y8p42xl0uzr3gr3ue3nkm7wj8z`.

You can delegate to secretnodes.org by running the following command from a full node.

```bash
enigmacli tx staking delegate enigmavaloper1hjd20hjvkx06y8p42xl0uzr3gr3ue3nkm7wj8z <amountToBond>uscrt --from <delegator-Key-Name>  --gas auto
```

You can redelagate from another validator to secretnodes.org by running the following command from a full node.

```bash
enigmacli tx staking redelegate <current-validator-enigmavaloper-address> enigmavaloper1hjd20hjvkx06y8p42xl0uzr3gr3ue3nkm7wj8z <amount>uscrt --from <delegator-Key-Name> --gas auto
```

You can withdraw your commission and staking rewards by running the following command with the CLI.

```bash
enigmacli tx distribution withdraw-rewards $(enigmacli keys show --bech=val -a <key>) --from <key> --commission --gas auto
```
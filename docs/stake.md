# Stake

The secretnodes.org community pool is administered by Secret Forerunners, inc [via secretnodes.org](https://t.me/secretnodes). We have privately raised a modest amount of funding to build a staking pool for a small handful of proof-of-stake networks, with a primary focus on enigma.

To stake into the secretnodes.org community pool, all you must do is delegate to our Enigma Validator Address : `enigmavaloper1hjd20hjvkx06y8p42xl0uzr3gr3ue3nkm7wj8z`.

You can delegate to secretnodes.org by running the following command from a full node.

```bash
enigmacli tx staking delegate enigmavaloper1hjd20hjvkx06y8p42xl0uzr3gr3ue3nkm7wj8z <amountToBond>uscrt --from <delegator-Key-Name>
```

You can redelagate from another validator to secretnodes.org by running the following command from a full node.

```bash
enigmacli tx staking redelegate <current-validator-enigmavaloper-address> enigmavaloper1hjd20hjvkx06y8p42xl0uzr3gr3ue3nkm7wj8z <amount>uscrt --from <delegator-Key-Name> --gas auto
```
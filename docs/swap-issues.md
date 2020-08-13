## Swap Issues

We've had known outages during the following times.

1. July 16th 2020 2pm PST - July 17th 2020 3pm PST 
2. July 18th 2020 5pm PST - July 19th 2020 2pm PST
3. Aug 5th 2020 6:30am PST - Aug 6th 2020

Causes and resolutions for outages.

1. Swap software failed on leader machine. When the process was restarted it skipped some swaps. After an audit was conducted we reprocessed the skipped swaps. All swaps from this time are confirmed completed.

2. Swap process failed on leader machine during data center move. When the process was restarted on the replacement machine the nodes endpoint was also down. After discovering the issue the leader machine was reconfigured to avoid the failure point. All swaps from this down time are confirmed completed.

3. It appears that the swap process skipped a swap after a user input an ethereum address instead of a SCRT address for a burn of 10 ENG. Doing this on a burn prevents the swap operator software from understanding where to mint and send SCRT. We've taken down secretswap.io for now until we get a better understanding of how this was done and how to prevent such a mistake by users in the future. - Working on a longer term solution.

Future plans for improvements

1. We will be working to impliment additional safty features to prevent users from inputting an ETH address for the address in the field asking for a SCRT address. This is to protect users from making the mistake of putting in an ETH address instead of a SCRT address, users are still responsible for putting in the correct scrt address.

Implimented improvements

1. Leader node has already been reconfigured to avoid the same issue with the endpoint. (implimented)
2. We will be updating the swap process so it can handle missed swaps in a safe manner without needing human intervention. (implimented)

Important Notes

After the mentioned improvements are put in place, we do not expect further prolonged downtime. It's important to note that all swaps are public and if you use secretswap.io to swap then we will always have the proof of burn on ethereum, which is what we need to ensure it goes though.

If you have any issues with the swap at any time please reach out via [@secretnodes](https://t.me/secretnodes).




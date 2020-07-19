## Swap Issues

We've had known outages during the following times.

1. July 16th 2020 2pm PST - July 17th 2020 3pm PST 
2. July 18th 2020 5pm PST - July 19th 2020 2pm PST

Causes and resolutions for outages.

1. Swap software failed on leader machine. When the process was restarted it skipped some swaps. After an audit was conducted we reprocessed the skipped swaps. All swaps from this time are confirmed completed.

2. Swap process failed on leader machine during data center move. When the process was restarted on the replacement machine the nodes endpoint was also down. After discovering the issue the leader machine was reconfigured to avoid the failure point. All swaps from this down time are confirmed completed.

Future plans for improvements

1. Leader node has already been reconfigured to avoid the same issue with the endpoint.
2. We will be updating the swap process so it can handle missed swaps in a safe manner without needing human intervention.


Important Notes

After the mentioned improvements are put in place, we do not expect further prolonged downtime. It's important to note that all swaps are public and if you use secretswap.io to swap then we will always have the proof of burn on ethereum, which is what we need to ensure it goes though.

If you have any issues with the swap at any time please reach out via [@secretnodes](https://t.me/secretnodes).




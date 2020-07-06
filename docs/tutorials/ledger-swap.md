# Burn ENG for SCRT from your Ledger

Note: This guide is for Ledger Nano S or Ledger Nano X.

## Prerequisites

- This guide assumes you have a verified, genuine Ledger Nano S or X device.
- If you don't, or you using your Ledger device for the first time, you should check Ledger's [Getting Started](https://support.ledger.com/hc/en-us/sections/360001415213-Getting-started) guide.
- We also advise you to check your Ledger's genuineness and upgrade your firmware to the newest one available (`v1.6.0+`).
- Have a machine with [Ledger Live](https://www.ledger.com/ledger-live) installed.
- Have the latest version of our latest binaries installed. You can get it [here](https://github.com/enigmampc/EnigmaBlockchain/releases/tag/v0.0.3).

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

## Get your Ledger SCRT address.

1. Go to Puzzle and select the Node you would like to stake with.

<img src="_media/puzzle-5.png">

2. Now click the "Stake Now" button.

<img src="_media/puzzle-6.png">

3. You will be presented with your "Account Address". This is your SCRT address, save it for later.

Note. If you are stuck on connect, please make sure your ledger has the cosmos app open.

<img src="_media/puzzle-7.png">

4. Navigate to the swap site.

[Official Swap Site secretswap.io](https://secretswap.io)

<img src="_media/secretswap-1.png">

5. Enter your SCRT Address / "Account Address".

<img src="_media/secretswap-2.png">

6. Put an amount of ENG to burn.

<img src="_media/secretswap-3.png">

7. Read the terms of use.

<img src="_media/secretswap-4.png">

8. To proceed you must Accept the terms of use.

<img src="_media/secretswap-5.png">

9. Prepare your ledger for the swap.

First, enable the contract support setting.

* Connect your Nano S or your Nano X.
* Open the Ethereum app on the device itself by pressing both buttons.
* Enable the "Contract support" setting.

Before proceeding, ensure you have the following.

* Your metamask connected to the ledger account that has your ENG balance.
* The address you have ENG in also has a few dollars worth of ETH for gas.
* You have the ledger app open.

If you need assistance connecting your ledger to your metamask, [please follow this guide.](https://metamask.zendesk.com/hc/en-us/articles/360020394612-How-to-connect-a-Trezor-or-Ledger-Hardware-Wallet)

10. Authorize secretswap.io

Approve the authorization tx in the metamask prompt.

<img src="_media/secretswap-6.png">

11. Approve tx on ledger.

Now metamask will wait for you to approve the tx on your ledger.

<img src="_media/secretswap-7.png">

12. Wait for approval transaction to finalize.

You should be presented with an alert that says "Broadcasting 'Approve ENG transfer'".

Note : If this process takes a long time it's because the transaction is taking time to finalize on the ethereum network. You can check the progress in your metamask extension.

<img src="_media/secretswap-8.png">

13. Authorize Burn transaction.

Approve the burn tx in the metamask prompt.

<img src="_media/secretswap-6.png">

14. Approve burn on ledger.

Now metamask will wait for you to approve the tx on your ledger.

<img src="_media/secretswap-7.png">

15. Wait for Burn transaction to finalize.

You should be presented with an alert that says "Broadcasting 'Burn' transaction."

Note : If this process takes a long time it's because the transaction is taking time to finalize on the ethereum network. You can check the progress in your metamask extension.

<img src="_media/secretswap-10.png">

16. Finished Burn.

Shortly after the burn transaction finalizes on the ethereum network, you will be presented with a message that says "ENG Burn confirmed" On secretswap.io

<img src="_media/secretswap-11.png">

## Now Stake!

If you'd like to stake, here is how you can with Puzzle!

1. Go to Puzzle and select the Node you would like to stake with.

Notes when selecting a node
* Uptime History
* Voting History
* Network Decentralization. *It's important all the stake doesn't flow to a single node!*

If you don't want to stake with secretnodes.org but would like a reccomendation, we reccomend staking with "Quiet Monkey Mind".

<img src="_media/puzzle-5.png">

2. Now click the "Stake Now" button.

<img src="_media/puzzle-6.png">

3. Enter amount to stake.

Notes
* Please leave 1 SCRT in your wallet for transaction fees.

<img src="_media/secretswap-13.png">

4. Sign in with Ledger.

Approve the transaction to stake on your ledger.

Notes
* Be sure to have the Cosmos app open on your ledger.

<img src="_media/secretswap-14.png">

5. Success!

<img src="_media/secretswap-15.png">

6. View Transaction

Once you have successfully approved the transaction you should be able to see it on the Puzzle Explorer.

<img src="_media/secretswap-16.png">

## Feedback

Please let us know any improvements or suggestions you have for the walkthrough, as well as any issues you run into. [Secret Nodes Telegram](https://t.me/secretnodes) or join us in our core community at [SCRT Chat](https://chat.scrt.network)


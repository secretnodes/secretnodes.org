# Tips and Troubleshooting for Secret Nodes

This is a resource for known issues with configuring Secret Nodes, gathered from our community.

# How to update your Secret Node

To update your Secret Node, merely log into your node and run these commands.

> Note: If you used any of our guides to setup your node prior to Dec 23rd, 2019 then you can update your scripts by doing the following.

1.
```bash
wget -N https://raw.githubusercontent.com/secretnodes/scripts/master/upgrade.sh
```

2.
```bash
bash upgrade.sh
```

# SGX Troubleshooting

Here are some things to try if you're running into issues after installing SGX.

1. Verify that "Secure Boot" is disabled in your bios.
2. Verify that "Safe Boot" is disabled in your bios.

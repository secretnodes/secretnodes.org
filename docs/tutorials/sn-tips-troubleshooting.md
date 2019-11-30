# Tips and Troubleshooting for Secret Nodes

This is a resource for known issues with configuring Secret Nodes, gathered from our community.

# How to update your Secret Node

To update your Secret Node, merely log into your node and run these commands.

> Note: If you used any of our guides to setup your node on or after Oct 18, 2019 then your node will automatically update when you run start.sh

1.
```bash
cd discovery-docker-network
```

2.
```bash
docker-compose pull
```

# SGX Troubleshooting

Here are some things to try if you're running into issues after installing SGX.

1. Verify that "Secure Boot" is disabled in your bios.
2. Verify that "Safe Boot" is disabled in your bios.

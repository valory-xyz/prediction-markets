# Prediction Markets

This is a demo that allows running the [market creator](https://github.com/valory-xyz/market-creator) 
and the [trader](https://github.com/valory-xyz/trader) via a simple script. 

To get started, 
the user must [mint the services on-chain](https://docs.autonolas.network/protocol/mint_packages_nfts/#mint-a-service) 
and populate three `.env` files as follows:
1. .creator.env: this environment file should contain the variables for the market creator service
2. .trader.env: this environment file should contain the variables for the trader service
3. .demo.env: this environment file should contain the variables for the demo

In order to run the demo, simply run:
```shell
./demo.sh
```

Two folders will be generated, one for each agent. Among other contents, the logs are accessible within the folders.

# System requirements:

  - Python `== 3.10`
  - [Pipenv](https://pipenv.pypa.io/en/latest/installation/) `>=2021.x.xx`

The script automatically installs tendermint v0.34.19 if it does not exist

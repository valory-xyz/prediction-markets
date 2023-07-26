# Prediction Markets

This is a demo that allows running the [market creator](https://github.com/valory-xyz/market-creator)
and the [trader](https://github.com/valory-xyz/trader) via a simple script. 

To get started, the user must [mint the services on-chain](https://docs.autonolas.network/protocol/mint_packages_nfts/#mint-a-service) 
and populate three `.env` files as follows:
1. .creator.env: this environment file should contain the variables for the market creator service
2. .trader.env: this environment file should contain the variables for the trader service
3. .demo.env: this environment file should contain the variables for the demo

# System requirements

  - Python `== 3.10`
  - [Pipenv](https://pipenv.pypa.io/en/latest/installation/) `>=2021.x.xx`

The script automatically installs tendermint `v0.34.19` if it does not exist

# Instructions

Two Gnosis addresses, and corresponding secret keys are needed:

* One Gnosis address is associated with the trader agent (and you need to replace the field `YOUR_AGENT_ADDRESS` in the file .trader.env with that key). The corresponding private key needs to be set as the value of the env variable `CREATOR_P_KEY` in the file .demo.env

* Another Gnosis address is associated with the market creator agent (and you need to replace the field `YOUR_AGENT_ADDRESS` in the file .market.env with that key). The corresponding private key needs to be set as the value of the env variable `TRADER_P_KEY` in the file .demo.env

Other variables that need to be filled in are:

* `OPENAI_API_KEY` and `ETHEREUM_LEDGER_RPC` in .creator.env
* `OMEN_CREATORS` and `RPC_0` in .demo.env

Finally, the trader agent runs as part of an autonomous service, which is represented on-chain in the Autonolas protocol by a Safe multisig, corresponding to the variable `SAFE_CONTRACT_ADDRESS` in the file .trader.env. Follow the following steps to compute the Safe address corresponding to your agent address:

* Visit https://registry.olas.network/services/mint and connect to Gnosis network
* In the field "Owner address" input a Gnosis address for which you will be able to sign later using e.g. Metamask
* Click on "Generate Hash & File" enter the value `bafybeicgjqgkf2wv54rows3lw4qxnaqnxannumuonh6vahb3ldlzu7cyhi`
* In the field "Canonical agent Ids" enter the number `12`
* In the field "No. of slots to canonical agent Ids" enter the number `1`
* In the field "Cost of agent instance bond (wei)" enter the number `10000000000000000`
* In the field "Threshold" enter the number `1`
* Click "Submit"

As the final step to run the demo, simply run:
```shell
./demo.sh
```

Two folders will be generated, one for each agent. Among other contents, the logs are accessible within the folders.

# Demo video

A [demo video](https) is available.
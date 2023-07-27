# Prediction Markets

This is a demo that allows a user to run a [market creator](https://github.com/valory-xyz/market-creator) agent
and a [trader](https://github.com/valory-xyz/trader) agent via a script. 

To get started, the user must [mint the services on-chain](https://docs.autonolas.network/protocol/mint_packages_nfts/#mint-a-service) 
and populate three `.env` files as follows:
1. `.creator.env`: this environment file should contain the variables for the market creator service
2. `.trader.env`: this environment file should contain the variables for the trader service
3. `.demo.env`: this environment file should contain the variables for the demo

# System requirements

  - Python `== 3.10`
  - [Pipenv](https://pipenv.pypa.io/en/latest/installation/) `>=2021.x.xx`
  - Tendermint `==v0.34.19`

The script automatically installs Tendermint `v0.34.19` if it is not present in your system.

# Instructions

Two Gnosis addresses, and corresponding secret keys, are recommended to be created for this demo:

* Gnosis address #1 is associated with the **trader agent** (and you need to replace the field `YOUR_AGENT_ADDRESS` in the file `.trader.env` with that address). The corresponding private key needs to be set as the value of the env variable `TRADER_P_KEY` in the file .demo.env

* Another Gnosis address #2 is associated with the **market creator agent** (and you need to replace the field `YOUR_AGENT_ADDRESS` in the file `.market.env` with that address). The corresponding private key needs to be set as the value of the env variable `CREATOR_P_KEY` in the file `.demo.env`

Other variables that need to be filled in with your own values are:

* `OPENAI_API_KEY` and `ETHEREUM_LEDGER_RPC` in the file `.creator.env`
* `OMEN_CREATORS` and `RPC_0` in the file `.trader.env`

Finally, the trader agent runs as part of a **trader service**, which is an [autonomous service](https://docs.autonolas.network/open-autonomy/get_started/what_is_an_agent_service/) that is represented on-chain in the Autonolas protocol by a Safe multisig, corresponding to the variable `SAFE_CONTRACT_ADDRESS` in the file `.trader.env`. Follow the next steps to compute the **Safe address** corresponding to your agent address:

* Visit https://registry.olas.network/services/mint and connect to the Gnosis network. For this demo we recommend connecting using a wallet with a Gnosis EOA account that you own.
* In the field *"Owner address"* input a Gnosis address for which you will be able to sign later using a supported wallet. If you want to use the address you're connected to click on *"Prefill Address"*.
* Click on *"Generate Hash & File"* and enter the value `bafybeicgjqgkf2wv54rows3lw4qxnaqnxannumuonh6vahb3ldlzu7cyhi`
* In the field *"Canonical agent Ids"* enter the number `12`
* In the field *"No. of slots to canonical agent Ids"* enter the number `1`
* In the field *"Cost of agent instance bond (wei)"* enter the number `10000000000000000`
* In the field *"Threshold"* enter the number `1`
* Click on *"Submit"*.
* After completing the minting process you will be able to retrieve the value for the variable `SAFE_CONTRACT_ADDRESS` from the field 
*"Safe contract address"* as shown in an example below

<img src="/img/safe_address_screenshot.png" alt="Safe address field]" width="500"/>

Finally run the demo script:
```shell
./demo.sh
```

Two folders will be generated, one for each agent. Among other contents, the logs are accessible within the folders.

# Demo video

A [demo video](./img/demo_predicition_markets.mp4) is available.

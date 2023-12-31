# Prediction Markets

This is a demo that allows a user to run a [market creator](https://github.com/valory-xyz/market-creator) service
and a [trader](https://github.com/valory-xyz/trader) service via a script. 

To get started, the user must [mint the services on-chain](https://docs.autonolas.network/protocol/mint_packages_nfts/#mint-a-service) 
and populate two `.env` files as follows:
1. `.creator.env`: this environment file should contain the variables for the market creator service
2. `.trader.env`: this environment file should contain the variables for the trader service

# System requirements

  - Python `== 3.10`
  - [Pipenv](https://pipenv.pypa.io/en/latest/installation/) `>=2021.x.xx`
  - Tendermint `==v0.34.19`

The script automatically installs Tendermint `v0.34.19` if it is not present in your system.

# Instructions

Two Gnosis addresses, and corresponding secret keys, are recommended to be created for this demo:

* Gnosis address #1 is associated with the **trader agent**, and you need to associate the `TRADER_AGENT_ADDRESS` env variable in the file `.trader.env` with that address. The corresponding private key needs to be set as the value of the env variable `TRADER_P_KEY` in the same file

* Another Gnosis address #2 is associated with the **market creator agent**, and you need to associate the `CREATOR_AGENT_ADDRESS` env variable in the file `.creator.env` with that address). The corresponding private key needs to be set as the value of the env variable `CREATOR_P_KEY` in the same file

Other variables that need to be filled in with your own values are:

* `OPENAI_API_KEY` and `RPC` in the file `.creator.env`
* `OMEN_CREATORS` and `RPC` in the file `.trader.env`

Finally, the agents run as part of [autonomous services](https://docs.autonolas.network/open-autonomy/get_started/what_is_an_agent_service/) 
that are represented on-chain in the Autonolas protocol by Safe multisigs, 
corresponding to the variables `SAFE_CONTRACT_ADDRESS` in the files `.trader.env` and `.creator.env`. 
For both of the services, follow the next steps to compute the **Safe address** corresponding to your agent addresses:

* Visit https://registry.olas.network/services/mint and connect to the Gnosis network. For this demo, we recommend connecting using a wallet with a Gnosis EOA account that you own.
* In the field *"Owner address"* input a Gnosis address for which you will be able to sign later using a supported wallet. If you want to use the address you're connected to click on *"Prefill Address"*.
* Click on *"Generate Hash & File"* and enter the value `bafybeicgjqgkf2wv54rows3lw4qxnaqnxannumuonh6vahb3ldlzu7cyhi`
* In the field *"Canonical agent Ids"* enter the number `12`
* In the field *"No. of slots to canonical agent Ids"* enter the number `1`
* In the field *"Cost of agent instance bond (wei)"* enter the number `10000000000000000`
* In the field *"Threshold"* enter the number `1`
* Press the *"Submit"* button. Your wallet will ask you to approve the transaction. Once the transaction is settled, you should see a message indicating that the service NFT has been minted successfully. You should also see that the service is in _Pre-Registration_ state.
- Next, you can navigate to https://registry.olas.network/services#my-services, select your service and go through the steps:
  1. Activate registration
  2. Register agents: here, you must use the value that you set previously for `TRADER_AGENT_ADDRESS`.
  3. This is the last step. A transaction for the safe's deployment is already prepared and needs to be executed.
- After completing the process you will be able to retrieve the value for the variable `SAFE_CONTRACT_ADDRESS` from the field *"Safe contract address"* as shown in an example below

<img src="/img/safe_address_screenshot.png" alt="Safe address field]" width="500"/>

Finally, run the demo script:
```shell
./demo.sh
```

Two folders will be generated, one for each service. Among other contents, the logs are accessible within the folders.
For example, `creator_service/abci_build/persistent_data/logs` contains the creator service's logs.

Keep in ming that the script runs some docker containers in the background. 
In order to stop all the containers, please run on a separate terminal:
```shell
docker rm -f -v marketmaker_abci_0 marketmaker_tm_0 trader_abci_0 trader_tm_0
```

When you run the script for a second time, it reuses the existing build, recreating the previous state. 
In case you want to re-create your build, then before running the script execute:
```shell
sudo rm -rf creator_service/abci_build && sudo rm -rf trader_service/abci_build
```

# Demo video

A [demo video](./img/demo_predicition_markets.mp4) is available.

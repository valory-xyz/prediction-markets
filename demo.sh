#!/bin/bash

set -e

command -v pipenv >/dev/null 2>&1 ||
{ echo >&2 "Pipenv is not installed!";
  exit 1
}

command -v docker >/dev/null 2>&1 ||
{ echo >&2 "Docker is not installed!";
  exit 1
}

command -v docker-compose >/dev/null 2>&1 ||
{ echo >&2 "docker-compose is not available!";
  exit 1
}

# setup
pipenv install
pipenv run autonomy init --remote --ipfs --reset --author=prediction_markets_demo

# Load demo env vars
export $(grep -v '^#' .demo.env | xargs)
# Load market creator env vars
set -o allexport && source .creator.env && set +o allexport

# Re-assign confusing overrides
export $ETHEREUM_LEDGER_RPC=$RPC
export $ETHEREUM_LEDGER_CHAIN_ID=$CHAIN_ID

# Run the market creator service
directory="creator_service"
if [ -d $directory ]
then
    echo "Detected an existing service in $directory. Using this one..."
else
    echo "Fetching the market creator service..."
    poetry run autonomy fetch --service valory/market_maker:$service_version --alias $directory
fi

cd $directory

directory="abci_build"
if [ -d $directory ]
then
    echo "Detected an existing build in the current folder. Using this one..."
else
    echo "Building the market creator service..."
    # Build the image
    poetry run autonomy build-image
    cat > keys.json << EOF
[
  {
    "address": "$AGENT_ADDRESS",
    "private_key": "$private_key"
  }
]
EOF
    # Build the deployment with a single agent
    poetry run autonomy deploy build --n 1 -ltm
fi

# Run the deployment
poetry run autonomy deploy run --build-dir abci_build/ &

cd ..

# Load trader env vars
set -o allexport && source .trader.env && set +o allexport

# Run the trader service
directory="trader_service"
if [ -d $directory ]
then
    echo "Detected an existing service in $directory. Using this one..."
else
    echo "Fetching the trader service..."
    poetry run autonomy fetch --service valory/trader:$service_version --alias $directory
fi

cd $directory

directory="abci_build"
if [ -d $directory ]
then
    echo "Detected an existing build in the current folder. Using this one..."
else
    echo "Building the trader service..."
    # Build the image
    poetry run autonomy build-image
    cat > keys.json << EOF
[
  {
    "address": "$AGENT_ADDRESS",
    "private_key": "$private_key"
  }
]
EOF
    # Build the deployment with a single agent
    poetry run autonomy deploy build --n 1 -ltm
fi

# Run the deployment
poetry run autonomy deploy run --build-dir abci_build/ &

#!/bin/bash

echo "Please select an option:"
echo "1. Install environment and run node"
echo "2. View current logs"
read -p "Enter your choice (1 or 2): " option

case $option in
1)
  # Check and install Node.js and npm
  if ! command -v npm >/dev/null 2>&1; then
    echo "Node.js is not installed, installing..."
    # sudo apt update
    sudo apt install -y nodejs npm
  else
    echo "Node.js is already installed."
  fi

  # Check and install pm2
  if ! command -v pm2 >/dev/null 2>&1; then
    echo "Installing pm2..."
    sudo npm i -g pm2
  else
    echo "pm2 is already installed."
  fi

  echo "Creating directory and entering it..."
  mkdir -p repos/pl && cd repos/pl
  echo "Downloading and setting up the node execution file..."
  wget -O aleo-pool-prover https://github.com/zkrush/aleo-pool-client/releases/download/v1.5-testnet-beta/aleo-pool-prover && chmod +x aleo-pool-prover
  read -p "Please enter the node name: " node_name
  echo "Starting the node..."
  pm2 start ./aleo-pool-prover --name "aleo-pool-prover" -- --pool wss://aleo.zkrush.com:3333 --account $node_name --worker-name $node_name
  ;;
2)
  echo "Viewing logs..."
  pm2 logs aleo-pool-prover
  ;;
*)
  echo "Invalid option, please rerun the script and select the correct option."
  exit 1
  ;;
esac

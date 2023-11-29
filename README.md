# CropSupplyChain Smart Contract

## Overview

The CropSupplyChain smart contract manages the supply chain of crops on the Ethereum blockchain, ensuring transparency and traceability. It allows farmers to harvest crops, distributors to distribute them, and consumers to consume the distributed crops.

## Features

- **Harvesting Crops:** Farmers can use the contract to harvest new crops, providing a unique name for each crop.

- **Distributing Crops:** Distributors can distribute harvested crops to consumers, ensuring that the distributor is different from the farmer and consumer.

- **Consuming Crops:** Consumers can consume crops that have been distributed, ensuring that the consumer is different from the farmer and distributor.

## Smart Contract Structure

The smart contract consists of the following main components:

- **Struct:** Defines the data structure representing an individual crop.

- **Mapping:** Stores information about all crops using a unique identifier.

- **Events:** Logs key actions such as harvesting, distribution, and consumption.

- **Functions:**
  - `harvestCrop`: Allows farmers to harvest a new crop.
  - `distributeCrop`: Allows distributors to distribute a harvested crop.
  - `consumeCrop`: Allows consumers to consume a distributed crop.

## Usage

To interact with the CropSupplyChain contract:

1. **Harvest a Crop:**
   - Call the `harvestCrop` function, providing a non-empty name for the crop.

2. **Distribute a Crop:**
   - Call the `distributeCrop` function, specifying the crop ID and distributor's address.

3. **Consume a Crop:**
   - Call the `consumeCrop` function, specifying the crop ID and consumer's address.

## Development

To develop and deploy the smart contract locally:

1. **Compile:**
   - Compile the smart contract using the Solidity compiler.
     [REMIX IDE](https://remix.ethereum.org)

2. **Deploy:**
   - Deploy the smart contract to a local Ethereum network or a testnet.

3. **Interact:**
   - Interact with the deployed contract using your preferred Ethereum wallet or through scripts.

## Contributing

Contributions are welcome! Feel free to open issues and pull requests.

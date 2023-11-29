// SPDX-License-Identifier: MIT

/*
 * Smart contract definition
 */
pragma solidity >=0.8.0 <0.9.0;

contract CropSupplyChain {
    /*
     * Data structure representing an individual crop
     */
    struct Crop {
        uint256 id;               // Unique identifier for the crop
        string name;              // Name of the crop
        address farmer;           // Address of the farmer who harvested the crop
        address distributor;      // Address of the distributor handling the crop
        address consumer;         // Address of the consumer who consumed the crop
        bool isHarvested;         // Flag indicating if the crop has been harvested
        bool isDistributed;       // Flag indicating if the crop has been distributed
        bool isConsumed;          // Flag indicating if the crop has been consumed
    }

    // Mapping to store information about all crops
    mapping(uint256 => Crop) public crops;

    // Variable to keep track of the total number of crops
    uint256 public cropCount;

    // Event to log the harvesting of a crop
    event Harvested(uint256 cropId, address indexed farmer);

    // Event to log the distribution of a crop
    event Distributed(uint256 cropId, address indexed distributor);

    // Event to log the consumption of a crop
    event Consumed(uint256 cropId, address indexed consumer);

    /*
     * Function to harvest a new crop
     * @param _name Name of the crop
     */
    function harvestCrop(string memory _name) public {
        // Input validation: Ensure that the crop name is not empty
        require(bytes(_name).length > 0, "Crop name cannot be empty");

        // Increment cropCount to generate a unique ID
        cropCount++;

        // Create a new Crop instance and store it in the mapping
        crops[cropCount] = Crop(
            cropCount,
            _name,
            msg.sender, // Address of the farmer
            address(0), // Initial distributor address
            address(0), // Initial consumer address
            true,      // Set isHarvested to true
            false,     // Set isDistributed to false
            false      // Set isConsumed to false
        );

        // Emit Harvested event to log the action
        emit Harvested(cropCount, msg.sender);
    }

    /*
     * Function to distribute a harvested crop
     * @param _cropId ID of the crop to be distributed
     * @param _distributor Address of the distributor
     */
    function distributeCrop(uint256 _cropId, address _distributor) public {

        // Retrieve the crop using the provided crop ID
        Crop storage crop = crops[_cropId];

        // Input validation: Ensure the distributor address is not zero
        require(_distributor != address(0), "Invalid distributor address");

        // Check if the crop is available for distribution
        require(crop.isHarvested && !crop.isDistributed, "Crop not available for distribution");

        // Input validation: Ensure the distributor is not the same as the farmer
        require(_distributor != crop.farmer, "Distributor cannot be the same as the farmer");

        // Input validation: Ensure the distributor is not the same as the consumer
        require(_distributor != crop.consumer, "Distributor cannot be the same as the consumer");

        // Set the distributor's address and update the distribution status
        crop.distributor = _distributor;
        crop.isDistributed = true;

        // Emit Distributed event to log the action
        emit Distributed(_cropId, _distributor);
    }

    /*
     * Function to consume a distributed crop
     * @param _cropId ID of the crop to be consumed
     * @param _consumer Address of the consumer
     */
    function consumeCrop(uint256 _cropId, address _consumer) public {
        // Retrieve the crop using the provided crop ID
        Crop storage crop = crops[_cropId];

        // Input validation: Ensure the consumer address is not zero
        require(_consumer != address(0), "Invalid consumer address");

        // Check if the crop is available for consumption
        require(crop.isHarvested && crop.isDistributed && !crop.isConsumed, "Crop not available for consumption");

        // Input validation: Ensure the consumer is not the same as the farmer
        require(_consumer != crop.farmer, "Consumer cannot be the same as the farmer");

        // Input validation: Ensure the consumer is not the same as the distributor
        require(_consumer != crop.distributor, "Consumer cannot be the same as the distributor");

        // Set the consumer's address and update the consumption status
        crop.consumer = _consumer;
        crop.isConsumed = true;

        // Emit Consumed event to log the action
        emit Consumed(_cropId, _consumer);
    }
}

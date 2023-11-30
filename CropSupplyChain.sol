// Specify Solidity compiler version
pragma solidity >=0.8.0 <0.9.0;

// Smart contract definition
contract CropSupplyChain {
    // Data structure representing an individual crop
    struct Crop {
        uint256 id;
        string name;
        address farmer;
        address distributor;
        address consumer;
        bool isHarvested;
        bool isDistributed;
        bool isConsumed;
    }

    // Mapping to store information about all crops
    mapping(uint256 => Crop) public crops;

    // Variable to keep track of the total number of crops
    uint256 public cropCount;

    // Event to log the harvesting of a crop
    event CropHarvested(uint256 cropId, address indexed farmer);

    // Event to log the distribution of a crop
    event CropDistributed(uint256 cropId, address indexed distributor);

    // Event to log the consumption of a crop
    event CropConsumed(uint256 cropId, address indexed consumer);

    // Modifier to restrict functions to authorized users
    modifier onlyFarmer() {
        require(msg.sender == crops[cropCount].farmer, "Only the farmer can call this function");
        _;
    }

    modifier onlyDistributor() {
        require(msg.sender == crops[cropCount].distributor, "Only the distributor can call this function");
        _;
    }

    modifier onlyConsumer() {
        require(msg.sender == crops[cropCount].consumer, "Only the consumer can call this function");
        _;
    }

    // Function to harvest a new crop
    function harvestCrop(string memory _name) public {
        // Add input validation
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
        // Emit CropHarvested event to log the action
        emit CropHarvested(cropCount, msg.sender);
    }

    // Function to distribute a harvested crop
    function distributeCrop(uint256 _cropId, address _distributor) public onlyFarmer {
        // Retrieve the crop using the provided crop ID
        Crop storage crop = crops[_cropId];
        // Require distributor approval
        require(crop.isHarvested && !crop.isDistributed, "Crop not available for distribution");
        // Set the distributor's address and update the distribution status
        crop.distributor = _distributor;
        crop.isDistributed = true;
        // Emit CropDistributed event to log the action
        emit CropDistributed(_cropId, _distributor);
    }

    // Function to consume a distributed crop
    function consumeCrop(uint256 _cropId) public onlyDistributor {
        // Retrieve the crop using the provided crop ID
        Crop storage crop = crops[_cropId];
        // Require consumer approval
        require(crop.isHarvested && crop.isDistributed && !crop.isConsumed, "Crop not available for consumption");
        // Set the consumer's address and update the consumption status
        crop.consumer = msg.sender;
        crop.isConsumed = true;
        // Emit CropConsumed event to log the action
        emit CropConsumed(_cropId, msg.sender);
    }
}

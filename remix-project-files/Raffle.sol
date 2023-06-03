//Begin

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";

contract Raffle is VRFConsumerBaseV2, ConfirmedOwner {

    //VRF
    event RequestSent(uint256 requestId, uint32 numWords);
    event RequestFulfilled(uint256 requestId, uint256[] randomWords);

    struct RequestStatus {
        bool fulfilled; // whether the request has been successfully fulfilled
        bool exists; // whether a requestId exists
        uint256[] randomWords;
    }
    mapping(uint256 => RequestStatus) public s_requests; /* requestId --> requestStatus */  

    // Mumbai coordinator
    VRFCoordinatorV2Interface COORDINATOR;
    address vrfCoordinator = 0x7a1BaC17Ccc5b313516C5E16fb24f7659aA5ebed;
    bytes32 keyHash = 0x4b09e658ed251bcafeebbc69400383d49f344ace09b9576fe248bb02c003fe9f;
    uint32 callbackGasLimit = 2500000;
    uint16 requestConfirmations = 3;
    uint32 numWords =  3;

    // past requests Ids.
    uint256[] public requestIds;
    uint256 public lastRequestId;
    uint256[] public lastRandomWords;

    // Your subscription ID.
    uint64 public s_subscriptionId;

    uint256 public maximum;
    uint256[] public raffleResult;    
    mapping (uint => bool) public selected;

    constructor(uint64 subscriptionId)
        VRFConsumerBaseV2(vrfCoordinator)
        ConfirmedOwner(msg.sender)
    {
        COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
        s_subscriptionId = subscriptionId;
    }

    function listNumbers() public view returns (uint256[] memory) {
        return raffleResult;
    }

    function execute(uint32 quant, uint max) public returns (uint256 requestId) {
        // Will revert if subscription is not set and funded.
        require (quant > 0 && quant < 10, "quantity of numbers must be between 1 and 10");
        numWords = quant;
        maximum = max;
        requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
        s_requests[requestId] = RequestStatus({
            randomWords: new uint256[](0),
            exists: true,
            fulfilled: false
        });
        requestIds.push(requestId);
        lastRequestId = requestId;
        emit RequestSent(requestId, numWords);
        return requestId;      
    }
 
    function fulfillRandomWords(uint256 _requestId, uint256[] memory _randomWords) internal override {
        require(s_requests[_requestId].exists, "request not found");
        s_requests[_requestId].fulfilled = true;
        s_requests[_requestId].randomWords = _randomWords;
        lastRandomWords = _randomWords;

        uint aux;
        for (uint i = 0; i < numWords; i++) {
            aux = _randomWords[i] % maximum + 1;
            if (!selected[aux]) {
                raffleResult.push(aux);
            }            
        }
    }

}


//End

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract MessangerExample {

    string public messgae;

    address public owner;

    uint public messageUpdateCounter;

    constructor () {
        owner = msg.sender;
    }

    function updateMessage(string memory _newMessage) public {
        if(msg.sender == owner) {
            messageUpdateCounter++;
            messgae = _newMessage;
        }
    }

}
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract ExampleConstructor {

    address public myAddress;

    constructor (address _newAddress) {
        myAddress = _newAddress;
    }

    function setAddress(address _someAddress) public {
        myAddress = _someAddress;
    }

    function setSenderAddress() public {
        myAddress = msg.sender;
    }


}
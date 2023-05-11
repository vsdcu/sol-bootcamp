// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract DeployOnMumbaiTestBlockChain {

    string public testString = "Hello World";

    // contract to update the string value on blockchain
    function updateString(string memory _newString) public {
        testString = _newString;
    }

}
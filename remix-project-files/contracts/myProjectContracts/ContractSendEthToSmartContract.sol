// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract sendEthToContract {

    string public myString = "my string";

    function updateStringWithEther(string memory _newString) public payable {

        if(msg.value == 1 ether) {
            myString = _newString;
        } else {
            //sending back the unused ether to sender
            payable(msg.sender).transfer(msg.value);
        }

    }

}
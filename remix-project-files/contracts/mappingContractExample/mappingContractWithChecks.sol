// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract mappingContractWithChecks {

    // data structure to keep mapping of balance for all the users separately
    mapping(address => uint) public balanceReceived;

    // add money to each user's account
    function sendMoney() public payable {
        balanceReceived[msg.sender] += msg.value;        
    }

    // return full balance of smart contract
    function getTotalBalanace() public view returns(uint) {
        return address(this).balance;
    }

    // returns only user balance
    function getMyBalance() public view returns(uint) {
        return balanceReceived[msg.sender];    
    }


    // returns only amount that has been submitted by the user, not all of the balance present in smart contract
    // smart contract can be used by many users at the same time.

    // this implementation is important to secure against callback functions (double spending)
    // we make sure that we mark the balance of that user 0 first before transfering the money. (L33-34)
    function withdrawAllToAddress(address payable _to) public {
        uint balanceToSendOut = balanceReceived[msg.sender];
        balanceReceived[msg.sender] = 0;
        _to.transfer(balanceToSendOut);
    }

}
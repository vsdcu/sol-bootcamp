// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;


contract Sender {

    receive() external payable {
        // doing nothing, just here for receiving funds as a fallback method
    }

    function withdrawTransfer(address payable _to) public {
        _to.transfer(10); // transfer 10 wei to the given address
    }

    function withdrawSend(address payable _to) public {
        bool sentSuccessful = _to.send(10);  // send will return the boolean outcome for the payment action;
                                            // transfer do not return anything, but fails the transaction and revert it automatically.

        require(sentSuccessful, "Sending funds failed!"); // it is always recommended to check the return bool for send method to verify the 
                                                         // transfer, it doesn't revert or error the transation as transfer does.

    }

    function getBalanace() public view returns (uint) {
        return address(this).balance;  // just to check the balance in contract
    }

}


contract ReceiverNoAction {
    receive() external payable {
        // do nothing, just here for receiinh funds
    }

    function getBalanace() public view returns (uint) {
        return address(this).balance;  // just to check the balance in contract
    }

}


contract ReceiverAction {
    
    uint public balance;
    receive() external payable {
        balance += msg.value;   // this contract is trying to write the balance on blockchain which needs more than 2300 gas, 
                                // hence will fail for both ways. i.e. transfer and send
    }

    function getBalanace() public view returns (uint) {
        return address(this).balance;  // just to check the balance in contract
    }

}
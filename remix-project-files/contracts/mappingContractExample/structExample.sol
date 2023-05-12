// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract PaymentReceived {

    struct PaymentStructType {
        address from;
        uint amount ;
    }

    PaymentStructType public payment;

    function payContract() public payable {
        
        // using struct constructor
        //payment = PaymentStructType(msg.sender, msg.value);
    
        // another way
        payment.from = msg.sender;
        payment.amount = msg.value;
    }


}
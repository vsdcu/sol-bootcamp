// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

// sub-contract (child contract) to hold the payment attributes

contract PaymentReceived {

    address public from;
    uint public amount;

    constructor(address _from, uint _amount) {
        from = _from;
        amount = _amount;
    }

}


// main smart contrcat, it will deploy the child contract also automatically.
contract Wallet {

    PaymentReceived public payment;

    function payContract() public payable {
        payment = new PaymentReceived(msg.sender, msg.value);
    }

}
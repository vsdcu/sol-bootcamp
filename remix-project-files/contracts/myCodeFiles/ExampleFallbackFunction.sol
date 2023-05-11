// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract ExampleFallbackFunction {

    uint public lastValue;

    string public functionCalled;

    // receive function is needed if ether needs to be send to contract;
    // but there should not be any call data in this case.

    // if you intend to send a call data; fallback function would be needed
    // gas limit is 2300 wei for fallback and receive functions. (gas stipened)

    receive() external payable {
        lastValue = msg.value;
        functionCalled = "receive";
    }

    fallback() external payable {
        lastValue = msg.value;
        functionCalled = "fallback";
    }

}
// SPDX-License-Identifier: MIT

pragma solidity 0.7.0;

contract ExampleExceptionRequire {

    mapping(address => uint8) public addressBalance;

    function addMoney() public payable {
        assert(msg.value == uint8(msg.value));
        addressBalance[msg.sender] += uint8(msg.value); 
    }

    function withdrawMoney(address payable _to, uint8 _amountRequested) public {
        require(addressBalance[msg.sender] >= _amountRequested, "Note enough balance, Aborting transaction!");
        addressBalance[msg.sender] -= _amountRequested;
        _to.transfer(_amountRequested);
    } 

}
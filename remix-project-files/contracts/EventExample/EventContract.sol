// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract EventContract {

    mapping(address => uint) public tokenBalance;

    // event declaration
    event TokenSent(string eventId, address _from, address _to, uint _amount, string str);

    constructor() {
        tokenBalance[msg.sender] = 100;
    }

    function transfer(address payable _to, uint _amount) public {
        
        // emit the event
        emit TokenSent("evn-1", msg.sender, _to, _amount, "my first event");
        
        assert (_amount <= tokenBalance[msg.sender]);
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;
    }

}


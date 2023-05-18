// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;


contract Wallet {

    address public owner;

    uint public myBalance;

    mapping(address => uint) public allowences;
    mapping(address => bool) public isAllowedToSend;

    constructor (address _owner) {
        owner = _owner;
    }

    receive() external payable {
        myBalance += msg.value;
    }

    // naive approach, It can be used only when there is a fallback receive function is implemented in smart contracts
    function transfer(address payable _to, uint amount) public {
        require(owner == msg.sender, "Aborting!, you are nto the owner");
        require(myBalance >= amount, "Aborting!, not enough money");
        myBalance -= amount;
        _to.transfer(amount);
    }

    // better approach would be through calling low-level data
    function transfer(address payable _to, uint _amount, bytes memory _payload) public returns (bytes memory) {
        require(owner == msg.sender, "Aborting!, you are nto the owner");
        
        (bool success, bytes memory returnData) = _to.call{value: _amount}(_payload);
        require(success, "Aborting, call was not successful");
        return returnData;
    }

    function setAllowences(address _for, uint _amount) public {
        require(msg.sender == owner, "Aborting!, you are not the owner");
        allowences[_for] += _amount;

        if(_amount > 0) {
            isAllowedToSend[_for] = true;
        } else {
            isAllowedToSend[_for] = false;
        }
    }

    function sendMoney(address payable _to, uint _amount, bytes memory _payload) public returns (bytes memory) {
        if(msg.sender != owner) {
            require(isAllowedToSend[msg.sender], "Abort, You aren't allowed to send money from this wallet");
            require(allowences[msg.sender] >= _amount, "Abort, You do not have enough money to send");
            allowences[msg.sender] -= _amount;
        }

        (bool success, bytes memory returnData) = _to.call{value: _amount}(_payload);
        require(success, "Abort, Fund transfer failed, calling contract error");
        return returnData;
    }


}
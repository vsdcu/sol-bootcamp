// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;


contract WalletTransactionTracking {

    struct Transaction {
        
        uint amount;
        uint timestamp;
    
    }

    struct Balance {
        
        uint totalBalance;

        uint orderOfDeposits;
        mapping(uint => Transaction) deposits;
        
        uint orderOfWithdrawls;
        mapping(uint => Transaction) withdrawls;

    }

    mapping(address => Balance) public balances;

    function deposit() public payable {
        Transaction memory t;
        t.amount = msg.value;
        t.timestamp = block.timestamp;

        balances[msg.sender].totalBalance += msg.value;
        balances[msg.sender].deposits[balances[msg.sender].orderOfDeposits] = t;
        balances[msg.sender].orderOfDeposits++;

    }

    function withdraw(address payable _to, uint _amount) public {
        Transaction memory t;
        t.amount = _amount;
        t.timestamp = block.timestamp;

        balances[_to].totalBalance -= _amount;
        balances[_to].withdrawls[balances[_to].orderOfWithdrawls] = t;
        balances[_to].orderOfWithdrawls++;

        _to.transfer(_amount);

    }

    function getBalance(address _addr) public view returns (uint) {
        return balances[_addr].totalBalance;
    }

}
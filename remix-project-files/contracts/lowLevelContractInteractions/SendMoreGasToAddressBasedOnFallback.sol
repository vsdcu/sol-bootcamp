/*
Low-Level Calls on Address-Type Variables

But it can be even one level lower. 
Because, what if we don't even know the function to all at all. 
That means, we would need to send the funds to the fallback `receive` function in ContractOne.

*/

// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.15;

contract ContractOne {

    mapping(address => uint) public addressBalances;

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

// fallback function to handle the funds received
    receive() external payable {
        addressBalances[msg.sender] += msg.value;
    }
}

contract ContractTwo {

    function deposit() public payable {}

    function depositOnContractOne(address _contractOne) public { 
        (bool success, ) = _contractOne.call{value: 10, gas: 100000}(""); // passing "" as we don't know the method name in contractOne 
                                                                         // (depends on fallback implementation)
        require(success); // very important to check the outcome in this case.
    }
}

/*

Now we generically send 10 wei to the address _contractOne. 
This can be a smart contract. It can be a wallet. 
If its a contract it will always call the fallback function. But it will provide enough gas to execute arbitrary logic.

Note on Re-Entrancy
-------------------
Be careful here with so-called re-entrency attacks. 
If you provide enough gas for the called contract to execute arbitary logic, 
then its also possible for the smart contract to call back into the calling contract and potentially change state variables.

Always try to follow the so-called checks-effects-interactions pattern, where the external smart contract interaction comes last.

*/

/*

Of course, it would be great if you can call smart contracts from other smart contracts and also send a value, as a well as, more gas.

There are two ways to achieve that:

1. External function calls on contract instances
2. Low-Level calls on the address

You can also leave the gas amount, 
then it will forward all gas and let the called contract execute its logic and return the remainder. 
Safer is to provide an upper limit, just in case.

But that only works if you know:

That the receiving contract is a contract
And that the receiving contract has a specific function

*/



// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.15;


// Using External function calls on contract instances
contract ContractOne {

    mapping(address => uint) addressBalances;

    function getAddressBalance() public view returns (uint) {
        return addressBalances[msg.sender];
    }

    function getTotalContractBalance() public view returns (uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        addressBalances[msg.sender] += msg.value;
    }

}


contract ContractTwo {

    function deposit() public payable {
        // just to receive the funds in contract
    }

    function depositToContractOne(address _contractOneAddress) public {
        ContractOne one = ContractOne(_contractOneAddress); // creating contractOne by its address
        //one.deposit{value:1000}(); // if you leave the gas, it will forward all gas and 
                                    // let the called contract use in executing its logic and return teh remaining
        one.deposit{value: 10, gas: 100000}(); // calling external method of contractOne with passed {value and gas}
    }

}

// Low-Level Calls on Address-Type Variables
/* 

What does it do? Exactly the same as above, but with low level calls (_contractOne.call) and therefore the typesafety is gone. 
We have to manually check if success returned true, otherwise there is no chance we know if the called contract errored out. 
Interestingly here, it needs slightly more gas as well than the version above.

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

    function deposit() public payable {}

    function depositOnContractOne(address _contractOne) public { 
        bytes memory payload = abi.encodeWithSignature("deposit()");
        (bool success, ) = _contractOne.call{value: 10, gas: 100000}(payload); // its just a low-level call to call the method of contract
        require(success); // checking the outcome is very important.
    }
}
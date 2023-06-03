// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract SampleWalletContract {

    uint public walletBalance;

    function deposit() public payable {
        walletBalance +=  msg.value;
    }

    function getWalletContractBalance() public view returns (uint) {
        return address(this).balance;
    }

    function withdrawAll() public {
        address payable to = payable(msg.sender);
        to.transfer(getWalletContractBalance());
        walletBalance = 0;
    }

    function withdrawToAddress(address payable to) public {
        to.transfer(getWalletContractBalance());
        walletBalance = 0;
    }

}
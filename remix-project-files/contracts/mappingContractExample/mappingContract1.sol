// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract mappingContract {

    function sendMoney() public payable {

    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withdrawAllMoney(address _to) public {
        payable(_to).transfer(getBalance());
    }


}
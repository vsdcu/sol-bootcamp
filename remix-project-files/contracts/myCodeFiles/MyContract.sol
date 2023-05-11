// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract MyContract {

    string public mystring = "Hello Girik!";

    uint public myInt;

    function updateString (string memory _newString) public {
        mystring = _newString;
    }

    function incrementMyInt(uint _myint) public {
        myInt = myInt + _myint;
    }

    function decrementMyInt(uint _myint) public {
        myInt = myInt - _myint;
    }

    function compareTwoStrings(string memory _mystring) public view returns (bool) {
        return keccak256(abi.encodePacked(mystring)) == keccak256(abi.encodePacked(_mystring));
    }


}

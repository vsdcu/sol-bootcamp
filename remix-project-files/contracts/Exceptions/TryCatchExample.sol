// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract ExampleThrowException {

    //custom error declaration
    error MyCustomException(string);

    function throwError() public pure {
        //require(false, "Error throw by require!");
        //assert(false);
        revert MyCustomException("MyCustomException!");
    }

}


contract tryCatchExample {

    event ErrorLog(string reason);
    event ErrorLogCode(uint code);
    event ErrorLogBytes(bytes lowLevelData);

    ExampleThrowException ex = new ExampleThrowException();
    
    function catchError() public {
        try ex.throwError() {
            // legit code here
        } catch Error(string memory reason) {
            emit ErrorLog(reason);
        } catch Panic(uint opCode) {
            emit ErrorLogCode(opCode);
        } catch (bytes memory lowLevelData) {
            emit ErrorLogBytes(lowLevelData);
        }
    }

}
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

constant FallbackExample{
    uint256 public result;

    receive() external payable { 
        result = 1;
    } //receive is a func
    //whenever there is a send trasaction with an empty callData, then this function will be called
    //if there is a callData then "fallback function is not defined" errro will come.

    fallback() external payable {// calling when a non defined function is called
        result = 2;
     }

}
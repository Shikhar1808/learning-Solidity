// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

// import './simpleStorage.sol';
import {SimpleStorage} from './simpleStorage.sol';

contract StorageFactory{

    //uint256 public favNumber
    //type visibility name

    // SimpleStorage public mySimpleStorage; //here SimpleStorage is a contract and mySimpleStorage is a variable
    SimpleStorage[] public listOfSimpleStorageContracts;

    function createSimpleStorageContract() public {
        SimpleStorage newSimpleStorageContract = new SimpleStorage(); //with this new keyword, solidity knows to deploy a contract
        listOfSimpleStorageContracts.push(newSimpleStorageContract);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        //Address
        //ABI- Application Binary Interface (ABI will tell our code how )
        SimpleStorage mySimpleStorage = listOfSimpleStorageContracts[_simpleStorageIndex];
        mySimpleStorage.store(_newSimpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        SimpleStorage mySimpleStorage = listOfSimpleStorageContracts[_simpleStorageIndex];
        return mySimpleStorage.retrieve();
    }

}
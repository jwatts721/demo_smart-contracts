// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

//import "hardhat/console.log";

contract ConstructorOwner
{
    address public owner;

    // Constructor
    constructor () public { // no scope specifier required for vsome later version (ie: "public" keyword)
        owner = msg.sender; // assigns the owner to the person who deploys the contract
    }

    function changeOwner (address _newOwner) public {
        if (msg.sender != owner) { // Only the current owner can tranfer ownership
        //console.log("Only the current owner can tranfer ownership");
            return;
        }
        owner = _newOwner;
    }

    function showOwner () public view returns (address) {
        return owner;
    }
}
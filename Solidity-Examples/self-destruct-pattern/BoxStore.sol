// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "@openzeppelin/contracts/access/Ownable.sol";

contract BoxStore is Ownable {
    bool private destroyed = false;

    constructor (address initialOwner) Ownable(initialOwner) {
        
    }

    modifier isNotDestroyed() {
        require(!destroyed, "The box store is closed!");
        _;
    }

    function getContractInfo() public isNotDestroyed view returns (string memory) {
        return "The box store is open!";
    }

    function closeBoxStore() public
    { 
        destroyed = true;
    }
}
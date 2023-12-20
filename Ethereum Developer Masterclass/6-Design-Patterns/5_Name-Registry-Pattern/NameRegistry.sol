// SPDX-License-Identifier: MIT

/**
    Using the name registry pattern as a way to reference named contracts.
    This helps with upgradeable contracts. 

    Makes it easier for the contracts as well as the users to remember the addresses, we use
    a name registry.

    The calling contract doesn't have to remember the address of any of the contracts that it wants to 
    reference. We simply call the name of the contract through the registry, which will automatically 
    be mapped to the contract's address.
 */

pragma solidity 0.6.12;

contract Toyota {
    mapping (string => address) public registry;
    function map () public {
        registry["HR"] = address(new HR());
        registry["Admin"] = address(new Admin());
        registry["Engine"] = address(new Engine());
    }
}

contract HR {
    // Upgradeable
}

contract Admin {

}

contract Engine {

}
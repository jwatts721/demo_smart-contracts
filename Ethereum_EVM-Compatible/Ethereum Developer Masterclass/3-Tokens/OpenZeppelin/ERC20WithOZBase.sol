// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

abstract contract ERC20WithOZBase is ERC20 { // Inherits from ERC20
    string private _name = "ERC20WithOzBaseToken";
    string private _symbol = "E2B";
    uint private _totalSupply = 10000000;

    constructor() ERC20(_name, _symbol) {
        _mint(msg.sender, _totalSupply); // Initiates the total supply value
    }
}
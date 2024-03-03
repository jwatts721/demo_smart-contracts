// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

abstract contract OZTokenBase is ERC20 {
    string private _name = "OZToken";
    string private _symbol = "OZT";
    uint private _totalSupply = 10000000000;

    constructor() ERC20(_name, _symbol) {
        _mint(msg.sender, _totalSupply); // Mints the Token
    }
}
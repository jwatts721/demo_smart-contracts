// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

abstract contract Ab {
    int public a;
    int public b;
    function abc() public { // function declaration
        a = 13; // function implementation
        b = 15;
    }

    function def() public virtual view returns (string memory);
}
// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract Country {
    string public name;
    string public flag;
    string public NA;
    string private GDP; // will not be seen by any child contract
    int public a;
    constructor(int _a) {
        a = _a;
    }
} 
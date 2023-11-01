// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

contract Country {
    string public name;
    string public flag;
    string public NA;
    string private GDP; // will not be seen by any child contract
    int public a;
    constructor(int _a) public {
        a = _a;
    }
} 

contract Region {
    string public regionName;
    string public sublocality;
}

contract India is Country(9) { // India is now a child contract of Country
    uint public sqkm;
    string public primeMinister;
}

contract US is Country(5), Region {
    uint public sqmi;
    string public president;
}
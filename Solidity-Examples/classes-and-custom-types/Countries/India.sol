// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "classes-and-custom-types/Countries/Country.sol";

contract India is Country(9) {
    uint public sqKm;
    string public primeMinister;
}
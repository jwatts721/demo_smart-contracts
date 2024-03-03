// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "classes-and-custom-types/Countries/Country.sol";
import "classes-and-custom-types/Countries/Region.sol";

contract US is Country(5), Region {
    uint public sqMi;
    string public president;
}
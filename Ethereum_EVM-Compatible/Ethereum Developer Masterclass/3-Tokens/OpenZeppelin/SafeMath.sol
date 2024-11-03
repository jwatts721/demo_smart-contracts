// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "@openzeppelin/contracts/utils/math/SafeMath.sol"; // This import can also be a URL

contract Safemath {
    using SafeMath for uint;

    uint public a;
    uint public b;
    uint public sum;
    uint public remainder;

    /**
        - Vulnerable to overflow attacks
    */
    function add() public {
        sum = a.add(b);
    }

    /*
        - Vulnerable to divide by zero bug
    */
    function div() public {
        remainder = a.div(b);
    }
}
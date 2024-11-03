// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

contract UnsafeMath {
    int public a;
    int public b;
    int public sum;
    int public remainder;

    /**
        - Vulnerable to overflow attacks
    */
    function add() public {
        sum = a + b;
    }

    /*
        - Vulnerable to divide by zero bug
    */
    function div() public {
        remainder = a / b;
    }
}
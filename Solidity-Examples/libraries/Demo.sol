// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "libraries/MathLibrary.sol";

contract Demo {
    using Math for int;

    function addition(int a, int b) public pure returns (int) {
        return a.add(b);
    }
    function subtraction(int a, int b) public pure returns (int) {
        return a.subtract(b);
    }
    function multiplication(int a, int b) public pure returns (int) {
        return a.multiply(b);
    }
    function division(int a, int b) public pure returns (int) {
        return a.divide(b);
    }
}
// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

library Math {
    function add(int a, int b) public pure returns (int) {
        return a + b;
    }
    function subtract(int a, int b) public pure returns (int) {
        require(a > b, "A must be greater than B");
        return a - b;
    }
    function multiply(int a, int b) public pure returns (int) {
        return a * b;
    }
    function divide(int a, int b) public pure returns (int) {
        require(b != 0, "Cannot divide by zero");
        return a / b;
    }
}
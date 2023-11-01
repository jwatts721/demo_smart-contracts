// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

contract Poly {
    function sum(int a, int b) public pure returns (int) {
        return a + b;
    }

    function sum(int a, int b, int c) public pure returns (int) {
        return a + b + c;
    }

    function sum(string memory a, string memory b) public pure returns (string memory, string memory) {
        return (a, b);
    }
}
// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

contract A {
    using Math for int;
    function div(int a, int b) pure public returns (int){
        return a.div(b);
    }
}

library Math {
    function div(int a, int b) public pure returns (int) {
        require(b != 0, "The denominator is zero");
        return a / b;
    }
}
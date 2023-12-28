// SPDX-License-Identifier: Unlicensed

pragma solidity 0.6.12;

/**
    The problem here is when two different clients call either of 
    these functions. This introduces randomness in the program which
    is an issue. 

    This is generally bad practice in any application. 
*/
contract A {
    uint public a;
    /*
        Calling either of these functions from two different clients can create a problem.
    */
    function fn1() public {
        a = 12;
    }
    function fn2() public {
        a = 24;
    }
}
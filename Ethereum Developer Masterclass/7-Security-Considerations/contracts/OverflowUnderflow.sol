// SPDX-License-Identifier: MIT

pragma solidity >=0.6.12;

/**
    IMPORTANT NOTE:
    - The older the version of Solidity used, the more likely that it is vulnerable
    to bugs and attacks. 

    v0.8 and above will reject these transactions because they have built in checks.
*/
contract Overflow {
    int8 public a=127; // 127 is the maximum value for int8
    uint8 public balance=255; // range from 0 to +255
    /**
        OVERFLOW ATTACK: 
        The value will be set to -127 on increment.
    */
    function increment() public {
        a++;
    }
    /**
        OVERFLOW ATTACK:
        This scenario is vulnerable to an overflow. 
        The balance will reset to 0 because it is at the maximum of 255.
    
        Using SafeMath in the OpenZeppelin library will help to protect
        against this scenario.
    */
    function incrementOverflow() public {
        require(balance + 1 >= balance, "Overflow"); // possible solution
        balance++;
    }
}

/*
    Same scenario as the Overflow contract, 
*/
contract Underflow {
    uint8 public balance = 0;
    function decrement () public {
        require(balance - 1 <= balance, "Underflow");
        balance--;
    }
}
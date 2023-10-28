// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

contract ConstructorDemo
{
    int16 public value;

    // Constructor
    constructor (int16 _value) public {
        value = _value;
    }

    function modifyValue (int16 _value) public {
        value = _value;
    }
}
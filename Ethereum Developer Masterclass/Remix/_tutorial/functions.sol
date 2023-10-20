// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

contract FunctionBasics {
    int public value1 = 10;
    int public value2 = 20;
    int public sum;
    string public name;

    function multiply(int _val1, int _val2) public {
        sum = _val1 * _val2;
    }

    function setSum() public {
        sum = value1 + value2;
    }

    function getSum() view public returns (int) {
        return sum;
    }

    function getValues() view public returns (int, int) {
        return (value1, value2);
    }

    function getNamedValues() view public returns (int balance, int marks) {
        return (value1, value2);
    }

    function update() public returns (int updatedValue) {
        value2 = value2 * 2;
        return value2;
    }

    function getDefaults() pure public returns (int, bool) {
        return (35, true);
    }

    function setName(string memory _name) public {
        name = _name;
    }
}
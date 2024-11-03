// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.22 ^0.8.19;

contract Add {
    uint sum;

    function Sum(uint _num1, uint _num2) public {
        sum = _num1 + _num2;
    }

    function GetSum() public view returns (uint) {
        return sum;
    }
}
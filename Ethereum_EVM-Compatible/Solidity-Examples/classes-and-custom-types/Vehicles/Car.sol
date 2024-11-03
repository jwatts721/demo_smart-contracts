// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract Car {
    string public name;
    string public color;
    constructor (string memory _name, string memory _color) {
        name = _name;
        color = _color;
    }
    function changeColor (string memory _newColor) public {
        color = _newColor;
    }
}
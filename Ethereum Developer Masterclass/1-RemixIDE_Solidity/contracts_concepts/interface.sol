// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

interface Int {
    function recordName(string memory name) external;
}

contract A is Int {
    string[] public students;
    function recordName(string memory name) override public {
        students.push(name);
    }
}

contract B is Int {
    mapping(string=>bool) public students;
    function recordName(string memory name) override public {
        students[name] = true;
    }
}
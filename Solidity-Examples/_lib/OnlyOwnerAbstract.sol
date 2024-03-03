// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

abstract contract OnlyOwner {
    address _owner;

    constructor () {
        _owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == _owner, "Only the owner can execute this function");
        _;
    }
}
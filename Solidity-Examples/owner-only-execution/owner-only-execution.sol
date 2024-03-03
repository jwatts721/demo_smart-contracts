// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract OwnerOnlyExecution
{
    address private _owner;

    constructor () {
        _owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == _owner, "Only the owner can execute this function");
        _;
    }

    function contractInfo() public onlyOwner view returns (string memory) {
        return "DISCLAIMER: This contract is isolated to owner usage only!";
    }

    function showOwner() public onlyOwner view returns (address) {
        return _owner;
    }

    function changeOwner(address newOwner) public onlyOwner {
        _owner = newOwner;
    }
}
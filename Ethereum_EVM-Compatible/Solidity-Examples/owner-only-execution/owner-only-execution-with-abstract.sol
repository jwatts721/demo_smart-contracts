// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "_lib/OnlyOwnerAbstract.sol";

contract OwnerOnlyExecution is OnlyOwner
{
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
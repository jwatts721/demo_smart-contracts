// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vulnerable {
    address public owner;
    uint256 public balance;

    constructor() {
        owner = msg.sender;
    }

    // Vulnerability 1: Uninitialized state variable
    // The 'balance' variable is uninitialized, which can lead to unexpected behavior.
    function setBalance(uint256 _newBalance) public {
        balance = _newBalance;
    }

    // Vulnerability 2: Lack of access control
    // Anyone can call this function and change the owner.
    function transferOwnership(address _newOwner) public {
        owner = _newOwner;
    }

    // Vulnerability 3: Reentrancy
    // This function allows reentrancy attacks by calling an external contract.
    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw");
        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Withdraw failed");
        balance = 0;
    }
}

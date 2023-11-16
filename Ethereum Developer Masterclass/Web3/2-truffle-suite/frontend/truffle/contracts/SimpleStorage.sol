// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 ^0.8.19;

contract SimpleStorage {
  uint256 value = 3; // This is the initial value when the contract is deployed. It can be changed by anyone writing to this contract address

  function read() public view returns (uint256) {
    return value;
  }

  function write(uint256 newValue) public {
    value = newValue;
  }
}

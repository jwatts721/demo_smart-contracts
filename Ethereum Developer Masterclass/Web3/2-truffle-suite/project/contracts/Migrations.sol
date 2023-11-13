// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 ^0.8.19;

/**
  * Keeps track of the last completed compilation and migration.
 */
contract Migrations {
  address public owner;
  uint public last_completed_migration;

  constructor() {
    owner = msg.sender;
  }

  modifier restricted() {
    if (msg.sender == owner) _;
  }

  function setCompleted (uint completed) public restricted() {
    last_completed_migration = completed;
  }
}

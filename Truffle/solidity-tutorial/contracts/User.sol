// SPDX-License-Identifier: MIT
//pragma solidity ^0.8.4; //-- will fail if you use this version
pragma solidity >=0.4.22 <0.9.0; // Range of Versions, which includes 0.8.4 - VERY IMPORTANT!

contract User {
  string private name;

  function setName(string memory newName) public {
    name = newName;
  }

  function getName() public view returns (string memory) {
    return name;
  }
}

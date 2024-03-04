// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;


import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "hardhat/console.sol";

contract Wallet is ReentrancyGuard {
  using Address for address payable;

  mapping(address => uint256) public balanceOf;

  function deposit() external payable /* nonReentrant */ {
    balanceOf[msg.sender] += msg.value;
  }

  function withdraw() external /* nonReentrant */ {
    require(balanceOf[msg.sender] > 0, "Balace should be greater than 0");

    uint256 depositedAmount = balanceOf[msg.sender];
    console.log("");
    console.log("wallet balance: ", address(this).balance);
    console.log("");
    payable(msg.sender).call{value:depositedAmount}("");

    balanceOf[msg.sender] = 0; // <- this line should be after the transfer
  }
}

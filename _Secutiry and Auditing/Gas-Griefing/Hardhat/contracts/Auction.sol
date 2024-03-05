// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts/utils/Address.sol";

contract Auction {
  using Address for address payable;

  address payable public highestBidder;
  uint256 public highestBid;

  function bid() external payable {
    require(msg.value > highestBid, "Bid is less than highest bid");

    if (highestBidder != address(0)) {
        (bool success, ) = highestBidder.call{value: highestBid}("");
        require(success, "Refunding failed");
    }

    highestBidder = payable(msg.sender); // <-- Vulnerable to reentrancy
    highestBid = msg.value; // <-- Vulnerable to reentrancy
  }

  
}

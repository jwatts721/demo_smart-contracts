// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {
    uint256 private lastRun;
    uint256 public counter;

    function addCount() external
    {
        require(block.timestamp - lastRun > 2 minutes, "Need to wait 2 minutes");

        // Perform the desired action
        lastRun = block.timestamp;
        counter++;
    }

    function getCount() external view returns (uint256){
        return counter;
    }
}
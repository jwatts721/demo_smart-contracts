// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract EventEmitter {
    event MyEvent(address indexed sender, uint256 value);

    function triggerEvent() public {
        emit MyEvent(msg.sender, 100);
    }
}
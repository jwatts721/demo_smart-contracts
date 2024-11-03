// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "@openzeppelin/contracts/utils/Strings.sol";

contract EventEmitter {
    event ethReceived(string message);
    
    receive() external payable {
        string memory receivedValue = Strings.toString(msg.value);
        emit ethReceived(string.concat("Received Amount: ", receivedValue));
    }
}
// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

contract GlobalVariables {

    uint public msgValue;

    function getValues() public view returns(
            uint blockNumber, 
            uint blockTimestamp, 
            address msgSender, 
            bytes calldata msgData // calldata helps get data from the blockchain
        ) {
        // Block number - uint
        // Block timestamp - uint
        // Message Sender - address
        // Message Data - bytes
        return (block.number, block.timestamp, msg.sender, msg.data);
    }

    // Pays to the contract
    function payToContract() public payable {
        msgValue = msg.value;
    }
}
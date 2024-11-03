// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
Explanation:

During the commit phase, users submit their answers by providing a hashed version of their answer (using a secret nonce or salt). 
This hash is stored in the commitments mapping.

In the reveal phase, users reveal their actual answers by providing the nonce and value. 
The contract verifies that the revealed hash matches the stored commitment.

If the revealed value is unique (not already reserved), it is assigned to the user. 
Otherwise, the contract checks which commitment was made earlier and reserves the value for that user.

*/
contract QuizGame {
    struct Commitments {
        bytes32 commitment;
        uint256 blockNumber;
    }

    mapping(address => Commitments) public commitments;
    mapping(uint256 => address) public reserved;

    // Commit phase: Users submit their hashed answers
    function commit(bytes32 hash) external {
        require(commitments[msg.sender].commitment == bytes32(0), "Already committed");
        commitments[msg.sender] = Commitments(hash, block.number);
    }

    // Reveal phase: Users reveal their actual answers
    function reveal(uint256 nonce, uint256 value) external {
        bytes32 d = digest(nonce, value, msg.sender);
        require(commitments[msg.sender].commitment == d, "Invalid data");

        // Check if the value is already reserved
        if (reserved[value] == address(0)) {
            reserved[value] = msg.sender;
        } else if (commitments[reserved[value]].blockNumber > commitments[msg.sender].blockNumber) {
            reserved[value] = msg.sender;
        } else {
            revert("Already reserved");
        }
    }

    // Hash function to create commitment
    function digest(uint256 nonce, uint256 value, address sender) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(nonce, value, sender));
    }
}

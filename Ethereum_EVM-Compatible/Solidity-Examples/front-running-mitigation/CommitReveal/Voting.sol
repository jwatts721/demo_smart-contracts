// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

/*
During the commit phase, users submit their votes by providing a hashed version of their 
choice (using a secret nonce or salt). The hash is stored in the commitments mapping.

In the reveal phase, users reveal their actual votes by providing the original vote value. The contract verifies that the revealed hash matches the stored commitment.
You can customize the revealVote function to handle the revealed votes (e.g., update a vote count).
*/

contract Voting {
    int64 public voteCount = 0;

    // Mapping to store commitments (hashed votes)
    mapping(address => bytes32) public commitments;
    // Mapping to store the actual votes
    mapping(address => uint256) public votes;

    // Commit phase: Users submit their hashed votes
    function commitVote(bytes32 hash) external {
        require(commitments[msg.sender] == bytes32(0), "Already committed");
        commitments[msg.sender] = hash;
    }

    // Reveal phase: Users reveal their actual votes
    function revealVote(uint256 vote) external {
        bytes32 expectedHash = keccak256(abi.encodePacked(vote, msg.sender));
        require(commitments[msg.sender] == expectedHash, "Invalid vote");

        // Process the revealed vote (e.g., update vote count)
        votes[msg.sender] = vote;
        voteCount++;
    }

    // Hash function to create commitment
    function digest(uint256 vote, address sender) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(vote, sender));
    }
}

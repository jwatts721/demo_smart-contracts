// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/*
In a crypto swap scenario, users want to exchange one token for another without revealing their intentions until a specific point. Here’s how the commit-reveal technique can be applied:

Commit Phase:
The user initiates the swap by committing to a hashed version of their desired trade 
parameters (e.g., token amounts, slippage tolerance, etc.).
The commitment includes a secret value (such as a nonce or salt) that only the user knows.
The commitment is stored on-chain.


Reveal Phase:
After a predefined time period (or when a certain condition is met), the user reveals 
their actual trade parameters.
The user submits the original values (e.g., token amounts) along with the secret 
value used during the commitment.
The contract verifies that the revealed hash matches the stored commitment.
If valid, the swap is executed based on the revealed parameters.


Benefits:
Frontrunners cannot anticipate the user’s trade intentions during the commit phase 
because the actual values are hidden.
The user’s privacy is preserved until the reveal phase.
The swap occurs atomically, preventing any interference during the process.
*/
import "@openzeppelin/contracts/utils/Strings.sol";

contract CryptoSwap {
    mapping(address => bytes32) public commitments;

    event triggerSwap(string message);

    // Commit phase: User submits hashed trade parameters
    function commitSwap(bytes32 hash) external {
        require(commitments[msg.sender] == bytes32(0), "Already committed");
        commitments[msg.sender] = hash;
    }

    // Reveal phase: User reveals actual trade parameters
    function revealSwap( uint256 nonce, uint256 amountIn, uint256 amountOut) external {
        bytes32 expectedHash = keccak256(abi.encodePacked(nonce, amountIn, amountOut, msg.sender));
        require(commitments[msg.sender] == expectedHash, "Invalid commitment");

        // Execute the swap based on revealed parameters
        // (e.g., transfer tokens, update balances, etc.)
        // ...
        emit triggerSwap(
            string.concat(
                "Initiating Swap: Amount In -> ",
                Strings.toString(amountIn),
                " - Amount Out -> ",
                Strings.toString(amountOut))
        );
    }

    // Hash function to create commitment
    function digest(uint256 nonce, uint256 amountIn, uint256 amountOut, address sender) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(nonce, amountIn, amountOut, sender));
    }
}

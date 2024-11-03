// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
Verifiable Delay Functions (VDFs) are cryptographic primitives that allow for 
efficient verification of a computation that takes a significant amount of 
time to compute

    - computeVDF computes the VDF result by repeatedly squaring the input modulo a large prime.
    - verifyVDF verifies that the provided output matches the expected result based on the input.
*/
contract VerifiableDelayFunction {
    uint256 public constant T = 100; // Number of iterations (delay)

    // Compute the VDF result
    function computeVDF(uint256 input) public pure returns (uint256) {
        uint256 result = input;
        for (uint256 i = 0; i < T; i++) {
            // Apply some expensive operation (e.g., moduler exponentiation)
                        result = (result * result) % 1000000007;
        }
        return result;
    }

    // Verify the VDF result
    function verifyVDF(uint256 input, uint256 output) public pure returns(bool) {
        uint256 expectedOuput = computeVDF(input);
        return output == expectedOuput;
    }
}
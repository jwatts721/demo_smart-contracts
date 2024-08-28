// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RoundingErrorContract {
    uint public num1 = 20;
    uint public num2 = 10;
    uint public num3 = 8;
    function divideEvenly () external view returns (uint256) {
        return num1 / num2; // Answer = 2
    }

    function divideErrors () external view returns (uint256) {
        return num3 / num2; // Answer should be 0.8, but = 0
    }
}

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
contract RoundingHandlingContract {
    using SafeMath for *;

    /* Fixed Point Arithmetic */
    function percentageOf(uint x, uint basisPoints) external pure returns(uint) {
        return x.mul(basisPoints).div(10000);
    }
}
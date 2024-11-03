// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenSwap {
    address public tokenA; // Address of Token A (e.g., DAI)
    address public tokenB; // Address of Token B (e.g., USDC)

    constructor(address _tokenA, address _tokenB) {
        tokenA = _tokenA;
        tokenB = _tokenB;
    }

    function swapTokens(uint256 amountA, uint256 amountB) external {
        // Assume both tokens are ERC20 compliant
        IERC20(tokenA).transferFrom(msg.sender, address(this), amountA);
        IERC20(tokenB).transfer(msg.sender, amountB);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

contract FallbackDemo
{
    uint256 public amount;

    function payToContract() public payable {
        amount = msg.value;
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}
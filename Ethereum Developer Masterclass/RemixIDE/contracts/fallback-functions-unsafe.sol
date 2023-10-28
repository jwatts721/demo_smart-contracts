// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

/*
This contract is not safe because it does not hae a fallback or receive function.
If any funds get sent to the contract directly to the address without using the payToContract 
or any other payable function, those funds will be lost in the blockchain FOREVER.
*/

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
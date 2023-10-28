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

    // Method recommended by the Solidity compiler
    receive() external payable {}

    // Fallback function
    fallback() external payable { 
    //    msg.sender.transfer(msg.value); // optional, sends funds back to use if they mistakenly sent to the contract
                                        // you can notify them to use a "payMoney" function
        amount = address(this).balance;        
    }
}
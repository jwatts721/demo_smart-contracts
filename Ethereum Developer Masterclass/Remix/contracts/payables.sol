// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

contract Payables
{
    int public temp1= 0;

    address payable public investor;

    function setVariables() public {
        temp1 = 10;
    }

    /*
        - Define the amount to send to the contract in the left nav of Remix
    */
    function payMoney() public payable {
        // Do something...
    }

    /**
        - Returns a uint because the value is 0 or greater
        - Defines the address(this) as this contract address
            - Retrieves the balance of this contract
     */
    function getBalance() public view returns (uint) {
        return address(this).balance; // default returned in Wei denomination
    }

    function sendMoney() public {
        // Sends the entire balance of this contract to the address of the "investor"
        investor = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2; // This is a user address
        investor.transfer(address(this).balance);
    }

    function sendTwoEther() public {
        address payable investor2;
        investor2 = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
        investor2.transfer(2 ether);
    }
}
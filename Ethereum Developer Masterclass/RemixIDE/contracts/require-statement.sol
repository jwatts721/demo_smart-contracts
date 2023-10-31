// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

contract FallbackDemo
{
    uint256 public amount;

    address public owner;

    // Constructor
    constructor () public { // no scope specifier required for vsome later version (ie: "public" keyword)
        owner = msg.sender; // assigns the owner to the person who deploys the contract
    }

    function payToContract() public payable {
        amount = msg.value;
    }
    
    // Programmatic way to restrict this only to the owner
    function getContractBalance() public view returns (uint) {
        //if (msg.sender == owner) {
        //    return address(this).balance;
        //}
        //revert(); // This just exits the function

        // Reducing the lines of code above using require. 
        // This will only continue to execute if the condition is true in the require statement.
        require(msg.sender == owner, "Only the owner can retrieve the balance"); // Automatically handles the revert statement
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
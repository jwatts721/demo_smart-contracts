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

    /**
        - Helps to reduce the use of the require statement
    */
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _; 
    }

    function payToContract() public onlyOwner payable {
            // We are using the modifier instead off this require statement
        //require(msg.sender == owner, "Only the owner can call this function");
        amount = msg.value;
    }
    
    // Programmatic way to restrict this only to the owner
    function getContractBalance() public onlyOwner view returns (uint) {
        //if (msg.sender == owner) {
        //    return address(this).balance;
        //}
        //revert(); // This just exits the function

        // Reducing the lines of code above using require. 
        // This will only continue to execute if the condition is true in the require statement.
            // We are using the modifier instead of this require statement
        //require(msg.sender == owner, "Only the owner can call this function"); // Automatically handles the revert statement
        
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
pragma solidity ^0.4.18;

contract SimpleBank
{
    mapping (address => uint) private balances;
    
    address public owner;
    
    event LogDepositMade(address accountAddress, uint amount);
    
    function SimpleBank() public payable {
        owner = msg.sender;
    }
    
    function deposit(uint depositAmount) public payable returns (uint) {
        require((balances[msg.sender] + depositAmount) >= balances[msg.sender]);
        balances[msg.sender] += depositAmount;
        return balances[msg.sender];
    }

    
    function withdrawal(uint withdrawAmount) public returns (uint remainingBal) {
        require(withdrawAmount <= balances[msg.sender]);
        balances[msg.sender] -= withdrawAmount;
        if (!msg.sender.call(withdrawAmount)) {
            revert();
        }
        
        return balances[msg.sender];
    }
    
    function balance() view public returns (uint) {
        return balances[msg.sender];
    }
}
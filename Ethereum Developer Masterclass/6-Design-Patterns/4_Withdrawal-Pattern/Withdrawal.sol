// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

/**
    Reference: 
    https://docs.soliditylang.org/en/v0.8.7/common-patterns.html#withdrawal-from-contracts

    This pattern serves to send funds afer an effect.
    In this contract, we don't want to store the money, we just want to verify
    that they are the richest by the amont sent, and then send the funds back
    immediately.

    In the demo below, we will demonstrate why we don't want to have an immediate call to 
    the "tranfer" function to send funds back to the sender. Inadvertanly, if a contract
    calls the "Richest" contract, and that contract has a fallback function, it will send 
    the funds back to the "Richest" contract and it will store funds which is not its intention.

    We want to transfer later.
    In the uncommented line below, the richest.transfer might fail, so instead we just record the information.
    Then we can call our withdraw function. 
*/

/**
 *  
 */
contract Richest {
    address payable richest;
    uint mostSent;
    mapping(address => uint) public investors;
    constructor () public payable {
        richest = msg.sender;
        mostSent = msg.value;
        richest.transfer(msg.value);
    }
    function invest() public payable {
        require(msg.value > mostSent, "Not enough money to become the richest!");
        richest = msg.sender;
        mostSent = msg.value;
        //richest.transfer(msg.value); // Don't transfer within this function itself
        investors[msg.sender] = msg.value;
    }
    function withdraw() public {
        uint amount = investors[msg.sender];
        investors[msg.sender] = 0;
        msg.sender.transfer(amount);
    }
}

contract B {
    fallback () payable external {
        revert();
    }
}

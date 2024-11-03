// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/utils/Strings.sol";

contract SecureWithdrawalContract {
    address public richest;
    uint public mostSent;
    mapping(address => uint) public pendingWithdrawals;

    /// The amount of Ether sent was not higher than
    /// the currently highest amount.
    error NotEnoughEther();

    constructor() payable {
        richest = msg.sender;
        mostSent = msg.value;
    }

    function becomeRichest() public payable {
        if (msg.value <= mostSent) revert NotEnoughEther();
        // This pays the last highest amount to the previous depositor
        pendingWithdrawals[richest] += msg.value;
        richest = msg.sender;
        mostSent = msg.value;
    }

    function withdraw() public payable {
        uint amount = pendingWithdrawals[msg.sender];
        // Remember to zero the pending refund before
        // sending to prevent reentrancy attacks
        pendingWithdrawals[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}

/*
contract SecureContractCaller {
    SecureWithdrawalContract private theContract;

    event fundsTransferred(string);

    constructor (address secureContract) {
        theContract = SecureWithdrawalContract(secureContract);
    }
    
    function becomeRichestProxy(uint256 sendValue) public {
        theContract.becomeRichest{value: sendValue}();
        emit fundsTransferred(
            string.concat(
                "SEND: ",
                Strings.toString(sendValue),
                " sent to Withdrawal Contract via becomeRichest() method"
            )
        );
    }

    function withdrawFunds() public payable {
        theContract.withdraw();
        emit fundsTransferred("RECEIVE: Receiving funds via withdrawFunds() method");
    }

    function payToContract() public payable {
        emit fundsTransferred(
            string.concat(
                "RECEIVE: ",
                Strings.toString(msg.value),
                " received via payToContract() method"
            )
        );
    }

    receive() payable external {
        emit fundsTransferred(
            string.concat(
                "RECEIVE: Directly received ",
                Strings.toString(msg.value)
            )
        );
    }
}
*/
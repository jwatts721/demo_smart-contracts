// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/utils/Strings.sol";

contract VulnerableWithdrawalContract {
    address payable public richest;
    uint public mostSent;

    /// The amount of Ether sent was not higher than
    /// the currently highest amount.
    error NotEnoughEther();

    constructor() payable {
        richest = payable(msg.sender);
        mostSent = msg.value;
    }

    function becomeRichest() public payable {
        if (msg.value <= mostSent) revert NotEnoughEther();
        // This line can cause problems (explained below).
        /*
            The next line causes issues.
            The funds are immediately sent back to the sender, therefore
            the contract never holds a balance. 
            There is no way to send funds to this contract.
        */
        richest.transfer(msg.value); // <-- PROBLEM
        richest = payable(msg.sender);
        mostSent = msg.value;
    }
}

/*
contract VulnerableContractCaller {
    VulnerableWithdrawalContract private theContract;

    event fundsTransferred(string);
    
    constructor(address vulnerableContract) {
        theContract = VulnerableWithdrawalContract(vulnerableContract);
    }

    function becomeRichestProxy() public payable {
        theContract.becomeRichest{value: msg.value}();
        emit fundsTransferred(
            string.concat(
                "SEND: ",
                Strings.toString(msg.value),
                " sent to Withdrawal Contract via becomeRichest() method"
            )
        );
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
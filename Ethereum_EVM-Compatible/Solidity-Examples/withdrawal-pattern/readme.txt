Reference: https://docs.soliditylang.org/en/latest/common-patterns.html

The recommended method of sending funds after an effect is using the withdrawal pattern. 
Although the most intuitive method of sending Ether, as a result of an effect, is a 
direct transfer call, this is not recommended as it introduces a potential security risk. 

=================================================================
VULNERABLE CODE - NOT RECOMMENDED METHOD:
=================================================================
pragma solidity ^0.8.4;

contract SendContract {
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
        richest.transfer(msg.value);
        richest = payable(msg.sender);
        mostSent = msg.value;
    }
}

Notice that, in this example, an attacker could trap the contract into an unusable 
state by causing richest to be the address of a contract that has a receive or 
fallback function which fails (e.g. by using revert() or by just consuming more 
than the 2300 gas stipend transferred to them). That way, whenever transfer is 
called to deliver funds to the “poisoned” contract, it will fail and thus also 
becomeRichest will fail, with the contract being stuck forever.

In contrast, if you use the “withdraw” pattern, the attacker can only cause his 
or her own withdraw to fail and not the rest of the contract’s workings.

The withdraw function protects the contract from falling into an automated iterative failure state.

================================================================
RECOMMENDED CODE SOLUTION
================================================================
pragma solidity ^0.8.4;

contract WithdrawalContract {
    address public richest;
    uint public mostSent;

    mapping(address => uint) pendingWithdrawals;

    /// The amount of Ether sent was not higher than
    /// the currently highest amount.
    error NotEnoughEther();

    constructor() payable {
        richest = msg.sender;
        mostSent = msg.value;
    }

    function becomeRichest() public payable {
        if (msg.value <= mostSent) revert NotEnoughEther();
        pendingWithdrawals[richest] += msg.value;
        richest = msg.sender;
        mostSent = msg.value;
    }

    function withdraw() public {
        uint amount = pendingWithdrawals[msg.sender];
        // Remember to zero the pending refund before
        // sending to prevent reentrancy attacks
        pendingWithdrawals[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}
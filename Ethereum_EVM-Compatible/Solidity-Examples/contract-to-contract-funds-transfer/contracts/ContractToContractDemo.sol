// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

abstract contract SendReceiveBase is Ownable
{
    constructor () Ownable (msg.sender) {}

    event complete(string _message);

    receive() external payable {
        emit complete(
            string.concat(
                "Received ",
                Strings.toString(msg.value),
                " from ",
                Strings.toHexString(msg.sender)
            )
        );
    }

    function getBalance() public view onlyOwner returns (uint256) {
        return address(this).balance;
    }
}

contract Sender is SendReceiveBase
{
    modifier onlyContract() {
        require(msg.sender == address(this), "Only the contract can execute this function.");
        _;
    }

    function sendWalletEther(address payable receiverAddress) public onlyOwner payable {
        (bool success, ) = receiverAddress.call{value: msg.value}("");
        require(success, "From Wallet Transfer Failed");
        emit complete(string.concat("From Wallet Sent: ", Strings.toString(msg.value)));
    }

    function sendContractEther(address payable receiverAddress, uint256 amount) onlyOwner public {
        Sender sender = this;
        sender._sendEther(receiverAddress, amount);
    }

    function _sendEther(address payable receiverAddress, uint256 amount) public onlyContract {
        (bool success, ) = receiverAddress.call{value: amount}("");
        require(success, "From Contract Transfer Failed");
        emit complete(string.concat("From Contract Sent: ", Strings.toString(amount)));
    }    
}

contract Receiver is SendReceiveBase { }
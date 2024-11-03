// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "_lib/OnlyOwnerAbstract.sol";

contract ReceiveDemo is OnlyOwner
{
    uint256 private _amount;

    function withdrawFundsToOwner(uint256 withdrawAmount) public onlyOwner payable{
        require(withdrawAmount > 0, "The withdrawal amount must be greater than 0");
        payable(_owner).transfer(withdrawAmount);
    }

    function withdrawAllFundsToOwner() public onlyOwner payable {
        payable(_owner).transfer(address(this).balance);
    }

    function getLastPaidAmount() public onlyOwner view returns (uint256){
        return _amount;
    }
    
    function getContractBalance() public onlyOwner view returns (uint) {
        return address(this).balance;
    }

    // Use receive() to allow for funds to be sent to the smart contract
    receive() external payable{
        _amount = msg.value;
    }
}
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract SimpleBank {
  mapping (address => uint) private _balances;
  address public _owner;
  event LogDepositMade(address indexed accountAddress, uint amount);

  constructor() {
    _owner = msg.sender;
    _balances [msg.sender] = 10000;
  }

  function deposit(uint amount) public payable returns (uint) {
    require(_balances[msg.sender] + amount >= _balances[msg.sender], "Incorrect balance error");
    _balances[msg.sender] += amount;
    emit LogDepositMade(msg.sender, amount);
    return _balances[msg.sender];
  }

  function withdraw(uint withdrawalAmount) public returns (uint remainingBal) {
    require(withdrawalAmount <= _balances[msg.sender], "Insufficient balance error");
    _balances[msg.sender] -= withdrawalAmount;
    //if (!payable(msg.sender).send(withdrawalAmount)) {
    //  revert();
    //}
    return _balances[msg.sender];
  }

  function balance() view public returns (uint) {
    return _balances[msg.sender];
  }
}

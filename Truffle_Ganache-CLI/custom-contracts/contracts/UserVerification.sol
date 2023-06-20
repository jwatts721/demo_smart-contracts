// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract UserVerification {
  mapping(address => bool) public _userVerified;
  mapping(address => bytes32) public _userCodes;
  mapping(bytes32 => address) public _toSign;
  mapping(bytes32 => bool) _signed;

  address private owner;

  modifier onlyOwner() {
    require(msg.sender == owner, "Only owner can call this function.");
    _;
  }
  
  constructor () {
    owner = msg.sender;
  }

  function addUser(address user, bytes32 hashedVerification) public onlyOwner {
    _userVerified[user] = false;
    _userCodes[user] = hashedVerification;
  }

  function verifyUser(address user, bytes32 verificationCode) public {
    require(_userVerified[user] == false, "User already verified.");
    require(_userCodes[user] == verificationCode, "Verification code does not match");
    _userVerified[user] = true;
  }

  function isUserVerified(address user) public view returns (bool) {
    return _userVerified[user];
  }

  function getUserVerificationCode(address user) public view returns (bytes32) {
    return _userCodes[user];
  }
}

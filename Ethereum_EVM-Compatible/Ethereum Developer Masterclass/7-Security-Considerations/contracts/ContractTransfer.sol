// SPDX-License-Identifier: Unlicensed

pragma solidity 0.6.12;

contract A {
    function pay() payable public {
        // Receives the funds for the contract because it is payable
    }
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract B {
    A public addressA = new A();
    function pay() payable public {
        addressA.pay{value:msg.value}(); // <-- sends value to Contract A
    }
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

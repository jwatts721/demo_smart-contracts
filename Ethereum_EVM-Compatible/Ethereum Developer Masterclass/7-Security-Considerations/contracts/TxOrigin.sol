// SPDX-License-Identifier: Unlicensed

pragma solidity 0.6.12;

contract A {
    address public msgSender;
    address public txOrigin;
    function getDetails() public {
        msgSender = msg.sender;
        txOrigin = tx.origin;
    }
}

contract B {
    A public addressA = new A();
    constructor() public {
        addressA.getDetails();
    }
}

contract C {
    B public addressB = new B();
}

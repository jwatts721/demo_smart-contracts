// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract ContractA {
    function foo() public pure returns (uint) {
        return 42;
    }
}

contract ContractB {
    function bar(address _contractA) public pure returns (uint) {
        ContractA contractA = ContractA(_contractA);
        return contractA.foo();
    }
}

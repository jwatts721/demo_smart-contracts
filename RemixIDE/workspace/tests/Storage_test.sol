// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol";
import "hardhat/console.sol";
import "../contracts/1_Storage.sol";

contract StorageTest {

    Storage testStorage;
    function beforeAll() public {
        testStorage = new Storage();
    }

    function testStoreAndRetrieve() public {
        console.log("Testing that the number is equal to 0");
        Assert.equal(0, testStorage.retrieve(), "The number should be equal to 0");

        uint256 number = 23;

        console.log("Testing store and retrieve method");
        testStorage.store(number);
        Assert.equal(number, testStorage.retrieve(), "The number should be equal to the retrieved value");
    }
}
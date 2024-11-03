// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol";
import "hardhat/console.sol";
import "../contracts/2_Owner.sol";

contract OwnerTest {

    address owner1 = 0x70C7258BA9BD61e7b69b30FA69DA7BB3D9794F89;
    address owner2 = 0xacf06302d5FaCaDe3a62a7Fe732895C972f20EaC;
    Owner ownerTest;
    
    function beforeAll() public {
        ownerTest = new Owner();
    }

    function testGetOwner() public {
        console.log("Testing getOwner");
        address result = ownerTest.getOwner();
        /* The initial owner is set to the caller */
        Assert.notEqual(address(0), result, "Owner value should be set");
    }

    function testChangeOwner() public {
        console.log("Testing changeOwner to Owner 1");
        address originalOwner = ownerTest.getOwner();
        ownerTest.changeOwner(owner1);
        address newOwner = ownerTest.getOwner();
        Assert.notEqual(originalOwner, newOwner, "There should be a new owner");
        Assert.equal(owner1, newOwner, "The new owner should be owner1");
        
        console.log("Testing changeOwner to Owner 2");
        // Must reinstantiate the object. Can't change owner twice within the same object
        ownerTest = new Owner();
        ownerTest.changeOwner(owner2);
        newOwner = ownerTest.getOwner();
        Assert.notEqual(originalOwner, newOwner, "There should be a new owner");
        Assert.notEqual(owner1, newOwner, "There should be a new owner");
        Assert.equal(owner2, newOwner, "The new owner should be owner2");
    }
}
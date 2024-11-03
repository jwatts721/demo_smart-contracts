// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;
//pragma experimental ABIEncoderV2; // Required for lower versions of Solidity

/**
- Using uint8 because we will us a feedback score that is no more than 5. 

Challenge:
    - Someone asks, who has given feedback at this point in time.
*/
contract MappingIterator {
    mapping(address => uint8) public feedback;
    address[] public addresses;

    function giveFeedback(uint8 _feedback) public {
        feedback[msg.sender] = _feedback;
        addresses.push(msg.sender);
    }

    // how many people have given feedback
    function count() public view returns (uint) {
        return addresses.length;
    }

    /** 
        Here is the target. We want to return all of the addresses
        that have given feedback. 

        This is defined as the Mapping Iterator.
    */
    function returnAddresses() public view returns (address[] memory) {
        return addresses;
    }
}
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Marketplace {
    mapping(address => bool) private offerPlaced;
    mapping(address => bool) private itemAvailable;
    mapping(address => uint) private amountOffered;
    mapping(address => bool) private sellerAccepted;
    
    address public seller;
    address public buyer;

    constructor () {
        offerPlaced[msg.sender] = false;
        itemAvailable[msg.sender] = false;
        amountOffered[msg.sender] = 0;
        sellerAccepted[msg.sender] = false;
    }
    
    
    function isItemAvailable() public view returns (bool) {
        return itemAvailable[msg.sender];
    }
    
    function isOfferAccepted() public view returns (bool) {
        return sellerAccepted[msg.sender];
    }
    
    /**
     * SELLER FUNCTIONS
     */
    function makeItemAvailable() public {
        require(itemAvailable[msg.sender] == false, "Item is already available for sale");
        
        if (itemAvailable[msg.sender] == false) {
            itemAvailable[msg.sender] = true;
        }
    }
    
    function getAmountOffered() public view returns (uint) {
        return amountOffered[msg.sender];
    }
        
    function acceptOffer() public {
        require(offerPlaced[msg.sender] == true, "The buyer has not placed an offer");
        require(amountOffered[msg.sender] > 0, "There has been no amount offered");
        
        sellerAccepted[msg.sender] = true;
        itemAvailable[msg.sender] = false;
    }
    
    function rejectOffer() public {
        require(offerPlaced[msg.sender] == true, "The buyer has not placed an offer");
        require(amountOffered[msg.sender] > 0, "There has been no amount offered");
        
        sellerAccepted[msg.sender] = false;
        itemAvailable[msg.sender] = true;
    }
    
    /**
     * BUYER FUNCTIONS 
     */
    function makeOffer(uint offerAmount) public {
        require(itemAvailable[msg.sender] == true, "There is no item available for offer");
        
        if (offerAmount > 0) {
            offerPlaced[msg.sender] = true;
            amountOffered[msg.sender] = offerAmount;
            itemAvailable[msg.sender] = false;
        }
    }
}

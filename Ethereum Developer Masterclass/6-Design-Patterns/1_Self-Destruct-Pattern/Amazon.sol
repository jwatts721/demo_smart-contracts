// SPDX-License-Identifier: MIT
pragma solidity 0.6.12; 

contract Amazon {
    struct Product {
        uint productId;
        string title;
        string desc;
        address payable seller;
        uint price; // in wei
        address buyer;
        bool fulfilled;
    }
    uint public counter = 1;
    bool public destroyed = false; // Preferred for self-destruct
    Product[] public products;

    event fundsReceived(uint value);
    event productRegistered(uint _productId, string productTitle, address seller);
    event productPurchased(uint _productId, string productTitle, address buyer);
    event productFulfilled(uint _productId);

    function isValidProductId(uint _productId) private view returns (bool){
        uint arrayLength = products.length + 1;
        return _productId <= arrayLength;
    }

    modifier validateProductId(uint _productId) {
        require(isValidProductId(_productId), "The productId is invalid");
        _;
    }

    modifier isNotDestroyed() {
        require(!destroyed, "The contract is already destroyed");
        _;
    }

    // product registration
    function registerProduct(string memory _title, string memory _desc, uint _price) isNotDestroyed public {
        require (_price > 0, "Price should be greater than 0");
        // enter product details including who the seller is
        Product memory newProduct;
        newProduct.title = _title;
        newProduct.desc = _desc;
        newProduct.price = _price * 10**18; // 10**18 converts the either value passed in to wei
        newProduct.productId = counter;
        newProduct.seller = msg.sender;
        products.push(newProduct);
        counter++; // Increments the productId
        emit productRegistered(newProduct.productId, _title, msg.sender);
    }

    // buyer buys the product 
    function buy(uint _productId) validateProductId(_productId) isNotDestroyed payable public {
        uint productIdx = _productId - 1;
        require(products[productIdx].seller != msg.sender, "The seller cannot purchase their own product");
        require(products[productIdx].price == msg.value, "The exact price must be paid");
        products[productIdx].buyer = msg.sender;
        emit productPurchased(_productId, products[productIdx].title, msg.sender);
    }

    // buyer confirms delivery, money will be tranferred to seller
    function confirmFulfillment(uint _productId) validateProductId(_productId) isNotDestroyed public {
        uint productIdx = _productId - 1;
        require(products[productIdx].buyer == msg.sender, "Only the buyer can confirm delivery");
        products[productIdx].fulfilled = true;
        products[productIdx].seller.transfer(products[productIdx].price);
        emit productFulfilled(_productId);
    }

    // SELF-DESTRUCT PATTERN
    function implode() public {
        /**
        DEPRECATED
            - The owner of the contract can destroy the contract
            - Transfers the remaining balance to the recipient
            - No one can use the contract after it has been destroyed

            NOTE: "selfdestruct" is a deprecated function in newer versions
                of Solidity

                This is not the most secure way to do this.
                One may want to do this to prevent hacks, howerver, this
                is not the most secure way to do this.

                Using this method, if someone sends money to the contract,
                in a destroyed state, THE MONEY WILL BE LOST!!!
        */
        //selfdestruct(products[0].seller);

        /**
        PREFERRED
            Preferred method for self destruct.
            This is a psuedo self-destruct. 
            The reason for doing it this way is that no money will be lost.
            See the "fallback" method below which allows for the contract
            to receive money even when it is in a "destroyed" state.

            This method allows us to take the contract out of the
            destroyed state.
        */   
        products[0].seller.transfer(address(this).balance);
        destroyed = true;
    }

    /*
        Suggested: Method should exist when you have a fallback function 
                   defined.
    */
    receive() external payable {
        emit fundsReceived(msg.value);
    }

    // Allows contract to receive money whether it is destroyed or not
    fallback() payable external {
        msg.sender.transfer(msg.value);
    }
}
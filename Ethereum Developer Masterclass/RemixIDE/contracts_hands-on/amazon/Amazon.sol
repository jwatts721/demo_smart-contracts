// SPDX-License-Identifier: MIT//
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
    Product[] public products;

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

    // product registration
    function registerProduct(string memory _title, string memory _desc, uint _price) public {
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
    function buy(uint _productId) validateProductId(_productId) payable public {
        uint productIdx = _productId - 1;
        require(products[productIdx].seller != msg.sender, "The seller cannot purchase their own product");
        require(products[productIdx].price == msg.value, "The exact price must be paid");
        products[productIdx].buyer = msg.sender;
        emit productPurchased(_productId, products[productIdx].title, msg.sender);
    }

    // buyer confirms delivery, money will be tranferred to seller
    function confirmFulfillment(uint _productId) validateProductId(_productId) public {
        uint productIdx = _productId - 1;
        require(products[productIdx].buyer == msg.sender, "Only the buyer can confirm delivery");
        products[productIdx].fulfilled = true;
        products[productIdx].seller.transfer(products[productIdx].price);
        emit productFulfilled(_productId);
    }
}
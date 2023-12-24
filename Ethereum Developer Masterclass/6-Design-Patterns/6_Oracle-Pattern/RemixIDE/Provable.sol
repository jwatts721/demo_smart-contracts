// SPDX-License-Identifier: MIT

pragma solidity >= 0.8.0 < 0.9.0; // Defined as per the contract imported

import "https://github.com/provable-things/ethereum-api/blob/master/provableAPI.sol";

contract ExampleContract is usingProvable {

    string public ETHUSD;
    event LogConstructorInitiated(string nextStep);
    event LogPriceUpdated(string price);
    event LogNewProvableQuery(string description);

    constructor() payable {
        emit LogConstructorInitiated("Constructor was initiated. Call 'updatePrice()' to send the Provable Query.");
    }

    function __callback(bytes32 myid, string memory result) public {
        emit LogNewProvableQuery("Starting __callback()...");
        if (msg.sender != provable_cbAddress()) revert();
        ETHUSD = result;
        emit LogPriceUpdated(string.concat("Current ETH Price: ", result));
    }

    function updatePrice() public payable {
        emit LogNewProvableQuery("Updating price...");
        if (provable_getPrice("URL") > address(this).balance) {
            emit LogNewProvableQuery("Provable query was NOT sent, please add some ETH to cover for the query fee");
        } else {
            emit LogNewProvableQuery("Provable query was sent, standing by for the answer..");
            provable_query("URL", "json(https://api.pro.coinbase.com/products/ETH-USD/ticker).price");
        }
    }
}

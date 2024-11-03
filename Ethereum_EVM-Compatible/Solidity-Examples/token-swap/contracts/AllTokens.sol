// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

//import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
//import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract AbstractToken is Ownable {
    // Function to allow the owner to transfer tokens
    function transferTokens(address payable recipient, uint256 amount) public payable onlyOwner {
        (bool success, ) = recipient.call{value: amount}("");
        require(success, "From Contract Transfer Failed");
    }
}

contract TokenA is ERC20, Ownable {
    string private _name = "TokenA";
    string private _symbol = "TKA";
    uint private _totalSupply = 1000000 * 10**decimals(); // 1 million tokens

    constructor() ERC20(_name, _symbol) Ownable(msg.sender) {
        _mint(msg.sender, _totalSupply);
    }
}

contract TokenB is ERC20, Ownable {
    string private _name = "TokenB";
    string private _symbol = "TKB";
    uint private _totalSupply = 1000000 * 10**decimals();

    constructor() ERC20(_name, _symbol) Ownable(msg.sender) {
        _mint(msg.sender, _totalSupply);
    }
}
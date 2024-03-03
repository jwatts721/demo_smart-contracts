// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract Box is UUPSUpgradeable, OwnableUpgradeable {
    uint private _value;

    event ValueChanged(uint256 value);

    function initialize(address initialOwner) initializer public {
        __Ownable_init(initialOwner);
        __UUPSUpgradeable_init();
        _value = 21;
    }

    function _authorizeUpgrade(address) internal override onlyOwner {}

    function store(uint256 value) public {
        _value = value;
        emit ValueChanged(value);
    }

    function retrieve() public view returns (uint256) {
        return _value;
    }

    /*
     * TESTING:
       v1 - comment out the "increment" method and "Deploy with Proxy".
          - Modify the value using the "store" method
          - Note this value 
       v2 - uncomment the "increment" method and "Upgrade with Proxy".
          - Check the value, ensure it is the value that was set by the "store" method.
     */
    function increment() public {
        _value++;
        emit ValueChanged(_value);
    }
}
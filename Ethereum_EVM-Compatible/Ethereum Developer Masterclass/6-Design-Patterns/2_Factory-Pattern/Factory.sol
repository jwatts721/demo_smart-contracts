// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

/**
    Factory pattern dictates that you always have a record of the contracts
    deployed from the parent contract.

    See below that the "Car" array is defined to maintain a record of each
    time the "Car" contract is deployed.
*/
contract Toyota {
    Car[] public carsManufactured;

    event returnAllManufactured(Car[]);

    function manufacture() public {
        carsManufactured.push(new Car());
    }
}

contract Car {

}
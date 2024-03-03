// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "classes-and-custom-types/Vehicles/Car.sol";

contract Toyota {
    Car public newCar;

    function deploy() public {
        newCar = new Car("Camry", "White");
    }
    function customize(string memory _newColor) public {
        newCar.changeColor(_newColor);
    }

    function getCarInfo() public view returns (Car) {
        return newCar;
    }
}
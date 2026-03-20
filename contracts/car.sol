// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Car {
    string name;
    uint price;
    constructor(string memory defName, uint defPrice) {
        name = defName;
        price = defPrice;
    }
    function setName(string calldata carName) public {
        name = carName;
    }
    function getName() public view returns (string memory) {
        return name;
    }
    function setPrice(uint carPrice) public {
        price = carPrice;
    }
    function getPrice() public view returns (uint) {
        return price;
    }
}

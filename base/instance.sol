// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Car {
    string public name;
    uint public price;
    constructor(string memory defName, uint defPrice) {
        name = defName;
        price = defPrice;
    }
}
contract Buyer {
    function getCarInfo(
        address carAddr
    ) public view returns (string memory name, uint price) {
        Car car = Car(carAddr); // 实例化Car合约
        name = car.name(); // 外部调用必须调用自动生成的 getter 函数，以访问合约属性值
        price = car.price();
        return (name, price);
    }
}

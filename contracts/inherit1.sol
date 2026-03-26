// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Person {
    uint public age;
    constructor(uint _age) {
        age = _age;
    }
}

contract Stu1 is Person {
    // 子合约固定传参[18]给父合约的构造函数
    constructor() Person(18) {}
}

contract Stu2 is Person {
    // 子合约部署时需要传参，而后传给父合约的构造函数
    constructor(uint age) Person(age) {}
}

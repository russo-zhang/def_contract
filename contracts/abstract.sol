// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

// Cannot deploy abstract contract "Base" —— 抽象合约无法被单独部署。
abstract contract Base {
    uint public baseNum;
    constructor() {
        console.log("Base constructor call"); // Base构造函数先执行
        baseNum = 18;
    }
    // 父类函数无 virtual，子类的fn1会报错
    function fn1() external pure returns (uint) {
        return 123;
    }
    // 父类函数有 virtual，子类无 override（但不重写，执行父类逻辑），小于0.8.0有效，高版本直接报错
    function fn2() external pure virtual returns (uint) {
        return 456;
    }
    // 加 virtual：允许子类重写这个函数
    function addBaseNum(uint val) external view virtual returns (uint) {
        return baseNum + val;
    }
}

contract Stu is Base {
    uint public age;
    constructor() {
        console.log("Stu constructor call"); // Stu构造函数后执行
        age = 19;
    }
    // 父类函数无 virtual，子类加 override（报错）
    // function fn1() external pure override returns (uint) {
    //     return 123000;
    // }
    // 父类函数有 virtual，子类无 override（但不重写，执行父类逻辑）小于0.8.0有效，高版本直接报错
    // function fn2() external pure returns (uint) {
    //     return 456000; // 不会被执行
    // }
    // 加 override：明确覆盖父类的 virtual 函数
    function addBaseNum(uint val) public view override returns (uint) {
        return val + age + 10000;
    }
}

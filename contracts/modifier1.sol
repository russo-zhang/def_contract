// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Demo {
    uint public num = 0;
    // 先执行validtor1，后执行validtor2
    function fn1(uint val) public validtor1(val) validtor2(val) {
        // 调用
        num += val;
    }
    // 声明
    modifier validtor1(uint val) {
        require(val > 10, "val must bigger than 10");
        _;
    }
    modifier validtor2(uint val) {
        require(val > 20, "val must bigger than 20");
        _;
    }
}

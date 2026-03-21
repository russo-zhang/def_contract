// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Demo {
    uint public num = 0;
    function fn1(uint val) public validtor(val) {
        // 调用
        num += val;
    }
    function fn2(uint val) public validtor(val) {
        num += val * 2;
    }
    function getNum() public view returns (uint) {
        return num;
    }
    // 声明
    modifier validtor(uint val) {
        require(val > 10, "val must bigger than 10");
        _;
    }
}

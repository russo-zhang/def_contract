// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Demo {
    uint public num = 0;
    error ValError(); // 定义错误
    function fn1(uint val) public validtor(val) {
        // 调用
        num += val;
    }
    function fn2(uint val) public validtor(val) {
        num += val * 2;
    }
    // 声明
    modifier validtor(uint val) {
        // 取代require的推荐写法（省gas，因为定义的错误会被编译为字节码，而require的自定义错误为字符串）
        // require(val > 10, "val must bigger than 10");
        if (val < 10) revert ValError(); // 调用显示 Error provided by the contract:ValError
        _;
    }
}

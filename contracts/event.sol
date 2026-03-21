// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Demo {
    uint public num = 0;

    event Fn1(address indexed addr, uint value);
    // event Fn2(address indexed addr, uint value);

    function fn1(uint val) public {
        // 调用
        num += val;
        emit Fn1(msg.sender, val);
    }
    function fn2(uint val) public {
        num += val * 2;
        // emit Fn2(msg.sender, val);
    }
}

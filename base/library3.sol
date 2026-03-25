// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library SafeMath {
    function add(uint a, uint b) internal pure returns (uint) {
        uint c = a + b;
        require(c >= a, "uint overflow");
        return a + b;
    }
}
contract Demo {
    using SafeMath for uint;
    function fn(uint x, uint y) public pure returns (uint) {
        // 本质就是把 x 作为 SafeMath.add 函数的第一个参数，y 作为第二个参数传入
        return x.add(y); // 相当于 SafeMath.add(x, y);
    }
}

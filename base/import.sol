// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {SafeMath} from "./library.sol";

contract Demo {
    using SafeMath for uint;
    function fn(uint x, uint y) public pure returns (uint) {
        // 本质就是把 x 作为 SafeMath.add 函数的第一个参数，y 作为第二个参数传入
        return x.add(y); // 相当于 SafeMath.add(x, y);
    }
}

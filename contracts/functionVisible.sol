// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Fn {
    uint public x = 1;
    uint public y = 2;
    uint public z = 3;

    function fn1() public payable returns (uint) {
        x = 111;
        return x;
    }
    function fn2() public view returns (uint) {
        return y;
    }
    function fn3(uint b) public pure returns (uint) {
        uint a = 1000;
        return a + b;
    }
}

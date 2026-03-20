// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Demo {
    uint public x = 23;

    function handler(uint value) public {
        x = 0;
        require(value >= 100, "value must bigger than 100");
        // if (value < 100) {
        //     return;
        // }
        x = 200;
    }
}

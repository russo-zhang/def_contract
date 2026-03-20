// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Demo {
    uint public a;
    fallback() external payable {
        a += 10000;
    }
    receive() external payable {
        a += 100;
    }
}
contract Caller {
    function caller() public {
        Demo demo = new Demo();
        address(demo).call{value: 0}(
            abi.encodeWithSignature("nonExistFunc()")
        );
    }
}

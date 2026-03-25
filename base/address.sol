// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 定义 Addr 合约的接口
interface IAddr {
    function getSenderInfo() external;
}

contract Addr is IAddr {
    uint public balance;
    uint public codeLength;
    bytes32 public codehash;
    function getSenderInfo() public {
        balance = (msg.sender.balance);
        // 直接调用长度为0，使用合约调用length为358
        codeLength = msg.sender.code.length;
        codehash = msg.sender.codehash;
    }
}

contract Caller {
    function callGetInfo(address _to) public {
        IAddr(_to).getSenderInfo();
    }
}

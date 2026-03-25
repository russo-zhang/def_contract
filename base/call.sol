// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Addr {
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
        // 核心：用call()调用getSenderInfo函数
        // 步骤1：编码函数签名（无参数的getSenderInfo）
        bytes memory data = abi.encodeWithSignature("getSenderInfo()");

        // 步骤2：执行call()调用
        (bool success, ) = _to.call(data);

        // 步骤3：校验调用是否成功（必须！否则失败会静默忽略）
        require(success, "Call to getSenderInfo failed");
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Addr {
    uint public balance;
    uint public codeLength;
    function getSenderInfo() public {
        balance = msg.sender.balance;
        codeLength = msg.sender.code.length;
    }
}

contract Caller {
    // 核心：定义和Addr完全一致的状态变量（存储布局匹配）
    uint public balance;
    uint public codeLength;

    receive() external payable {}
    function callGetInfo(address _to) public {
        // 步骤1：编码函数签名（无参数的getSenderInfo）
        bytes memory data = abi.encodeWithSignature("getSenderInfo()");

        // 步骤2：执行delegatecall()调用-------------借用Addr的getSenderInfo函数，但上下文与状态都是本合约
        // 调用后会改变本合约的 balance 与 codeLength
        (bool success, ) = _to.delegatecall(data);

        // 步骤3：校验调用是否成功（必须！否则失败会静默忽略）
        require(success, "delegatecall to getSenderInfo failed");
    }
}

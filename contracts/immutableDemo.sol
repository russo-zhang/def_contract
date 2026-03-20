// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ImmutableAdvanced {
    // 声明时不赋值，构造函数中初始化
    address public immutable FEE_RECIPIENT;
    uint public immutable MIN_AMOUNT;

    // 部署合约时传入参数，初始化 immutable 变量
    constructor(address _recipient, uint _minAmount) {
        FEE_RECIPIENT = _recipient; // 运行时赋值（部署者指定）
        MIN_AMOUNT = _minAmount;
    }

    // 尝试修改会直接编译报错
    function tryChange() public {
        // FEE_RECIPIENT = msg.sender; // ❌ 编译错误：immutable 变量不可修改
    }
}

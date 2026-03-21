// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 定义接口
interface ICounter {
    function count() external view returns (uint);
    function increment() external;
}
// 实现接口的合约1
contract Counter1 is ICounter {
    uint public count;
    function increment() external {
        count += 1;
    }
}
// 实现接口的合约2
contract Counter2 is ICounter {
    uint public count;
    function increment() external {
        count += 2;
    }
}
contract CounterFactory {
    // 传入已部署合约的地址
    function incrementCounter1(address counterInstance) external {
        // 调用传入合约地址的方法
        ICounter(counterInstance).increment();
    }
    function getCount(address counterInstance) external view returns (uint) {
        return ICounter(counterInstance).count();
    }
}

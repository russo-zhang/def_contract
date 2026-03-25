// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Callee {
    function getData() public pure returns (uint256) {
        return 42;
    }
}

contract Caller {
    function callGetData(address callee) public view returns (uint256 data) {
        // call by staticcall
        bytes memory payload = abi.encodeWithSignature("getData()");
        // bool success;
        (bool success, bytes memory dataBytes) = callee.staticcall(payload);
        require(success, "staticcall function failed");
        data = abi.decode(dataBytes, (uint256));
        return data;
    }

    function sendEther(address to, uint256 value) public returns (bool) {
        // 使用 call 发送 ether
        (bool success, ) = to.call{value: value}("");
        require(success, "sendEther failed");
        return success;
    }

    receive() external payable {}
}

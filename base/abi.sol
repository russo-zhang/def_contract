// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Abi {
    uint public codeLength;

    function caller() public {
        // 步骤1：编码函数签名（无参数的getSenderInfo）
        bytes memory data = abi.encodeWithSignature(
            "function transfer(address recipient, uint256 amount)"
        );
        codeLength = data.length;
    }
}

contract ABIEncoder {
    function encodeUint(uint256 value) public pure returns (bytes memory) {
        return abi.encode(value);
    }

    function encodeMultiple(
        uint num,
        string memory text
    ) public pure returns (bytes memory) {
        return abi.encode(num, text);
    }
}

contract ABIDecoder {
    function decodeUint(bytes memory data) public pure returns (uint) {
        return abi.decode(data, (uint));
    }

    function decodeMultiple(
        bytes memory data
    ) public pure returns (uint, string memory) {
        return abi.decode(data, (uint, string));
    }
}

contract FunctionSelector {
    uint256 private storedValue;

    function getValue() public view returns (uint) {
        return storedValue;
    }

    function setValue(uint value) public {
        storedValue = value;
    }

    function getFunctionSelector1() public pure returns (bytes4) {
        bytes memory data = abi.encodeWithSignature("getValue()");
        return bytes4(data);
    }

    function getFunctionSelector2() public pure returns (bytes4) {
        bytes memory data = abi.encodeWithSignature("setValue()");
        return bytes4(data);
    }
}

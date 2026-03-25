// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Callee {
    uint256 value;

    function getValue() public view returns (uint256) {
        return value;
    }

    function setValue(uint256 value_) public payable {
        require(msg.value > 0);
        value = value_;
    }
    receive() external payable {}
}

contract Caller {
    function callSetValue(address callee, uint256 value) public returns (bool) {
        // call setValue()
        bytes memory payload = abi.encodeWithSignature(
            "setValue(uint256)",
            value
        );
        (bool success, ) = callee.call{value: 1 ether}(payload);
        require(success, "call function failed");
        return success;
    }
    receive() external payable {}
}

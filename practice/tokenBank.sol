// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenBank {
    mapping(address => uint) balances;

    function deposit(uint value) public {
        balances[msg.sender] += value;
    }
    function withdraw(uint value) public {
        require(
            balances[msg.sender] >= value,
            "withdraw amount exceeds balance"
        );
        balances[msg.sender] -= value;
    }
    function balance(address _address) public view returns (uint) {
        return balances[_address];
    }
    function balance() public view returns (uint) {
        return balances[msg.sender];
    }
}

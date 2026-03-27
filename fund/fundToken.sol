// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract FundToken {
    string public constant tokenName = "fundToken";
    string public constant tokenSymbol = "FT";
    uint public totalSupply;
    address public owner;
    mapping(address => uint) public balances;
    constructor() {
        owner = msg.sender;
    }
    function mint(uint amount) public {
        balances[msg.sender] += amount;
        totalSupply += amount;
    }
    function transfer(address payee, uint amount) public {
        require(amount > 0, "amount must > 0");
        balances[msg.sender] -= amount;
        balances[payee] += amount;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import {FundMe} from "./FundMe.sol";
import "hardhat/console.sol";

contract FundTokenERC20 is ERC20 {
    FundMe fundMe;
    constructor(address payable fundMeAddr) ERC20("FundTokenERC20", "FT2") {
        fundMe = FundMe(fundMeAddr);
    }
    modifier onlyFundSuccess() {
        // 使用solidity自动创建的变量的getter函数
        require(fundMe.getAllFundSuccess(), "Fund has not successful");
        _;
    }
    function mint(uint amount) public onlyFundSuccess {
        uint balance = fundMe.balanceOf(msg.sender);
        console.log("balance:", balance);
        console.log("amount:", amount);
        console.log("msg.sender:", msg.sender);
        require(balance >= amount, "Insufficient balance");
        _mint(msg.sender, amount);
        fundMe.setFunderToAmount(msg.sender, amount);
    }
    function claim(uint amount) public onlyFundSuccess {
        uint balance = balanceOf(msg.sender);
        require(balance >= amount, "Insufficient balance");
        _burn(msg.sender, amount);
    }
}

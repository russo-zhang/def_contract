// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FundMe {
    mapping(address => uint) public balances;
    uint target = 10000; // usd
    address public owner;
    address public erc20Addr;
    uint public startTime;
    uint public duration;
    uint public endTime;
    bool public getAllFundSuccess = false;

    constructor() {
        duration = 30;
        owner = msg.sender;
        startTime = block.timestamp;
        endTime = block.timestamp + duration;
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Function just for owner");
        _;
    }
    modifier onlyStart() {
        require(block.timestamp < endTime, "fund is ended");
        _;
    }
    modifier onlyEnd() {
        require(block.timestamp >= endTime, "fund is not ended");
        _;
    }
    function fund() public payable onlyStart {
        require(msg.value > 0, "Fund value can not be 0");
        balances[msg.sender] += msg.value;
    }
    function refund() public onlyEnd {
        uint totalBalance = address(this).balance;
        uint totalUsd = ethToUsd(totalBalance) / 10 ** 18;
        require(totalUsd < target, "The fundraising did reach the target.");
        uint refundAmount = balances[msg.sender];
        require(refundAmount > 0, "No balance for a refund.");
        (bool success, ) = msg.sender.call{value: refundAmount}("");
        require(success, "refund failed");
        balances[msg.sender] = 0;
    }
    function getAllFund() public onlyOwner onlyEnd {
        uint totalBalance = address(this).balance;
        uint totalUsd = ethToUsd(totalBalance) / 10 ** 18;
        require(totalUsd > target, "The fundraising did not reach the target.");
        (bool success, ) = msg.sender.call{value: totalBalance}("");
        require(success, "getAllFund failed");
        // 标记筹款成功
        getAllFundSuccess = true;
    }
    function ethToUsd(uint ethAmount) public pure returns (uint) {
        uint ethPrice = 2082;
        return ethAmount * ethPrice;
    }
    function setErc20Addr(address _erc20Addr) public onlyOwner {
        erc20Addr = _erc20Addr;
    }
    function setFunderToAmount(address addr, uint amount) public {
        require(msg.sender == erc20Addr, "sender is not erc20Addr");
        balances[addr] -= amount;
    }
    function balanceOf(address addr) public view returns (uint) {
        return balances[addr];
    }
    receive() external payable {
        fund();
    }
}

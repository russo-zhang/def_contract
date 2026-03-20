// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LuckyNum {
    uint luckyNum = 52;
    uint last;

    struct Guess {
        address player;
        uint num;
    }
    Guess[] public GuessHistory;

    function guess(uint guessNum) public payable {
        require(msg.value > 0,"msg.value must > 0");
        Guess memory playerGuess;
        playerGuess.player = msg.sender;
        playerGuess.num = guessNum;
        GuessHistory.push(playerGuess);
        if (guessNum == luckyNum) {
            // 安全转账：转换为可支付地址 + 检查转账结果
            (bool success, ) = payable(msg.sender).call{value: msg.value * 2}(
                ""
            );
            require(success, "ETH transfer failed");
        }
        last = block.timestamp;
    }
}

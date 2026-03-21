// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// ：导入控制台日志库
import "hardhat/console.sol";

contract SonCall {
    function double(uint val) public pure returns (uint) {
        uint zero = 0;
        1 / zero;
        require(val > 9, "SonCall fn: val must bigger than 9");
        return val * 2;
    }
}

contract Demo {
    SonCall public sonCall;
    uint public index;
    uint public num; // 不重要的值
    constructor() {
        sonCall = new SonCall();
    }
    function foo(uint val) public {
        index++; // 如果sonCall.double错误，该操作会被回滚
        num += sonCall.double(val);
    }
    function fooTryCatch(uint val) public {
        index++; // 即使sonCall.double错误，该操作也不会回滚
        // 捕获调用其他合约
        try sonCall.double(val) returns (uint res) {
            num += res;
        } catch Panic(uint errorCode) {
            // 处理非法错误，assert错误
            console.log("catch Panic error :", errorCode);
        } catch Error(string memory reason) {
            console.log("catch Error, reason:", reason);
        } catch (bytes memory lowLevelData) {
            console.log("other error lowLevelData.length", lowLevelData.length);
            console.log("any other error");
        }
    }
}

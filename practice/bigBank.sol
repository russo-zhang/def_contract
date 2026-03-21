// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IBank {
    function getTop() external view returns (address[3] memory);
    function withdraw() external;
}

contract Bank is IBank {
    mapping(address => uint) balances;
    address[3] top;
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    receive() external payable {
        deposit(msg.sender, msg.value);
    }
    fallback() external payable {
        deposit(msg.sender, msg.value);
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "method only for admin");
        _;
    }
    function deposit(
        address user,
        uint amount
    ) internal virtual returns (bool) {
        require(amount > 0, "amount must > 0");
        balances[user] += amount;
        if (balances[user] > balances[top[2]]) {
            sortTop(user, amount);
        }
        return true;
    }

    function sortTop(address user, uint amount) internal {
        balances[top[2]] = 0;
        uint top1 = balances[top[0]];
        uint top2 = balances[top[1]];
        if (amount > top1) {
            top[2] = top[1];
            top[1] = top[0];
            top[0] = user;
        } else if (amount > top2) {
            top[2] = top[1];
            top[1] = user;
        } else {
            top[2] = user;
        }
    }

    function getTop() public view returns (address[3] memory) {
        return top;
    }

    function withdraw() public onlyAdmin {
        // require(msg.sender == admin, "withdraw only for admin");

        // 1. 获取合约当前全部ETH余额
        uint256 totalBalance = address(this).balance;

        // 2. 校验：合约余额不能为0，避免无意义的转账
        require(totalBalance > 0, "Contract has no ETH to withdraw");

        // 3. 核心：转账全部余额给调用者（msg.sender）
        // call方法是最安全的转账方式，无gas限制，返回是否成功
        (bool success, ) = msg.sender.call{value: totalBalance}("");

        // 4. 校验转账是否成功，失败则回滚所有操作
        require(success, "Withdrawal failed: transfer to caller failed");
    }
}

contract BigBank is Bank {
    modifier onlyBig(uint val) {
        require(val > 0.001 ether, "val must bigger than 0.001 ether");
        _;
    }
    // 重写存款函数
    function deposit(
        address user,
        uint amount
    ) internal override onlyBig(amount) returns (bool) {
        balances[user] += amount;
        if (balances[user] > balances[top[2]]) {
            sortTop(user, amount);
        }
        return true;
    }

    function changeAdmin(address _address) public onlyAdmin {
        admin = _address;
    }
}

contract Admin {
    address public owner;
    // 新增receive函数，允许接收ETH
    receive() external payable {}
    
    constructor() {
        owner = msg.sender;
    }

    function adminWithdraw(IBank bank) public {
        require(msg.sender == owner, "method only for owner");
        bank.withdraw();
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Person {
    uint public age;

    function fn1() public {
        age = 10;
    }
    function fn2() internal {
        age = 20;
    }
    function fn3() private {
        age = 30;
    }
}

contract Stu is Person {
    uint public stuAge;
    function foo() public {
        this.fn1();
        // this.fn2(); // 报错
        fn2();
        // fn3(); // 报错

        Person p = new Person();
        p.fn1();
        // p.fn2(); // 报错
        // p.fn3();  // 报错
    }
}

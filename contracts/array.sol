// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract Reference {
    uint[] public arr1;
    function fn() public {
        // uint[] memory arr2 = new uint[](0);
        // arr2.push(22);
        uint[] memory arr2 = new uint[](1); // 初始化 memory 数组（长度为0）
        // 注意：memory 数组的 push 仅在 Solidity 0.8.12+ 支持
        arr2[0] = 22;
        arr1 = arr2;
    }
    function getArr1() public view returns (uint[] memory) {
        return arr1;
    }
}

// contract ArrayPush {
//     uint[] arr1;
//     uint[] arr2;

//     function appendToArr1() public {
//         append(arr1);
//     }
//     function appendToArr2() public {
//         append(arr2);
//     }
//     function append(uint[] storage arr) internal {
//         arr.push(23);
//     }
//     function getArr() public view returns (uint[] memory, uint[] memory) {
//         return (arr1, arr2);
//     }
// }

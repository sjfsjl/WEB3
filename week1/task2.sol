 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract ReverseString {
  function revertSting(string memory str) public pure  returns (string memory){
      bytes memory b = bytes(str);
      uint len = b.length;
      for (uint i = 0; i < len / 2; i++) {
          bytes1 temp = b[i];
          b[i] =b[len - 1 -i];
          b[len - 1 -i] = temp;
      }
    return string(b);
  }
}
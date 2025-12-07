 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract RomanToInt  {
  function omanToInt (string memory s) public pure returns (uint256){
        uint256[7] memory values = [
            uint256(1000),
            500,
            100,
            50,
            10,
            5,
            1
        ];
  }
  function _setValue(bytes1 str) internal pure returns(uint256) {
    if(str == "I") return 1;
    if(str == "V") return 5;
    if(str == "X") return 10;
    if(str == "L") return 50;
    if(str == "C") return 100;
    if(str == "D") return 500;
    if(str == "M") return 1000;
    revert("Invalid Roman numeral");       
  }
}
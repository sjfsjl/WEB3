 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract BinarySearch   {
  function binarySearch (uint256[] memory arr, uint traget) public pure returns (uint){
    uint256 left = 0;
    uint256 right = arr.length -1;

    while(left <= right) {
      uint256 mid = (left + right) / 2;
      uint256 midV = arr[mid];
      if(midV == traget) {
        return midV;
        // 在 右边
      } else if(mid < traget) {
        left = mid + 1;
      } else {
        // 在左边
        right = mid - 1;
      }
    }
    return -1;
  }
}
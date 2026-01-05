// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 额外挑战（可选）
// 1. 捐赠事件：添加 Donation 事件，记录每次捐赠的地址和金额。
// 2. 捐赠排行榜：实现一个功能，显示捐赠金额最多的前 3 个地址。
// 3. 时间限制：添加一个时间限制，只有在特定时间段内才能捐赠。
contract BeggingContract {
// 1. 编写合约
//   - 创建一个名为 BeggingContract 的合约。
//   - 合约应包含以下功能：
//   - 一个 mapping 来记录每个捐赠者的捐赠金额。
    mapping(address => uint256) public  balances;
    address private immutable owner;
    uint256 public totoalSum;

    uint256 public donateStartTime; // 捐赠开始时间（时间戳）
    uint256 public donateEndTime;   // 捐赠结束时间（时间戳）
      // 捐赠事件：记录捐赠地址、金额、时间
    event DonationReceived(address indexed donor, uint256 amount, uint256 timestamp);
    // 提现事件：记录提现地址、金额、时间
    event Withdrawal(address indexed owner, uint256 amount, uint256 timestamp);

    constructor(){
        owner = msg.sender;
        donateStartTime = block.timestamp;
        donateEndTime =  block.timestamp + 30 days;
    }
    //
    modifier onlyOwner(){
        require(owner == msg.sender,  "Caller is not the owner");
        _;
    }

     modifier onlyDuringDonationPeriod() {
        require(
            block.timestamp >= donateStartTime && block.timestamp <= donateEndTime,
            "BeggingContract: donation is not allowed at this time"
        );
        _;
    }
    //   - 一个 donate 函数，允许用户向合约发送以太币，并记录捐赠信息。
    function donate() external payable onlyDuringDonationPeriod {
        require(msg.value > 0 , "BeggingContract: donation amount must be greater than 0");
        balances[msg.sender] += msg.value;
        totoalSum += msg.value;
        emit DonationReceived(msg.sender, msg.value, block.timestamp);
    }
    // 一个 withdraw 函数，允许合约所有者提取所有资金。
    function withdraw() external onlyOwner{
        uint256 balance = address(this).balance;
        require(balance > 0, "Contract has no ether to withdraw");
        (bool success,) = payable(owner).call{value: totoalSum}("");
        require(success, "withdraw field");
        totoalSum = 0;
        emit Withdrawal(owner, balance, block.timestamp);

    }
    //   - 一个 getDonation 函数，允许查询某个地址的捐赠金额。
    function getDonation(address donor) external view  returns (uint256) {
        require(donor != msg.sender, "");
        return  balances[donor];
    } 
    
      // 接收直接转账的以太币，自动触发捐赠逻辑
       receive() external payable {
        require(msg.value > 0 , "BeggingContract: donation amount must be greater than 0");
        balances[msg.sender] += msg.value;
        totoalSum += msg.value;
        emit DonationReceived(msg.sender, msg.value, block.timestamp);
    }
}
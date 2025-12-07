
 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.0;
 // ✅ 创建一个名为Voting的合约，包含以下功能：
// 一个mapping来存储候选人的得票数
// 一个vote函数，允许用户投票给某个候选人
// 一个getVotes函数，返回某个候选人的得票数
// 一个resetVotes函数，重置所有候选人的得票数

 contract Voting {
    struct User{
        string candidate;// 投票人
        uint256 voteCount;// 获取的票数
    }
    // 候选人
    mapping(uint256  => User)  votes;
    mapping(string => bool) public candidateUserList;   // 候选人是否存在
    // ⭐ 记录投过票的人
    mapping(address => bool) public hasVoted;  // 某个地址是否投过票
    address[] public voters;                  // 所有投过票的地址

    // 地址
    address public  owner;
    // 投票总人数
    uint256 public votesCount;
    // 候选人数量
    uint256 candidateCount;
    constructor(){
        owner = msg.sender;
    }
    // 添加候选人
    function add(string memory candidate) public {
        // 部署人才能添加
        require(owner == msg.sender, "Only owner can add a candidate");
        // 候选人中是否有这个人
        require(!candidateUserList[candidate], "Candidate already exists");
        uint256 candidateId = candidateCount++;
        candidateUserList[candidate] = true;
        User storage p = votes[candidateId];
        p.candidate = candidate;
        p.voteCount = 0;
    }
    // 投票
    function vote(uint256 candidateId) public  {
        require(candidateId < candidateCount,  "User does not exist");
        require(!hasVoted[msg.sender], "User has voted");
        votes[candidateId].voteCount++;
        votesCount++;
        // 投票人
        hasVoted[msg.sender] = true;
        voters.push(msg.sender);
    }

    // 某个候选人的得票数
    function getVotes(uint256 candidateId) public view returns (uint256) {
        require(candidateId < candidateCount,  "User does not exist");
        return votes[candidateId].voteCount;
    }
    // 重置投票数
    function resetVotes() public  {
        uint len = candidateCount;
        for (uint i = 0 ; i < len; i++ ){
            votes[i].voteCount = 0;
        }
        votesCount = 0;
    }
 }
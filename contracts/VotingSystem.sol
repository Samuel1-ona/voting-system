// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;



contract VotingSystem{
    address owner;
    uint256 totalVotes;

    struct Voter {
        bool isRegistered;
        bool hasVoted;
    }

    mapping(address => Voter) voters;


    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the contract owner can perform this action"
        );
        _;
    }

    modifier onlyRegisteredVoter() {
        require(
            voters[msg.sender].isRegistered,
            "Only registered voters can perform this action"
        );
        _;
    }

    function registerVoter(address _voterAddress) public onlyOwner {
    require(!voters[_voterAddress].isRegistered, "Already Registered");

        voters[_voterAddress].isRegistered = true;

    }

    function vote() public onlyRegisteredVoter {
           require(!voters[msg.sender].hasVoted,"Already Voted");
        voters[msg.sender].hasVoted = true;
        totalVotes++;

    }

    function getVoteCount() public view returns (uint256) {
        return totalVotes;
    }
}

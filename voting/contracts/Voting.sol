pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

contract Voting {
    address admin;
    mapping(address => bool) voters;
    struct Choice {
        uint id;
        string name;
        uint numOfVotes;
    }
    
    struct Ballot {
        uint id;
        string name;
        Choice[] choices;
        uint endDate;
    }
    
    mapping(uint => Ballot) ballots;
    uint nextBallotId;
    mapping(address => mapping(uint => bool)) public votes;

    constructor() public {
        admin = msg.sender;
    }
    
    function addVoters(address[] calldata _voters) external onlyAdmin() {
        for (uint i = 0; i < _voters.length; i++) {
            voters[_voters[i]] = true;
        }
    }
    
    function createBallot(string memory name, string[] memory choices, uint offset) public
onlyAdmin() {
        ballots[nextBallotId].id = nextBallotId;
        ballots[nextBallotId].name = name;
        ballots[nextBallotId].endDate = now + offset;
        for (uint i = 0; i < choices.length; i++) {
            ballots[nextBallotId].choices.push(Choice(i, choices[i], 0));
        }
    }
    
    function vote(uint ballotId, uint choiceId) external {
        require(voters[msg.sender] == true, 'Only approved voters can vote');
        require(votes[msg.sender][ballotId] == false, 'Voter can only vote once');
        require(now < ballots[ballotId].endDate, 'Cannot vote after the deadline');
        votes[msg.sender][ballotId] = true;
        ballots[ballotId].choices[choiceId].numOfVotes++;
    }
    
    function results(uint ballotId) view external returns (Choice[] memory) {
        require(now >= ballots[ballotId].endDate, 'Vote has not ended yet so you cannot see the
results');
        return ballots[ballotId].choices;
    }
    
    modifier onlyAdmin() {
        require(msg.sender == admin, 'Only admin');
        _;
    }
}

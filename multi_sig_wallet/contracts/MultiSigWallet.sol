pragma solidity ^0.6.0;

contract MultiSigWallet {
    address[] public approvers;
    uint public quorum;
    struct Transfer {
        uint id;
        uint amount;
        address payable to;
        uint numOfApprovals;
        bool sent;
    }
    
    mapping(uint => Transfer) transfers;
    uint nextId;
    mapping(address => mapping(uint => bool)) approvals;
    
    constructor(address[] memory _approvers, uint _quorum) public payable {
        approvers = _approvers;
        quorum = _quorum;
    }
    
    function createTransfer(uint amount, address payable to) external onlyApprover() {
        transfers[nextId] = Transfer(nextId, amount, to, 0, false);
        nextId++;
    }
    
    function sendTransfer(uint id) external onlyApprover() {
        require(transfers[id].sent == false, 'The transfer has already been sent');
        if (transfers[id].numOfApprovals >= quorum) {
            transfers[id].sent = true;
            address payable to = transfers[id].to;
            uint amount = transfers[id].amount;
            to.transfer(amount);
            return;
        }
        if (approvals[msg.sender][id] == false) {
            approvals[msg.sender][id] = true;
            transfers[id].numOfApprovals++;
        }
    }
    
    
    modifier onlyApprover() {
        bool allowed = false;
        for (uint i = 0; i < approvers.length; i++) {
            if (approvers[i] == msg.sender) {
                allowed = true;
            }
        }
        require(allowed == true, 'Must be an approver');
        _;
    }
}    

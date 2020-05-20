pragma solidity ^0.6.0;

contract SplitPayment {
    address public owner;
    
    constructor(address _owner) public {
        owner = _owner;
    }
    
    function send(address payable[] memory to, uint[] memory amounts) payable onlyOwner public {
        require(to.length == amounts.length, 'the array of addresses to send to must be the same
length as array of amounts');
        for(uint i = 0; i < to.length; i++) {
            to[i].transfer(amounts[i]);
        }
    }
    
    modifier onlyOwner {
        require(msg.sender == owner, 'Only owner of smart contract can transer funds');
        _;
    }
}

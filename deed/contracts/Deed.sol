pragma solidity ^0.6.0;

contract Deed {
    address public lawyer;
    address payable public beneficiary;
    uint public earliestDate;
    
    constructor(
        address _lawyer,
        address payable _beneficiary,
        uint fromNow)
        payable
        public {
            lawyer = _lawyer;
            beneficiary = _beneficiary;
            earliestDate = now + fromNow;
        }
        
    function withdraw() public {
        require(msg.sender == lawyer, 'only lawyer can send balance');
        require(now >= earliestDate, 'balance must be sent after earliest date defined in
contract');
        beneficiary.transfer(address(this).balance);
    }
}

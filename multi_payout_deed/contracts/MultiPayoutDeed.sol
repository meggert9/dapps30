pragma solidity ^0.6.0;

contract MultiPayoutDeed {
    address public lawyer;
    address payable public beneficiary;
    uint public earliestDate;
    uint public amount;
    uint constant public NUMBER_OF_PAYOUTS = 5;
    uint constant public INTERVAL = 10;
    uint public numberOfPaidPayouts;
    
    constructor(
        address _lawyer,
        address payable _beneficiary,
        uint fromNow)
        payable
        public {
            lawyer = _lawyer;
            beneficiary = _beneficiary;
            earliestDate = now + fromNow;
            amount = msg.value / NUMBER_OF_PAYOUTS;
        }
        
    function withdraw() public {
        require(msg.sender == beneficiary, 'only beneficiary can send balance');
        require(now >= earliestDate, 'balance must be sent after earliest date defined in contract');
        require(numberOfPaidPayouts < NUMBER_OF_PAYOUTS, 'There are no payouts left');
        
        uint numberOfEligiblePayouts = (now - earliestDate) / INTERVAL;
        uint numberOfDuePayouts = numberOfEligiblePayouts - numberOfPaidPayouts;
        numberOfDuePayouts = numberOfDuePayouts + numberOfPaidPayouts > NUMBER_OF_PAYOUTS ? NUMBER_OF_PAYOUTS - numberOfPaidPayouts : numberOfDuePayouts;
        
        numberOfPaidPayouts += numberOfDuePayouts;
        beneficiary.transfer(numberOfEligiblePayouts * amount);
    }
}

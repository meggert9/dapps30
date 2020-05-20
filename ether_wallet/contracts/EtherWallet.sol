pragma solidity ^0.6.0;

contract EtherWallet {
    address public owner; //owner of the EtherWallet
    
    constructor(address _owner) public {
        owner = _owner;
    }
    
    function deposit() payable public {}
    
    function send(address payable to, uint amount) public {
        require (msg.sender == owner, 'Must be owner of wallet in order to send');
        to.transfer(amount);
    }
    
    function balanceOf() view public returns (uint) {
        return address(this).balance;
    }
}

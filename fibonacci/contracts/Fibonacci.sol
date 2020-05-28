pragma solidity ^0.6.0;

contract Fibonacci {
    function fib(uint n) pure external returns (uint) {
        if (n == 0) {
            return 0;
        }
        
        uint fib1 = 1;
        uint fib2 = 1;
        for (uint i = 2; i < n; i++) {
            uint fibNum = fib1 + fib2;
            fib2 = fib1;
            fib1 = fibNum;
        }
        
        return fib1;
    }
}

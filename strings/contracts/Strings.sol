pragma solidity ^0.6.0;

contract Strings {
    function length(string memory str) pure public returns (uint) {
        bytes memory strBytes = bytes(str);
        return strBytes.length;
    }
    
    function concatenate(string memory str1, string memory str2) pure public returns (string memory) {
        bytes memory str1Bytes = bytes(str1);
        bytes memory str2Bytes = bytes(str2);
        string memory str = new string(str1Bytes.length + str2Bytes.length);
        bytes memory strBytes = bytes(str);
        
        uint j = 0;
        for(uint i = 0; i < str1Bytes.length; i++) {
            strBytes[j] = str1Bytes[i];
            j++;
        }
        
        for(uint i = 0; i < str2Bytes.length; i++) {
            strBytes[j] = str2Bytes[i];
            j++;
        }   
        
        return string(strBytes);
    }
}

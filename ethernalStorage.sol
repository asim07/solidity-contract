// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract eternalStorage{
    
    mapping(bytes32 => uint) UintStorage;
    
    function getUintValue(bytes32 record) public view returns(uint){
        return UintStorage[record];
    }
    
    function setUintValue(bytes32 record,uint value) public  returns(uint){
        return UintStorage[record] = value;
    }
    
    mapping(bytes32 => bool) booleanStorage;
    
    function getBooleanValue(bytes32 record) public view returns(bool) {
        return booleanStorage[record];
    }
    
    function setBooleanValue(bytes32 record,bool value) public {
        booleanStorage[record] = value;
    }
    
}

library ballotlib {
    
    function getNumberOfVotes(address _ethernalStorage) public view returns(uint256){
        return eternalStorage(_ethernalStorage).getUintValue(keccak256('votes'));
    }
    
    function setNumberOfVotes(address _ethernalStorage, uint _votecount) public  returns(uint256){
        return eternalStorage(_ethernalStorage).setUintValue(keccak256('votes'),_votecount);
    }
}

contract ballot {
    using ballotlib for address;
    address ethernalStorage;
    
    constructor(address _ethernalStorage) {
        ethernalStorage = _ethernalStorage;
    }
    
    function getNumberOfVotes() public view returns(uint) {
        return ethernalStorage.getNumberOfVotes();
    }
    
    function vote() public {
        ethernalStorage.setNumberOfVotes(ethernalStorage.getNumberOfVotes()+1);
    }
}

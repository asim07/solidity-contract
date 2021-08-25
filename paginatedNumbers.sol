// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;
pragma experimental ABIEncoderV2;

contract PaginatedNumbers {
    
    //Store Stats
    Stats public stats;
    
    uint256 public count = 0;

 

 

 

    struct Stats {
        uint256 tickets; // Incremented total
        uint256 participants; // Incremented total
        uint256 transactions; // Incremented total
    }
    
    //array to to store strcuture : ParticipantTransaction
    ParticipantTransaction[] private participantTransactions;
    
    //structure for storing hisotry of participants
    struct ParticipantTransaction { 
        address account; // sender
        uint256 nTickets; // number of tickets purchased `nTickets` argument in participate()
        uint256 value; // BNB value
    }
    
    //array to to store strcuture : PoolResult
    PoolResult[] public poolResults;
    
    struct PoolResult {
    address winner;
    address token;
    uint256 pot;
    uint256 ticketPrice;
    uint256 winningsLimit;
    uint256 liquidityPercentage;
    uint256 rewardRate;
    Stats stats;
    ParticipantTransaction[] recordParticipantTransactions;
    }
    
    function getPaginatedPoolResults(uint resultsPerPage, uint page) external view returns (PoolResult[] memory) {
        
    PoolResult[] memory result = new PoolResult[](resultsPerPage);
  
    for(uint i = resultsPerPage * page - resultsPerPage; i < resultsPerPage * page; i++ ){
      result[i] = poolResults[i];
    } 
    return result;
}
    
    function addDataToParticipantTransactionsPagination(uint value1,uint value2) public {
    // pushing participant data to array
    participantTransactions.push(ParticipantTransaction(msg.sender,value1,value2));
        
    }
    
    //https://stackoverflow.com/questions/48282754/what-is-the-best-approach-in-solidity-for-pagination-straightforward-and-based
    function getPaginatedParticipantTransactions(uint resultsPerPage, uint page) external view returns (ParticipantTransaction[] memory) {
        
    ParticipantTransaction[] memory result = new ParticipantTransaction[](resultsPerPage);
  
    for(uint i = resultsPerPage * page - resultsPerPage; i < resultsPerPage * page; i++ ){
      result[i] = participantTransactions[i];
    } 
    return result;
}
    
    
    //addDataToPoolResults this fucntion take arguments for pool struct array and provide stats and ParticipantTransaction data from the fucntions
    
    function addDataToPoolResults(address _winner,address _token,uint _pot,uint _ticketPrice,uint _winingslimit,uint _liquidityPercentage,uint _rewardRate) public {
        
        
        uint i = count;
        poolResults.push();
        poolResults[i].winner = _winner;
        poolResults[i].token = _token;
        poolResults[i].pot = _pot;
        poolResults[i].ticketPrice = _ticketPrice;
        poolResults[i].winningsLimit = _winingslimit;
        poolResults[i].liquidityPercentage = _liquidityPercentage;
        poolResults[i].rewardRate = _rewardRate;
        poolResults[i].stats = getStats();
        for(uint j =0; j < participantTransactions.length; j++){
        poolResults[i].recordParticipantTransactions.push(ParticipantTransaction(participantTransactions[j].account,participantTransactions[j].nTickets,participantTransactions[j].value));
        }
        count++;
    }
    
     function getPoolResults(uint i) public view returns(PoolResult memory){ //this function return pool result according to index passed to fucntion
        return poolResults[i];
    }
    
    
    function getParticipantTransactions(uint i) public view returns(ParticipantTransaction memory){
        
        return participantTransactions[i];
    }
        
    
    
    function addToStat() public{
        
             //adding data to stats
            stats = Stats(
            
            stats.tickets += 1,
            stats.transactions += 1,
            stats.participants += 1
            
            );
    }
    
      
    function getStats() public view returns(Stats memory){
        return stats;
    }
    
    
    
    
    
    
}

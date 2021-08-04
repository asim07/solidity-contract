// SPDX-License-Identifier: MIT
pragma solidity <0.8.0;

contract loterry {
    
    address public owner;
    address payable [] private players;
    
    constructor() public{
        owner = msg.sender;
    }
    
    function pay()public payable {
        require(msg.value == 1 ether);
        players.push(msg.sender);
    }
    
    function random() private view returns(uint) {
      return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,players)));
    }
    
    function pickWinner() public payable checkOwner  {
        
        uint index = random() % players.length;
        players[index].transfer(address(this).balance);
        delete players;
        
    }
    
    function Getplayers() public view returns(address payable [] memory) {
        return players;
    }
    
     modifier checkOwner() {
         if(msg.sender == owner){
            _;    
         }
         
     }
}

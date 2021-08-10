// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

 

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol';
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol';

 

contract seller is ERC20 {
    
    event Receive(address ,uint );
    
    constructor() ERC20("foxcoin","fox"){
        
    _mint(msg.sender,20000);
    
    }
    
    function EtherBalance() public  view returns(uint){
        return address(this).balance;
    }
}

 

    
contract saleperson  {

 

IERC20 public token;
address private _owner; 

 

constructor (address ad) {
    
    token = seller(ad);
    _owner = ad;
}

 


 function buy(address from,address to) external payable {
        require(msg.value > 1 wei ,"buying amount should be greater than 0" );
       
       uint value = msg.value/ 10000000000000000;
            
             token.transferFrom(from,to,value);
           uint a =   1 ether;
     
 } 

 

function showether() public view returns(uint) {
    return address(this).balance;
}

 

 

 

 
}

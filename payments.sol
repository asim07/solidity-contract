// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5; 
 
contract newTask{                           
 
    
 
 address private owner;                 //global variable declared to store owner adress
 
 constructor(){
     owner = msg.sender;                //constructor initialized the variable with owner address
 }
 
   struct user{                         //struct to save user data and array for user transaction history
       
       string name;
       string email;
      uint [] paymentHistory;
   }
   
   
   
   
   
    mapping(address => user)  public users;             //mapping to save each struc obj against caller address
       
    address payable [] private UserAddresses;                    //array of payable addresses
    
    
    
   
   function addusers(string memory name, string memory email) public {  //function take user data as parameter 
       
       uint [] memory  emptytransaction;                                //empty value for array of transaction in the start
       
       users[msg.sender] = user(name,email,emptytransaction);          // initialized the struc obj with values and adress as key for map
       
       UserAddresses.push(payable(msg.sender));                         //save adress into payable array of addresses 
   }
   
   
   
   
   function  sendMoney() public payable  {                              
       
       uint averagePrice = address(this).balance / UserAddresses.length;    //division of currency according to number of users in array
       
       for(uint8 i=0;i<UserAddresses.length;i++){                           //for loop to traverse each adress with info to send ether to thier accounts
           
           UserAddresses[i].transfer(averagePrice);                             
           
           users[UserAddresses[i]].paymentHistory.push(averagePrice);       //push the transaction amoun to array as record
       }
   }
   
   function deposit() public payable {
                                                                            //payable empty fucntion to recieve ether
   }
   
   function show() public view returns(uint) {                              //method to show current balance in contract
       return address(this).balance;
       
   }
 
  modifier isAdmin() {
      if(msg.sender == owner ){                                             //additional check for identifying the owner
          _;
      }
  }

function showUserHistory(address  a) public view returns(uint[] memory){    //method to show transaction history of user against the address
    return users[a].paymentHistory;                                      
}
   
     
}

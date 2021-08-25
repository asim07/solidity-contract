// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EthereumBank {
    
    address private owner;
    
    struct Users {
        string name;
        uint balance;
        bool isUserApproved;
        uint timeStamp;
    }
    
    mapping(address => Users) private accounts;
    address [] private userAdresses;
    address [] private closeAccountRequests;
    
    event Deposit(address  user,uint amount);
    event Withdraw(address  user,uint amount);
    event approved(address user,bool approve);
    event Transfer(address sender,address reciever,uint amount);
    event Delete(address user);
    
     constructor () payable  {
        require(msg.value >= 1 ether,"owner have to stake 50 or more ethers to deploy");
        owner = msg.sender;
        emit Deposit(msg.sender,msg.value);
    }
    
    function checkBalance(address ad) public view returns(uint) {
        return accounts[ad].balance;
    }
    
    function registerUser(string memory name) public payable {
        require(msg.value > 0 wei,"user must stake some amount");
        Users memory newuser;
        newuser = Users(name,msg.value,false,block.timestamp + 2678400);
        accounts[msg.sender] = newuser;
        userAdresses.push(payable(msg.sender));
    }
    
    function approveUser(address ad) public {
        require(msg.sender == owner,"Only Owner can call this function");
        accounts[ad].isUserApproved = true;
        emit approved(ad,accounts[ad].isUserApproved);
    }
    
    function approveAllUsers() public {
        require(msg.sender == owner,"Only Owner can call this function");
        
        for(uint i =0; i < userAdresses.length; i++){
                accounts[userAdresses[i]].isUserApproved = true;
        }
    }
    
    function checkApproval(address ad) public view returns(bool) {
        return accounts[ad].isUserApproved;
    }
    
    function transferStake(address reciever,uint amount) public {
        require(accounts[msg.sender].balance >= amount,"account balance should be greater or equal to sending amount ");
        require(accounts[reciever].isUserApproved == true,"reciever must be the approved customer of bank");
        accounts[msg.sender].balance -= amount;
        accounts[reciever].balance += amount;
        emit Transfer(msg.sender,reciever,amount);
    }
    
    function deposit() public  payable {
        require(accounts[msg.sender].isUserApproved == true,"user must be the approved customer of bank");
        require(msg.value > 0 wei);
        accounts[msg.sender].balance += msg.value;
        emit Deposit(msg.sender,msg.value);
    }
    
    function withdraw(uint amount) public {
        require(accounts[msg.sender].balance >= amount);
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender,amount);
        
    }
    
    function applyToCloseAccount() public {
         require(accounts[msg.sender].isUserApproved == true);
         require(block.timestamp >= accounts[msg.sender].timeStamp,"U can apply to close account before the 1 month period");
         closeAccountRequests.push(msg.sender);
    }
    
    function approveCloseAccountRequests(address ad) public {
        require(msg.sender == owner,"only owner can approve closing requests");
        payable(ad).transfer(accounts[ad].balance);
        emit Transfer(address(this),ad,accounts[ad].balance);
        delete accounts[ad];
        delete closeAccountRequests[returnIndexofCloseaccountRequests(ad)-1];
    }
    
    function returnIndexofCloseaccountRequests(address ad) internal view returns(uint) {
        for(uint i =0; i < closeAccountRequests.length ; i++ ){
            if(ad == closeAccountRequests[i]){
                return i+1;
            }
        }
        return 0;
    }
    
    function showCloseAccountRequests() public view returns(address[] memory) {
        require(msg.sender == owner);
        return closeAccountRequests;
    }
    
    function selfdestruct(address payable ad) public {
        require(msg.sender == owner,'only owner can call that function');
        selfdestruct(ad);
    }
    
}

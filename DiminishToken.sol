// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

 

// import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/extensions/ERC1155Pausable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

 

contract DinisiumToken is ERC1155Pausable, Ownable {
    uint256 public constant GOLD = 11;
    uint256 public constant SILVER = 111;
    uint256 public constant DOLLAR = 222;
   
  
    event MintedTokens(address mintedOn, uint256 id, uint256 mintedTokens);
    event BurnedTokens(address burnedBy,uint256 id, uint256 burnedTokens);
    event PausedContract(address pauseddBy);
    event UnpausedContract(address unpausedBy);
    event SingleTokenTransfer(address from, address to, uint256 id, uint256 amount);
    event BatchTokensTransfer(address from, address to, uint256[] ids, uint256[] amounts);

 

    constructor() ERC1155("https://game.example/api/item/{id}.json") {
        _mint(msg.sender, GOLD, 10**5, "");
        _mint(msg.sender, SILVER, 10**6, "");
        _mint(msg.sender, DOLLAR, 10**9, "");
    
    }
    
    function increaseSupply (uint256 id, uint256 amount) onlyOwner external {
        require (msg.sender != address(0), "Address is zero");
        _mint (msg.sender, id, amount, "");
        emit MintedTokens(msg.sender, id, amount);
       
      
    }
    
    function decreaseSupply (uint256 id, uint256 amount) whenNotPaused external {
        require (msg.sender != address(0), "Address is zero");
        _burn(msg.sender, id, amount);
         emit BurnedTokens(msg.sender, id, amount);
         
    }
   
    function transferSingle (address from, address to, uint256 id, uint256 amount) whenNotPaused public {
        bytes memory data = '0x00';
        safeTransferFrom(from, to, id, amount, data);
        emit SingleTokenTransfer(from, to, id, amount);
    }
    
    function transferBatch ( address from, address to, uint256[] memory ids, uint256[] memory amounts) whenNotPaused external {
        bytes memory data = '0x00';
        safeBatchTransferFrom(from, to, ids, amounts, data);
        emit BatchTokensTransfer(from, to, ids, amounts);
        
    }
        
    
    
    function singleBalance (address account, uint256 id) public view returns (uint256){
       return balanceOf(account, id);
    }
    
    function batchBalance (address[] memory accounts, uint256[] memory ids) public view returns (uint256[] memory){
        return  balanceOfBatch(accounts, ids);
    }
    
    
    function pauseContract () public onlyOwner returns (bool status) {
        _pause();
        emit PausedContract(msg.sender);
        return true;
    }
    
    
    function unpauseContract () public onlyOwner  returns (bool status) {
        _unpause();
        emit UnpausedContract(msg.sender);
        return true;
    }
    
    // function doubleAmount(address from,address[] memory addresses, uint[] memory ids) public onlyOwner whenNotPaused {
    //     require(addresses.length == ids.length,"amount of addresses should be equal to amount of token ids");
        
    //     uint[] memory currentBalanceOfAddresses = batchBalance(addresses,ids);
        
        
    //     for(uint i=0;i<addresses.length;i++){
    //         for(uint j=0;j<addresses.length;j++){
                
                
    //         }
    //     }
        
    // }
    
    function doubleTheAmount(address from, address[] memory addresses, uint[] memory ids) public onlyOwner whenNotPaused {
        require(addresses.length == ids.length,"amount of addresses should be equal to amount of token ids");
        for(uint i=0;i<addresses.length;i++){
            for(uint j=0;j<addresses.length;j++){
        
                uint value = singleBalance(addresses[j],ids[i]);
                if(value == 0){
                    continue;
                }
                transferSingle(from,addresses[j],ids[i],value);
                
            }
        }
        
    }
    
}

 

// address to send ; 0xed9d02e382b34818e88b88a309c7fe71e65f419d

pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract MappingContract {
    mapping(address => uint256) userBalance;
  
    function getUserBalance(address _address) private view returns (uint256) {
        return userBalance[_address];
    }
    function setUserBalance(address _address, uint balance) private {
        userBalance[_address] = balance;
    }
    function deleteUserBalance(address _address) private  {
        delete userBalance[_address];
    }
    
    function deposit(uint256 amount) public  {
         userBalance[msg.sender]+=amount;
    }
    function checkBalance() public view  returns (uint256){
        return userBalance[msg.sender];
    }

    constructor() payable {
    }

    receive() external payable {}
    fallback() external payable {}
}

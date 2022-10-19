pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

error NoUserForAddress();
error NoDeposit();
error AmountTooSmall();

contract ModifierContract {
    uint256 Fee = 5;
    struct User {
        string name;
        uint256 age;
        bool isValue;
    }

    mapping(address=> User) addressToUser;

    User[] public users;

    function setUserAdress(address _address, User memory _user) private{
        addressToUser[_address] = _user;
    }
    function getUserFromAdress(address _address) private view returns (User memory) {
        if(!addressToUser[_address].isValue){
            revert NoUserForAddress();
        }  
        return addressToUser[_address];
    }
    function deleteUserAdress(address _address) private{
        if(addressToUser[_address].isValue){
            delete addressToUser[_address];
        }  
    }

    function setUserDetails(string calldata _name, uint256 _age) public {
        User memory new_user = User({name: _name , age: _age, isValue: true});
        users.push(new_user);
        addressToUser[msg.sender] = new_user;
    }
    function getUserDetail() public view returns (User memory){
        if(!addressToUser[msg.sender].isValue){
            revert NoUserForAddress();
        }  
        return getUserFromAdress(msg.sender);
    }

    mapping(address => uint256) userBalance;
  
    function getUserBalance(address _address) private view returns (uint256) {
        return userBalance[_address];
    }
    function setUserBalance(address _address, uint256 balance) private {
        userBalance[_address] = balance;
    }
    function deleteUserBalance(address _address) private  {
        delete userBalance[_address];
    }
    
    function deposit(uint256 _amount) public  {
         userBalance[msg.sender]=_amount;
    }

    function addFund(uint256 _amount) public isAmountEnough(_amount) {
        if(userBalance[msg.sender]==0){
            revert NoDeposit();
        } 
        userBalance[msg.sender]+=_amount;
    }

    function checkBalance() public view  returns (uint256){
        return userBalance[msg.sender];
    }

    modifier isAmountEnough(uint256 _amount) {
        if (_amount < Fee) {
            revert AmountTooSmall();
        }
        _;
    }

    constructor() payable {
    
    }
    receive() external payable {}
    fallback() external payable {}
}

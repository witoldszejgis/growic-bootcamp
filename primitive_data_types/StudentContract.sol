pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract StudentContract {

    address public owner;
    mapping(address => Student) public studentMap;

    struct Student {
        address studentAddress;
        string info;
        }
    function getStudentFromAddress(address _address) private view returns ( Student memory _student){
        return studentMap[_address];
    }
    function getStudentDetails(address _address) public view returns ( Student memory _student){
        return getStudentFromAddress(_address);
    }

    function setStudentFromAddress(address _address, Student memory _student) private  {
        studentMap[_address] = _student;
    }
    function deleteStudentFromAddress(address _address) private  {
        delete studentMap[_address];
    }


    function registerStudent(address _studentAddress,string memory _studentInfo) public onlyOwner {
        Student memory _student = Student(_studentAddress,_studentInfo);
        if (getStudentFromAddress(_studentAddress).studentAddress != address(0))
        {
            setStudentFromAddress(_studentAddress,_student);
        }
            
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner can do it");
        _;
    }
    constructor() payable {
        owner=msg.sender;
    }
    receive() external payable {}
    fallback() external payable {}
}

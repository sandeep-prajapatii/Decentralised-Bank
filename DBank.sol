//SPDX-License-Identifier: MIT
pragma solidity 0.8.0;
contract dbank{

    address payable public manager;

    constructor(){
        manager = payable(msg.sender);
    }

//Only the bank's Manager can access this and view the total balance bank have
    function totalBalance()public view returns(uint){
        require( msg.sender == manager,"Only manager can access this");
        return address(this).balance;
    }

//User can view there balance using this function
    function balance() public view returns(uint){
        return balanceOf[msg.sender];
    }

    mapping (address => uint) private balanceOf;

    function deposit() public payable{
        require(msg.value != 0, "You need to deposit more than 0");
        balanceOf[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public{
        require(balanceOf[msg.sender] >= _amount, "Insufficient Balance");
        address payable customer =payable(msg.sender);
        customer.transfer(_amount);
        balanceOf[msg.sender] -= _amount;
    }

    function transfer(address payable  _to, uint _amount)public{
        require(balanceOf[msg.sender] >= _amount, "Insufficient Balance");
        balanceOf[msg.sender] -= _amount;
        balanceOf[_to] += _amount;
    }
}
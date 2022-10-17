//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract lottery{
    address public Manager;
    address payable[] public Players;
    constructor () public
    {
        Manager = msg.sender;
    }
    receive() external payable{
        require(msg.value>=2 ether);
        Players.push(payable(msg.sender));
    }
    function getBalance() public view returns(uint)
    {   
        require(msg.sender== Manager);
        return address(this).balance;
    }
    function random() public view returns(uint256){
        return uint (keccak256(abi.encodePacked(block.difficulty,block.timestamp,Players.length)));
    }
    
    function winnerSelection() public{
        require(msg.sender==Manager);
        require(Players.length>=3);
        uint index = random() % Players.length;
        Players[index].transfer(getBalance());
        
    }

}
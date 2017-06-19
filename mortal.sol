pragma solidity ^0.4.10;

contract mortal {

  address public owner;

  function mortal() {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    if(msg.sender == owner) {
      _;
    }
  }

  function kill() onlyOwner() {
    selfdestruct(owner);
  }
}

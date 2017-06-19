pragma solidity ^0.4.10;

contract owned {

  address public owner;

  function owned() {
    owner = msg.sender;
  }

  modifier onluOwner() {
    if(msg.sender == owner) {
      _;
    }
  }
}

contract helloworld is owned {

  string public message;

  function setMessage(string message) onluOwner() {
    message = message;
  }
}

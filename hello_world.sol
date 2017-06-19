pragma solidity ^0.4.0;

contract HelloWorld {

    address public owner;
    mapping (address => uint) balances;

    function HelloWorld() {
      owner = msg.sender;
      balances[owner] = 1000;
    }

    function transfer(address to, uint value) returns (bool success) {
      if (balances[msg.sender] < value) {
        return false;
      }

      balances[msg.sender] -= value;
      balances[to] += value;
      return true;
    }

    function getBalance(address user) constant returns (uint balance) {
      return balances[user];
    }
}

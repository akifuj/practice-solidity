pragma solidity ^0.4.0;

contract signalCoin {
    mapping (address => mapping (uint => uint)) public balances;
	function signalCoin() {
        balances[msg.sender][0] = 1000; //red
        balances[msg.sender][1] = 1000; //yellow
        balances[msg.sender][2] = 1000; //green
    }
    function sendCoin(address receiver, uint amount, uint coin) returns(bool successful) {
        if (balances[msg.sender][coin] < amount) return false;
        balances[msg.sender][coin] -= amount;
        balances[receiver][coin] += amount;
        return true;
    }
}

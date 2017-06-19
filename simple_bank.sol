pragma solidity ^0.4.0;

contract SimpleBank {

    mapping(address => uint) private balances;

    address public owner;

    event LogDepositMade(address accountAddress, uint amount);

    function SimpleBank() {
        owner = msg.sender;
    }

    function deposit() public returns (uint) {
        balances[msg.sender] += msg.value;

        LogDepositMade(msg.sender, msg.value);

        return balances[msg.sender];
    }

    function withdraw(uint withdrawAmount) public returns (uint remainingBal) {
        if(balances[msg.sender] >= withdrawAmount) {
            balances[msg.sender] -= withdrawAmount;

            if (!msg.sender.send(withdrawAmount)) {
                // send: If the execution fails,
                // the current contract will not stop with  an exceptions,
                // but send will return false

                balances[msg.sender] += withdrawAmount;
            }
        }
        return balances[msg.sender];
    }

    // constant: preventing function from editing state variables
    // allows function to run locally/ off blockchain
    function balance() constant returns (uint) {
        return balances[msg.sender];
    }

    // Fallback Function: executed on a call to the contract
    // if none of the other functions matches the given function identifier (or
    // if no data was supplied at all)
    function () {
        throw;
    }
}

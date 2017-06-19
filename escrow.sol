pragma solidity ^0.4.10;

contract Escrow {

  address public buyer;
  address public seller;
  address public arbiter;

  function Escrow(address seller, address arbiter) payable {
    buyer = msg.sender;
    seller = seller;
    arbiter = arbiter;
  }

  function payoutToSeller() payable {
    if(msg.sender == buyer || msg.sender == arbiter) {
      seller.transfer(this.balance);
    }
  }

  function refundToBuyer() payable {
    if(msg.sender == seller || msg.sender == arbiter) {
      buyer.transfer(this.balance);
    }
  }

  function getBalance() constant returns (uint) {
    return this.balance;
  }
}

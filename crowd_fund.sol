pragma solidity ^0.4.10;

contract CrowdFund {

  address public beneficiary;
  uint256 public goal;
  uint256 public deadline;
  mapping (address => uint256) funders;
  address[] funderAddresses;

  event NewContribution(address indexed _from, uint _value);

  // mappingしなければ
  /*
  uint256 public refundIndex;

  struct Funder {
    address addr;
    uint256 contribution;
  }

  Funder[] funders;
  */

  function CrowdFund(address _beneficiary, uint256 _goal, uint256 duration) {
    beneficiary = _beneficiary;
    goal = _goal;
    deadline = now + duration;
  }

  function getFunderContribution(address _addr) constant returns (uint) {
    return funders[_addr];
  }

  function getFunderAddress(uint _index) constant returns (address) {
    return funderAddresses[_index];
  }

  function funderAddressLength() constant returns (uint) {
    return funderAddresses.length;
  }

  function contribute() payable {
    //funders.push(Funder(msg.sender, msg.value));
    if(funders[msg.sender] == 0) {
      funderAddresses.push(msg.sender);
    }
    funders[msg.sender] += msg.value;
    NewContribution(msg.sender, msg.value);
  }

  function payout() payable {
    if(this.balance >= goal && now > deadline) beneficiary.transfer(this.balance);
  }

  function refund() payable {
    if(now > deadline && this.balance < goal) {
      msg.sender.transfer(funders[msg.sender]);
      funders[msg.sender] = 0;
    }
    /*
    if(msg.sender != beneficiary) {
      throw;
    }
    uint256 index = refundIndex;
    while(index < funders.length && msg.gas > 100000) {
      funders[index].addr.transfer(funders[index].contribution);
      index++;
    }
    refundIndex = index;
    */
  }

}

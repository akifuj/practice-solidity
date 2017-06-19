pragma solidity ^0.4.8;

contract Vorting {

  bytes32[] public candidateNames;
  mapping (bytes32 => uint) public votesReceived;

  function Vorting(bytes32[] _candidateNames) {
    candidateNames = _candidateNames;
  }

  function totalVotesFor(bytes32 candidate) constant returns (uint) {
    return votesReceived[candidate];
  }

  function voteForCandidate(bytes32 candidate) {
    votesReceived[candidate] += 1;
  }

  function getCandidateNames() constant returns (bytes32[]) {
    return candidateNames;
  }

}

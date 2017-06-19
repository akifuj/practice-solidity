pragma solidity ^0.4.10;

contract Flipper {

  enum GameState {noWager, wagerMade, wagerAccepted}
  GameState public currentState;
  uint public wager;
  address public player1;
  address public player2;
  uint seedBlockNumber;

  modifier onlyState(GameState expectedState) {
    if(expectedState == currentState) {
      _;
    } else {
      throw;
    }
  }

  function Flipper() {
    currentState = GameState.noWager;
  }

  function makeWager() onlyState(GameState.noWager) payable returns (bool) {
    wager = msg.value;
    currentState = GameState.wagerMade;
    return true;
  }

  function acceptWager() onlyState(GameState.wagerMade) payable returns (bool) {
    if(msg.value == wager) {
      player2 = msg.sender;
      currentState = GameState.wagerAccepted;
      return true;
    } else {
      throw;
    }
  }

  function resolveBet() onlyState(GameState.wagerAccepted) payable returns (bool) {
    uint blockValue = uint256(block.blockhash(seedBlockNumber));
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    uint256 coinFlip = uint256(uint256(blockValue) / FACTOR);

    if(coinFlip == 0) {
      player1.transfer(this.balance);
      currentState = GameState.noWager;
      return true;
    } else {
      player2.transfer(this.balance);
      currentState = GameState.noWager;
      return true;
    }

    currentState = GameState.noWager;
    return true;
  }
}

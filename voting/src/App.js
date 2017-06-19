import React, { Component } from 'react'
import Vorting from '../build/contracts/Vorting.json'
import Web3 from 'web3'

const provider = new Web3.providers.HttpProvider('http://localhost:8545');
const web3 = new Web3(provider);
const contract = require('truffle-contract');
const vorting = contract(Vorting);
vorting.setProvider(provider);

const CandidateRow = ({candidate, voteForCandidate}) => {
  return (
    <tr>
      <td>{web3.toAscii(candidate.name)}</td>
      <td>{candidate.vote}</td>
      <td>
        <button onClick={() => {voteForCandidate(candidate.name)}}>vote!</button>
      </td>
    </tr>
  );
}

const CandidateTable = ({candidateList, voteForCandidate}) => {

  const rows = candidateList.map((candidate) => {
    return (<CandidateRow
      candidate={candidate}
      key={candidate.name}
      voteForCandidate={voteForCandidate} />)
  });
  return (
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>#Votes</th>
        </tr>
      </thead>
      <tbody>{rows}</tbody>
    </table>
  );
}

class App extends Component {
  constructor(props) {
    super(props)
    this.state = {
      candidateList: [],
      account: web3.eth.accounts[0],
    };
  }

  async componentWillMount() {
      const candidateList = await this.getCandidateList();
      this.setState({candidateList});
  }

  async getCandidateList() {
    const candidateNames = await vorting.deployed().then(instance =>
      instance.getCandidateNames.call());
    var candidateList = [];
    for (var i=0; i<candidateNames.length; i++) {
      name = candidateNames[i];
      const vote = await vorting.deployed().then(instance => instance.totalVotesFor.call(name));
      const candidate = {name: name, vote: String(vote)};
      candidateList.push(candidate);
    }
    return candidateList;
  }

  async handleVoteForCandidate(candidateName) {
    vorting.deployed().then(instance =>
      instance.voteForCandidate(candidateName, {from:this.state.account}));
    const candidateList = await this.getCandidateList();
    this.setState({candidateList})
  }

  render() {
    return (
      <div className="App">
        <CandidateTable
          candidateList={this.state.candidateList}
          voteForCandidate={this.handleVoteForCandidate.bind(this)}
        />
      </div>
    );
  }
}

export default App

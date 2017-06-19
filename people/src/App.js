import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import Web3 from 'web3'
import _ from "lodash"

var ETHEREUM_CLIENT = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:8545"))

var peopleContractABI = [{"constant":true,"inputs":[],"name":"getPeople","outputs":[{"name":"","type":"bytes32[]"},{"name":"","type":"bytes32[]"},{"name":"","type":"uint256[]"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"firstName","type":"bytes32"},{"name":"lastName","type":"bytes32"},{"name":"age","type":"uint256"}],"name":"addPerson","outputs":[{"name":"success","type":"bool"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"people","outputs":[{"name":"firstName","type":"bytes32"},{"name":"lastName","type":"bytes32"},{"name":"age","type":"uint256"}],"payable":false,"type":"function"}]
var peopleContractAddress = "0x30ac149f8906e0d4b27e486f8173f47b7d8c19cd"
var peopleContract = ETHEREUM_CLIENT.eth.contract(peopleContractABI).at(peopleContractAddress)

class App extends Component {

constructor(props) {
  super(props)
  this.state = {
    fristNames: [],
    lastNames: [],
    ages: []
  }
}

  componentWillMount() {
    var data =  peopleContract.getPeople()
    this.setState({
      firstNames: String(data[0]).split(','),
      lastNames: String(data[1]).split(','),
      ages: String(data[2]).split(',')
    })
  }

  render() {
var TableRows = []

_.each(this.state.firstNames, (value, index) => {
  TableRows.push(
    <tr>
      <td>{ETHEREUM_CLIENT.toAscii(this.state.firstNames[index])}</td>
      <td>{ETHEREUM_CLIENT.toAscii(this.state.lastNames[index])}</td>
      <td>{this.state.ages[index]}</td>
    </tr>
  )
})

    return (
      <div className="App">
        <div className="App-header">
        </div>
        <div className="App-Content">
          <table>
            <thead>
              <tr>
                <th>first Name</th>
                <th>Last Name</th>
                <th>age</th>
              </tr>
            </thead>
            <tbody>
              {TableRows}
            </tbody>
          </table>
        </div>
      </div>
    );
  }
}

export default App;

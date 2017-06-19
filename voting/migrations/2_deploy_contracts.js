var Vorting = artifacts.require("./Vorting.sol");
var SimpleStorage = artifacts.require("./SimpleStorage.sol");

module.exports = function(deployer) {
  deployer.deploy(Vorting, ["aki", "yui"]);
  deployer.deploy(SimpleStorage);
};

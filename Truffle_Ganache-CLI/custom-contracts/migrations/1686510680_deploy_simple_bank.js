const SimpleBank = artifacts.require("SimpleBank");

module.exports = function(_deployer) {
  _deployer.deploy(SimpleBank);
};

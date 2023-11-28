const Add = artifacts.require("Add");

module.exports = function(_deployer) {
  _deployer.deploy(Add);
};

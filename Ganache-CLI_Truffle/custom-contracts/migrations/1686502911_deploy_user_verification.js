let userVerification = artifacts.require("UserVerification");

module.exports = function(deployer) {
  deployer.deploy(userVerification);
};

const Marketplace = artifacts.require("Marketplace");

module.exports = async function (deployer) {
  deployer.deploy(Marketplace);
};

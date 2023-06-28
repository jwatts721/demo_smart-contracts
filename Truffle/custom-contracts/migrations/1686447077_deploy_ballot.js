const Ballot = artifacts.require("Ballot");

module.exports = function(deployer) {
  deployer.deploy(Ballot, ["0x4459279c2618DB3Ee91787E5ED295fB82cFecd74", "0x3A6CCE234212374732eF245716caf4ee1E9e4889", "0xA0f6DcEAd7577a3a32D725aE64b9589923D566a5"]);
};

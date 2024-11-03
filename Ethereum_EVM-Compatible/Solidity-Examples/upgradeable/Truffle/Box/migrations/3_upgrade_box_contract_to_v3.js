const { upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const Box = artifacts.require('Box');
const BoxV3 = artifacts.require('BoxV3');

module.exports = async function(_deployer) {
  // Use deployer to state migration tasks.
  await upgradeProxy(Box.address, BoxV3, { deployer: _deployer });
};
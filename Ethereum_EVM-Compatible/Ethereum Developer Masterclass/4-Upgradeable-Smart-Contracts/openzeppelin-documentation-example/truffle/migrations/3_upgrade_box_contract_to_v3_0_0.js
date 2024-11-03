// migrations/4_upgrade_box.js
const { upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const Box = artifacts.require('Box');
const BoxV3 = artifacts.require('BoxV3');

module.exports = async function (deployer) {
  const existing = await Box.deployed();
  await upgradeProxy(existing.address, BoxV3, { deployer });
};
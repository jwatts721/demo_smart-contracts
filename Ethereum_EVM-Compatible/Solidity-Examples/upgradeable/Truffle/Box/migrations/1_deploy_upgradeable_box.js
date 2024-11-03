const { deployProxy } = require('@openzeppelin/truffle-upgrades');
const Box = artifacts.require('Box');

module.exports = async function(_deployer) {
  await deployProxy(Box, [42], { deployer: _deployer, initializer: 'store' });
};

// scripts/deploy_upgradeable_box.js
const { ethers, upgrades } = require('hardhat');

async function main () {
  const Box = await ethers.getContractFactory('Box');
  console.log('Deploying Box...');
  const box = await upgrades.deployProxy(Box, [42], { initializer: 'store' });
  //await box.deployed(); // <-- this line is incorrect
  await box.waitForDeployment(); // correction to the line above
  //console.log('Box deployed to:', box.address); // <-- this line is incorrect
  console.log('Box deployed to:', box.target); // correction to the line above
}

main();
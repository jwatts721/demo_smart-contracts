const { Web3 } = require('web3');
const nodeUrl = 'http://localhost:8545';
const web3 = new Web3(nodeUrl);

const lockContractAddress = '0x5FbDB2315678afecb367f032d93F642f64180aa3';
const lockContractPath = '../artifacts/contracts/Lock.sol/Lock.json';
const lockContract = require(lockContractPath);
const lock = new web3.eth.Contract(lockContract.abi, lockContractAddress);

async function main() {
  // Retrieve the contract version 
  let version = await lock.methods.version().call();
  console.log('Contract version:', version);

  let counter = await lock.methods.counter().call();
  console.log('Contract counter:', counter);

  // Retrieve the unlockTime from the contract
  let unlockTime = await lock.methods.unlockTime().call();
  console.log('Contract Unlock time:', unlockTime);

  // Retrieve the owner from the contract
  let owner = await lock.methods.owner().call();
  console.log('Contract Owner:', owner); // Should be the first account in Hardhat

  // Retrieve the lockedAmount from the contract
  let lockedAmount = await web3.eth.getBalance(lockContractAddress);
  console.log('Contract Locked amount:', lockedAmount);

  // Check the balance of the owner's account
  let ownerBalance = await web3.eth.getBalance(owner);
  console.log('Owner balance:', ownerBalance);

  // Get the current block number
  let blockNumber = await web3.eth.getBlockNumber();
  console.log('Block number:', blockNumber);

  // Get the current block timestamp
  let block = await web3.eth.getBlock(blockNumber);
  console.log('Block timestamp:', block.timestamp);

  // Increment the counter in the contract
  let increment = await lock.methods.incrementCounter().send({ from: owner });
  console.log('Increment:', increment);
  console.log('New counter:', await lock.methods.counter().call());

  try {
    // Withdraw the funds from the contract, using the owner's account
    let withdraw = await lock.methods.withdraw().send({ from: owner });
    console.log('Withdraw:', withdraw);
  } catch (error) {
    console.error('Failed to withdraw funds:', error.cause.message)
  }
}

main();
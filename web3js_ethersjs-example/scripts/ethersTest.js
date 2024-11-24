const { ethers } = require('ethers');
const { JsonRpcProvider } = require('@ethersproject/providers');
const nodeUrl = 'http://localhost:8545';
const provider = new JsonRpcProvider(nodeUrl);
const signer = provider.getSigner();

const lockContractAddress = '0x5FbDB2315678afecb367f032d93F642f64180aa3';
const lockContractPath = '../artifacts/contracts/Lock.sol/Lock.json';
const lockContract = require(lockContractPath);
const lock = new ethers.Contract(lockContractAddress, lockContract.abi, provider);
// Connect the signer to the contract
let lockSigned = lock.connect(signer);

async function main() {
    let version = await lock.version();
    console.log('Contract version:', version);

    let counter = await lock.counter();
    console.log('Contract counter:', counter);

    // Retrieve the unlockTime from the contract
    let unlockTime = await lock.unlockTime();
    console.log('Contract Unlock time:', unlockTime);

    // Retrieve the owner from the contract
    let owner = await lock.owner();
    console.log('Contract Owner:', owner); // Should be the first account in Hardhat

    // Retrieve the lockedAmount from the contract
    let lockedAmount = await provider.getBalance(lockContractAddress);
    console.log('Contract Locked amount:', lockedAmount);

    // Check the balance of the owner's account
    let ownerBalance = await provider.getBalance(owner);
    console.log('Owner balance:', ownerBalance);

    // Get the current block number
    let blockNumber = await provider.getBlockNumber();
    console.log('Block number:', blockNumber);

    // Get the current block timestamp
    let block = await provider.getBlock(blockNumber);
    console.log('Block timestamp:', block.timestamp);

    // Increment the counter in the contract
    let increment = await lockSigned.incrementCounter();
    console.log('Increment:', increment);
    console.log('New counter:', await lock.counter());

    try {
        // Withdraw the funds from the contract, using the owner's account
        let withdraw = await lockSigned.withdraw();
        console.log('Withdraw:', withdraw);
    } catch (error) {
        console.error('Failed to withdraw funds:', error.reason);
    }
}

main();
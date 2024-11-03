/**
 * Off-Chain Timer with On-Chain Validation
 * - The JavaScript handles the delay timer execution
 * - The Solidity Smart Contract handles the validation
 */
const { ethers } = require('hardhat');
const COUNTER_CONTRACT_ADDRESS = "0xd9145CCE52D386f254917e481eB44e9943F39138";

async function main() {
    const counterContract = await ethers.getContractAt("Counter", COUNTER_CONTRACT_ADDRESS);

    setInterval(async () => {
        let result = await counterContract.addCount();

        if (typeof result.hash !== 'undefined') {
            console.log("Hash: ", result.hash);
        }

        let count = await counterContract.getCount();
        console.log("Count: ", count.toString());
    }, 30000); // 30 seconds
}

main();
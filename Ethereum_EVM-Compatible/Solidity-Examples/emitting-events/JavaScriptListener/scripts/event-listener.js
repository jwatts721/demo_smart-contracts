const { ethers } = require('ethers');

// Define provider (e.g., Infura, Alchemy, or local blockchain)
const provider = new ethers.JsonRpcProvider('http://localhost:8545');

// Smart contract address
const contractAddress = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

// ABI of the contract (event definition)
const contractABI = [
    "event MyEvent(address indexed sender, uint256 value)"
];

// Create contract instance
const contract = new ethers.Contract(contractAddress, contractABI, provider);

// Listen for the 'MyEvent' event
contract.on("MyEvent", (sender, value) => {
    console.log(`Event emitted!`);
    console.log(`Sender: ${sender}`);
    console.log(`Value: ${value.toString()}`);
});

// Keep the script running to listen for events


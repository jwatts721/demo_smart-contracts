/**
 * Prerequisites:
 * 1. Install Node.js
 * 2. Install Ganache - local blockchain => http://127.0.0.1:7545
 * 3. Install Node Libraries:
 *  - Web3
 *  - solc  --- nothing newer than 0.8.19  --> npm install solc@0.8.19  
 *  - fs
 * 
 * This is because solidity 0.8.20 introduces the PUSH0(0x5f) opcode which is only supported on the 
 * ETH mainnet and not on any other chains. That's why other chains can't find the PUSH0(0x5f) opcode 
 * and throw this error.
 * For more documentation on why use solc version 0.8.19, see:
 * - https://www.zaryabs.com/push0-opcode/
 * 
 */

// solidity compiler
const solc = require("solc");
console.log("solc version: ", solc.version(), "\n");

// file system - read and write files to your computer
const fs = require("fs");

// web3 interface - communicate with blockchain
const { Web3 } = require("web3");

// setup an http provider
let web3 = new Web3(new Web3.providers.HttpProvider("http://127.0.0.1:7545"));

// read the smart contract file
let fileContent = fs.readFileSync("Add.sol").toString();
console.log(fileContent);

// create an input structure for my solidity compiler
let input = {
  language: "Solidity",
  sources: {
    "Add.sol": {
      content: fileContent,
    }
  },
  settings: {
    outputSelection: {
      "*": {
        "*": ["*"],
      },
    },
  },
};

// compile the solidity code, generate the output
// New syntax (supported from 0.5.12, mandatory from 0.6.0)
var output = JSON.parse(
  solc.compile(JSON.stringify(input), { import: findImports })
);
console.log("output: ", output);

// get the bytecode and ABI for deploying the contract
ABI = output.contracts["Add.sol"]["Add"].abi;
bytecode = output.contracts["Add.sol"]["Add"].evm.bytecode.object;
console.log("ABI: ", ABI);
console.log("bytecode object: ", bytecode);

// calculate the gas estimate using the bytecode
web3.eth.estimateGas({ data: "0x" + bytecode })
  .then((gasEstimate) => {
    console.log("Gas Estimate: ", gasEstimate);
  })
  .then(() => {
    // create a contract object for deployment
    let addContract = new web3.eth.Contract(ABI);

    web3.eth.getAccounts().then((accounts) => {
      console.log("Accounts: ", accounts);
      let defaultAccount = accounts[0];
      console.log("Default Account: ", defaultAccount);

      console.log("Deploying the contract...");
      // deploy the contrac
      addContract
        .deploy({ data: bytecode })
        .send({ from: defaultAccount, gas: 1500000 }) // specify gas to prevent code dize errors
        .on("receipt", (receipt) => {
          console.log("Contract Address: ", receipt.contractAddress);
          addContract.options.address = receipt.contractAddress;
        })
        .then(() => {
          addContract.methods.GetSum().call().then((sum) => {
            console.log("Initial Sum: ", sum);
          });

          // Call the sum function with 2 arguments
          console.log("Calling the sum function, add 10 and 20...");
          addContract.methods.Sum(10, 20).send({ from: defaultAccount }).then((receipt) => {
            addContract.methods.GetSum().call().then((sum) => {
              console.log("Final Sum: ", sum);
            });
          });
        });
    });
  });

// Recommendated by solc documentation (https://www.npmjs.com/package/solc)
function findImports(path) {
  if (path === 'lib.sol')
    return {
      contents:
        'library L { function f() internal returns (uint) { return 7; } }'
    };
  else return { error: 'File not found' };
}
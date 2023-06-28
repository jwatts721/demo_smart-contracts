Prompt:
Give me a Solidity Tutorial using the Ganache-CLI. Be sure to include tests for every method created in the tutorial.

Ganache App: Local Test Blockchain with Visual GUI
Ganache-CLI: Local Test Blockchain
Truffle: Tools for creating Smart Contract Projects, Compiling, Deploying and Testing
         Allows us to write tests in JavaScript (preferred) and Solidity
         
         *** Also provides a local test blockchain with the command "truffle develop" running on port 9545

Environment Setup:
$ npm install -g ganache-cli
$ npm install -g truffle

Start Personal Ethereum Blockchain:
$ ganache-cli

Create a Truffle Project:
$ mkdir solidity-tutorial
$ cd solidity-tutorial
$ truffle init

Scaffold a contract and test:
$ truffle create contract YourContractName # scaffold a contract
$ truffle create test YourTestName         # scaffold a test

Compiling:
$ truffle compile

- Note: Compiled contracts exist in the "build" directory.

Deployment (requires test blockchain):
$ truffle migrate

    To migrate on a specified network:
$ truffle migrate --network testnetwork  <-- see network names in your truffle config

Testing:
$ truffle test

==========================================================
Petshop Project
- Reference: 
https://www.trufflesuite.com/tutorial
https://trufflesuite.com/guides/pet-shop/

Create project using exting Truffle Box
$ mkdir petshop-tutorial
$ cd petshop-tutorial
$ truffle unbox pet-shop
$ truffle compile

Run the development console
$ truffle develop
    -> you can also do $ truffle console --network develop
        if you have the "develop" section in your truffle-config.js file
truffle(develop)> compile
truffle(develop)> migrate

Run the console on a different network
$ truffle console --network sepolia
truffle (sepolia)> 

Run the liteserver development server on port 3000
$ npm run dev

==================================================================
Simplified Hardhat Web3 Application

$ mkdir truffle-web3
$ cd truffle-Web3
$ truffle init

Create a simple smart contract
$ truffle create contract SimpleContract

Create a test for the contract
$ truffle create test SimpleContract

Create a deployment script
$ truffle create migration DeploySimpleContract

TODO: 
- start local blockchain
- deploy the contract
- create web3 project files - in web3 directory - npm init....
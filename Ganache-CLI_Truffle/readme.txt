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
truffle(develop)> compile
truffle(develop)> migrate

Run the liteserver development server on port 3000
$ npm run dev
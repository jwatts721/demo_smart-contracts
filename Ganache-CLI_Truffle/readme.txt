Prompt:
Give me a Solidity Tutorial using the Ganache-CLI. Be sure to include tests for every method created in the tutorial.

Ganache-CLI: Local Test Blockchain
Truffle: Tools for creating Smart Contract Projects, Compiling and Deploying

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
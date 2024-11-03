
MetaMask:
- Web3 Based wallet
These are light nodes within the network.
Unlike full nodes which are a full copy of the Ethereum blockchain.
This allows use to run functions on the "light" node.

Types of Accounts on Ethereum:
- Unlike Bitcoin, which only has one type of account because Bitcoin is the only asset,
Ethereum has Externally Owned Accounts and Contract Accounts.
Externally Owned Accounts = accounts in our wallets, owned by users
    Has a public and a private key
Contract Accounts = Accounts for Smart Contracts
    Only has a public key, there is no private key

Types of Networks:
- Ethereum Mainnet (the main Ethereum network, fees apply)

    Local Test Network 
        - local blockchain in isolated environment - no access from the outside
        - each test account comes starts with 100 ETH 
- JavaScript Network
- Ganache
- Hardhat
- Truffle Develop

    Public Test Networks 
        - best for testing in the public space, particulary for teams of developers
        - requires obtaining ETH from test faucets
- JavaScript Network
- Rinkeby TestNet
- Kovan TestNet 
- Ropsten TestNet 
- Goerli TestNet 

NOTE: One wallet account address can be used for ALL networks. 
      You have to be careful that you DO NOT use real currency on a test network, because this currency will be lost.
      I would test with a different account than the one you use real currency.

===============================================

Web3.js is a library that is used to have a website/app communicate with a blockchain (fullnode/smart contract). 

There are several blockchain node providers that can be used:

Browser Add-On Integration / Injected Web3 (Live Nodes):
- MetaMask
- Coinbase Wallet


API Based Integration: 
- Alchemy.com
- Infura.io
- Moralis.io
- Pocket Network
- Chainnodes
- ZMOI.io
- Anyblock JSON-RPC Node API

=================================================================================
DEMO 
- programmatic deployment of a smart contract to the blockchain using NodeJS
=================================================================================
Ganache will be used for deploying the smart contract using JavaScript code.

Options:
Ganache GUI: http://127.0.0.1:7545
Ganache CLI: http://127.0.0.1:8545

    Note: The port for either of the above options can be customized, but it is recommended to keep them the same.



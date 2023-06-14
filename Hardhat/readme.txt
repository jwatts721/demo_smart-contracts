Reference: 
https://hardhat.org/tutorial
https://decrypt.co/resources/what-is-infura


- Make a tutorial directory
$ mkdir "hardhat-tutorial" && cd "hardhat-tutorial"

- Initialize the directory with npm
$ npm init

- Install Hardhat locally
$ npm install --save-dev hardhat

- Create a new Hardhat Project
$ npx hardhat
    -> Choose Create an empty hardhat.config.js

- Install additional Hardhat plugins
$ npm install --save-dev @nomicfoundation/hardhat-toolbox
    Modify the hardhat.config.js to reference the library

- Create contracts in the "contracts" directory

- After adding the contract code, compile the contract
$ npx hardhat compile

    - Note: Compiled contracts exist under the "artifacts" directory

- Create the "test" directory and a test for MyContract

- After adding the relevant test code, test the contract
$ npx hardhat test


- Debugging
  Hardhat comes built-in with Hardhat Network, a local Ethereum blockchain for development and testing.
  You can print logging messages if you import the library into your smart contract.

  import "hardhat/console.log";

  Then you can simply add console.log() messages to your methods

- Deploying to a Local Network
  - Create a scripts directory
  - Create a deploy.js file
  - Tell Hardhat to connect to a specific Ethereum network
  
  $ npx hardhat run scripts/deploy.js --network <network-name>

      Deploy to local Hardhat Network

  $ npx hardhat run scripts/deploy.js

- Deploying to a Live Remote Network
  Test Network (Sepolia / Goerli)
    - Deploy on a test network to avoid paying gas fees during development
    - Sepolia is almost an identical copy of Ethereum
        - test here before deploying to mainnet
        - Tokens required to run transactions on the testnet, but you can get 
          testnet ETH free using a faucet. The Sepolia network must be added to
          your wallet.
        - Sepolia chain ID = 11155111
        - You can use Blockchain Node providers such as Infura and Alchemy for
          access to the testnet

    - You need Sepolia ether to your wallet for testing.
        Alchemy Sepolia Faucet: https://sepoliafaucet.com/
        Coinbase Sepolia Faucet: https://coinbase.com/faucets/ethereum-sepolia-faucet
        Infura Sepolia Faucet: https://www.infura.io/faucet/sepolia
      
    Mainnet (Live Currency)
    - You can use Blockchain Node providers such as Infura and Alchemy
        - These services are providing you with access to an Ethereum Node
          which you would otherwise have to run yourself. This does have a downside
          of centralizing these types of services.
        - Running nodes provides more distribution of the blockchain, but this may
          not be a possibility to do limit of resources.

    - hardhat.config.js configured for Alchemy - see config

    $ npx hardhat run scripts/deploy.js --network sepolia
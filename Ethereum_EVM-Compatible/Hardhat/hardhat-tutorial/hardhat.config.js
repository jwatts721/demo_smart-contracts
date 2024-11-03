/** @type import('hardhat/config').HardhatUserConfig */
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

// API Key for Alchemy - Blockchain Node Provider (App: Hardhat Tutorial Node)
const ALCHEMY_API_KEY = process.env.ALCHEMY_API_KEY || "";

// Test Account (in MetaMask) - Private Key
// -- Even though this is a test account, it is still a good practice to use a private key that is not used in production
// -- This is a test account in MetaMask or Coinbase Wallet
const SEPOLIA_PRIVATE_KEY = process.env.SEPOLIA_PRIVATE_KEY || "";

module.exports = {
  solidity: "0.8.18",
  networks: {
    hardhat: {
      chainId: 1337
    },
    sepolia: {
      url: `https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_API_KEY}`,
      accounts: [SEPOLIA_PRIVATE_KEY]
    },
    /*
    mainnet: {
      url: `https://eth-mainnet.alchemy.com/v2/${ALCHEMY_API_KEY}`,
      accounts: [PUBLIC_WALLET_PRIVATE_KEY]
    }
    */
  }
};

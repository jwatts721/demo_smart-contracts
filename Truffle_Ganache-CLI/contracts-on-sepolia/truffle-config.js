require('dotenv').config();
const { ALCHEMY_API_KEY, ACCOUNT_PRIVATE_KEY } = process.env;
const HDWalletProvider = require('@truffle/hdwallet-provider');
const provider = new HDWalletProvider({
  privateKeys: [ACCOUNT_PRIVATE_KEY],
  providerOrUrl: `https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_API_KEY}`,
  numberOfAddresses: 1,
  shareNonce: true,
});

module.exports = {
  networks: {
    /*
    development: {
      host: "127.0.0.1",      // Localhost (default: none)
      port: 8545,             // Standard Ganache port (default: none)
      network_id: "*",        // Any network (default: none)
      gas: 6700000,           // Gas limit
    },
    */
   develop: {
    host: "127.0.0.1",
    port: 9545,
    network_id: "*",
   },
    sepolia: {
      provider: () => provider,
      network_id: "*",       // Any network (default: none)
      gas: 6700000,          // Gas limit
      gasPrice: 20000000000
    },
  },

  // Set default mocha options here, use special reporters, etc.
  mocha: {

  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.20",
    }
  },
};

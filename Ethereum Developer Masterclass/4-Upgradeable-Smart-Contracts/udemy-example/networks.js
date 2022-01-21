module.exports = {
  networks: {
    development: {
      protocol: 'http',
      host: '127.0.0.1',
      port: 8545,
      gas: 5000000,
      gasPrice: 5e9,
      networkId: '*',
    },
  },
};

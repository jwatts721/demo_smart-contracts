const { Web3 } = require('web3');
const nodeUrl = 'http://localhost:8545';
const web3 = new Web3(nodeUrl);

async function main() {
  const accounts = await web3.eth.getAccounts();
  console.log(accounts);
}

main();
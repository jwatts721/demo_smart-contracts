// This script can be used to deploy the "MyContract" contract using Web3 library.
// Please make sure to compile "./contracts/MyContract.sol" file before running this script.
// And use Right click -> "Run" from context menu of the file to run the script. Shortcut: Ctrl+Shift+S

import { deploy } from './web3-lib'

(async () => {
  try {
    console.log('\n----------------------------')
    console.log('Web3 Deployment library')
    console.log('----------------------------')
    const result = await deploy('MyContract', [])
    console.log(`MyContract address: ${result.address}`)
  } catch (e) {
    console.log(e.message)
  }
})()
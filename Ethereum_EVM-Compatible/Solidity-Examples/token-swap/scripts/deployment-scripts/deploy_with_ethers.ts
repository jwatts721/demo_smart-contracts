// This script can be used to deploy the "MyContract" contract using ethers.js library.
// Please make sure to compile "./contracts/MyStorage.sol" file before running this script.
// And use Right click -> "Run" from context menu of the file to run the script. Shortcut: Ctrl+Shift+S

import { deploy } from './ethers-lib'

(async () => {
  try {
    console.log('\n----------------------------')
    console.log('Ethers Deployment library')
    console.log('----------------------------')
    const result = await deploy('MyContract', [])
    console.log(`MyContract address: ${result.address}`)
  } catch (e) {
    console.log(e.message)
  }
})()
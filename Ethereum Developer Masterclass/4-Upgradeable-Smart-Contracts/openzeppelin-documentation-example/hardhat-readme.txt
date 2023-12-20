=> HARDHAT 
    Hardhat Init with Empty Config and required modules:
        $ hardhat init
        $ npm install --save-dev @nomicfoundation/hardhat-ethers
    
    Install the Upgrades Plugin:
        $ npm install --save-dev @openzeppelin/hardhat-upgrades 

    Note: Hardhat doesn't have a native deployment system, so we use JavaScript scripts to deploy. 
        scripts/deploy_upgradeable_box.js

    Make sure you have your local blockchain node running (ie: npx hardhat node, ganache-cli, etc)
        $ npx hardhat run --network localhost scripts/deploy_upgradeable_box.js
        Note: There are a few lines in the documentation that are incorrect. 
              Review the code for the corrections. 

    Interact with the Hardhat node to check the values stored: 
        npx hardhat console --network localhost
        Welcome to Node.js v12.22.1.
        Type ".help" for more information.
        > const Box = await ethers.getContractFactory('Box');
        undefined
        > const box = await Box.attach('0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0');
        undefined
        > (await box.retrieve()).toString();
        '42'

    Create a second version of the Box contract, BoxV2.sol with a new method called "increment()"

    Next create an upgrade script that references the address of the original contract, to perform the upgrade.
    This JavaScript upgrade script file calls the "upgradeProxy" function to perform the upgrade.
        See contracts/BoxV2.sol
            scripts/upgrade_box.js

    Perform the upgrade:
        $ npx hardhat run --network localhost scripts/upgrade_box.js

    Test the new "increment" function by checking the value:
        npx hardhat console --network localhost
        Welcome to Node.js v12.22.1.
        Type ".help" for more information.
        > const BoxV2 = await ethers.getContractFactory('BoxV2');
        undefined
        > const box = await BoxV2.attach('0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0');
        undefined
        > (await box.retrieve()).toString();
        '42'
        > await box.increment();
        ...
        > (await box.retrieve()).toString();
        '43'
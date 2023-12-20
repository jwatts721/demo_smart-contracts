=> TRUFFLE
    Initialize a Truffle Project:
        $ npx truffle init

    Modify the truffle-config.js 
        - Configure the setup for the development configuration and network.
            - Use port 9545 for the local "Truffle Develop" Blockchain
        - Modify the version of solc that is compatible with the version specified in your contract

    Create the Box.sol contract in the "contracts" directory. 

    Install the Upgrades Plugin:
        $ npm install --save-dev @openzeppelin/truffle-upgrades

    Create a migratio to deploy the upgradeable Box contract
        $ npx truffle create migration deploy_upgradeable_box

        Rename the migration script to 1_deploy_upgradeable_box.js.
            This is not required, but it will be easier for specifying the number prefix.

        Modify the deployment migration script.

    Make sure a test Blockchain is running (Truffle Develop, Hardhat Node, Ganache, Ganache-CLI)
        $ truffle develop
        $ npx truffle develop 

    Run the deployment migration script
        $ npx truffle migrate --network development

    Test you contract from the Truffle console:
        $ npx truffle console --network development
        truffle(development)> const box = await Box.deployed();
        undefined
        truffle(development)> (await box.retrieve()).toString();
        '42'

    Upgrading the Box Contract:
    - We want to add a new function called "increment" so we can increase the value. 
    - Create a new contract called BoxV2. Use the code from the Box contract. 
        - Add the new "increment" function. 
    
    Create a new migration called "...upgrade_box_contract_to_v2.js"
        $ npx truffle create migration upgrade_box_contract_to_v2

        Rename the script to 2_upgrade_box_contract_to_v2.js

    Run the migration to upgrade the Box contract:
        $ npx truffle migrate --network development 

    Interact with the console to test the new functionality:
        npx truffle console --network development
        truffle(development)> const box = await Box.deployed();
        undefined
        truffle(development)> const boxV2 = await BoxV2.at(box.address);
        undefined
        truffle(development)> (await boxV2.retrieve()).toString();
        '42'
        truffle(development)> await boxV2.increment();
        truffle(development)> (await boxV2.retrieve()).toString();
        '43'

    Independent Task:
        Modified Box to add a "version" method. 

    IMPORTANT NOTE: 
        For upgradable contracts, it is important to run specific migrations so we don't rerun
        migrations, which would essentially redeploy contracts to new addresses. 
        
        Notice how the migration scripts were renamed to follow specific steps (1_, 2_, etc)

            $ npx truffle migrate --network development --f 1 --to 1
        
        The above will force only the first migration to execute. Nothing before and nothing after.
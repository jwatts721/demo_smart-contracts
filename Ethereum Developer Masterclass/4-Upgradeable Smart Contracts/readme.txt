OVERVIEW:
By default, the behaviour of Smart Contracts is immutable.

Once deployed to the blockchain, they cannot be modified.

Changes to your original code for the smart contract are deployed as a new contract. 


TECHNIQUE:
Using the concept of a "proxy", this is providing a workaround. 

This is a gatekeeper that keeps track of the latest version of the contract.

The UI will talk to the "proxy" smart contract instead of talking to the smart contract directly. 

The proxy smart contract handles the deployment of smart contracts while maintaining the latest version of the smart contract.

When you provide the UI to your clients, you want to prevent having to give them a NEW ADDRESS to the new version of the smart
contract that is deployed. The address change should be transparent to the client. 

The PROXY ADDRESS is the only address that your clients will have.

    Workflow Example:

        Original Deployment: 
            UI -> Proxy Smart Contract -> Smart Contract Version 1

        Upgrade Deployment:
            UI -> Proxy Smart Contract -X-> Smart Contract Version 1
                                        |
                                        --> Smart Contract Version 2

    Proxy Pattern:
        User ---- tx ---> Proxy ----------> Implementation_v0
                             |
                              ------------> Implementation_v1
                             |
                              ------------> Implementation_v2


RULE: Functions can be added to upgraded smart contracts, but functions CANNOT be removed.

This technique allows for changing the contact code, while preserving the state, balance and address.

RULE: Only the address of the originally deployed contract has the rights to upgrade it. 
    - This is the default, however there may be some exceptions if built into the contract. 

RULE: Upgradeable contracts cannot have a constructor. 
      OpenZeppelin Contracts provides the Initializable base contract. You can tag
      a method as "initializer".

    contract AdminBox is Initializable {
        ...
        function initialize(address admin) public initializer {
            _admin = admin;
        }
        
        constructor() initializer {}
    }

RULE: You cannot change the storage layout of upgradeable contracts. 
    If you have a state variable, you cannot remove it, change its type or declare another variable before it.

    // contracts/Box.sol
    contract Box {
        // We cannot add a new variable here

        uint256 private _value; // we cannot change this variables type, remove it or rename it

        // We can safely add a new variable after the ones we had declared
        address private _owner;

        // ...
    }

    This only applies to state variables.
    We can change functions and events without restrictions.

    Note: The upgrade process will catch any errors made when trying to change state variables incorrectly.


------------------------------------------
- OpenZeppelin Upgrades Plugin (Preferred)
------------------------------------------
    The Open Zeppelin documentation references using the Open Zeppelin Upgrades Plugin. 
        https://docs.openzeppelin.com/learn/upgrading-smart-contracts

    This can be performed using either Truffle or Hardhat. 
    There are demo examples for both. 

"deployProxy" Contract tranactions:
1 - Deploy the implementation contract (our Box contract)
2 - Deploy the ProxyAdmin contract (the admin for our proxy)
3 - Deploy the proxy contract and run any initializer function 


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


=> TRUFFLE
    Install the Upgrades Plugin:
        $ npm install --save-dev @openzeppelin/truffle-upgrades



-----------------------------
- UDEMY Example (Deprecated)
-----------------------------
    NOTE: The Udemy class references old documentation.
      The Open Zeppelin CLI is deprecated and is no longer maintained. 
        $ npx openzeppelin init

            - modify networks.js
                - update the port to match the Ganache CLI port
            
            With Ganache CLI running, execute:
                $ npx oz accounts   // <-- displays all accounts in the Ganache CLI 

        - Create contract Box.sol
            - Review the code for the Box.sol contract
        
        $ npx oz compile  // <-- modify the file .openzeppelin/project.json to set the proper compiler options 
        $ npx oz deploy     // <-- deploy all contracts
            - Prompts (regular, upgradeable, minimal)

        $ npx oz upgrade

    -- Could not continue the demo in the video, but the CLI provided a structure for upgrading the contracts.

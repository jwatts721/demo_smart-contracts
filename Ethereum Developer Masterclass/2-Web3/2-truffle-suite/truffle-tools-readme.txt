As compared to the node deployment demo, this will be the preferred way to interact with the blockchain.
This simplifies things over having to write code to perform all of the tasks in the previous demo. 

Truffle Suite:
https://trufflesuite.com/

* Ganache: Local test blockchain
    - GUI and CLI
        similar to local blockchains in:
            - Remix IDE
            - Hardhat
            - Truffle (Develop)
    - Has an RPC provider for Web 3 (port 7545)
    - Installation: 
        - You can download the package installer or application package for the GUI version
        - You can install the cli 
            $ sudo npm install -g ganache-cli

* Truffle
    - Installation:
        $ sudo npm install -g truffle

    - Provides a framework for creating smart contracts, automated testing, scriptable deployments, etc.
    - This is an advantage of using Truffle over Remix IDE
    - Scaffoliding a Truffle project
        $ truffle init
        $ truffle create contract YourContractName
        $ truffle create test YourTestName

            Note: Modify the end of the pragma statement to be "^0.8.19" to prevent invalid opcode errors

    - You can modify the Solidity version that "solc" uses to compile by modifying truffle-config.js
         compilers: {
            solc: {
            version: "0.8.19",  <-- REMEMBER: limit to 0.8.19 to prevent invalid opcode error
            ...

    - Compiling Contracts:
        $ truffle compile

        - The compiler will check and identify errors during compilation
        - A "build" directory with a JSON that contains that ABI and bytecode for your contract.
        - Compare this single command line step vs writing the JavaScript code for deploying the contract.
            - Similar to the "output" in our code, this is the output from the compiler.

    - Migrating Contracts: 
        - Migrations are used for any changes that are made to databases, in our case, the blockchain.

        - Create a migration for deploying your contract:
            $ truffle create migration YourMigrationName

        - For testing, modify the truffle-config.js and uncomment the "Development" section. Be sure to configure
          it with all the settings for your local Ganache instance. (Alternatively Hardhat, Truffle Develop, etc)
        
            $ truffle create migration InitialMigration
            $ truffle create migration MigrationForAddContract

        - Run the migration:
            $ truffle migrate      (handles compilation also, no need to run separate "truffle compile")

            When you make a change to a contract, you have 2 options for deploying the changes:
                1 - delete the build folder and migrate again - or -
                2 - Run: (preferred)
                    $ truffle migrate --reset

            Since your Truffle configuration will require you seed phrase as the mnemonic value,
            you should include it in a .env or .secret file that has limited access. 
            NEVER commit this to source control.

            Migrating to Specific Networks:
            example: deploying to sepolia

            $ truffle migrate --network sepolia

                Make sure to have all required NPM packages installed
                    example: $npm install @truffle/hdwallet-provider

    - Creating a Front-End to Interact With The Deployed Contract
        - We will leverage Truffle Boxes to use an already scaffolded React Application 
            - https://trufflesuite.com/boxes/

        Within the "frontend" directory, execute the following command:
            $ truffle unbox react       

        As of this writing (11/14/2023), the box configuration has the following directories:
            - client - the frontend React application
            - truffle - a sample Truffle project

        DEPLOY THE CONTRACT (LOCAL DEVELOPMENT BLOCKCHAIN)
        - Reconfigre the truffle-config.js to match the port for the development network. 

        - The unboxing has the Truffle project pre-configured to build the contracts into the Node.js app path

        - Modify the Solidity compiler version in truffle-config.js

        - After compilation, the contract JSON files will be under ./src/contracts 

        - Run Truffle migration, for your local development environment. Make sure Ganache is running. 
            $ truffle migrate

        RUN THE APPLICATION
        Note: This version of the Truffle Box is newer than the classroom example. See notes below.
            $ npm run start

            The React application will run and display the URL.
            When you open the application, it will ask to connect to your Metamask.

            In Metamask, change the test network to your local blockchain running on Ganache
            
            Import one of the accounts in Ganache into your Metamask wallet (for testing)
                - Import using the private key

        READING AND WRITING TO THE CONTRACT
        - Modify a value in SimpleStorage.sol (the contract value)
            - You should see the value change. 
                - Metamask will not prompt you as this is a "view" function 

        - Perform a write. Enter a value in the box of the "write" button and then click it.
            IMPORTANT: Make sure to connect the proper test account which has the test ETH.
            - Metamask will prompt you for paying the gas fee so that you can write a value to the blockchain.

        - This version of the application is already scaffolded to do what the "additional code" does as demonstrated
          in the classroom. 
        - View the functionality in the React "Demo" component.
            Read/Write Buttons - Demo/ContractBtns.jsx
            
            The code for communicating with the blockchain is defined in the EthContext



        



        
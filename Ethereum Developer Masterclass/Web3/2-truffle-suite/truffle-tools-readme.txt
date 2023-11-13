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

            
Using RemixIDE with Local File System
$ npm install -g @remix-project/remixd

Launch Remix Remix IDE
- https://remix.ethereum.org

Connecting 'remixd' with Remix IDE
$ remixd    <- users terminals current directory and can only use ethereum.org origins

$ remixd -s absolute/path/to/your/directory --remix-ide https://remix.ethereum.org

Open Remix IDE and click "Access File System"

Troubleshooting:
- On Windows, you may have to restart the Windows NAT driver
    > net stop winnat
    > net start winnat
    

Local Example:
> cd workspace
> remixd

This "workspace" directory contains the same contracts and test scripts as the default Remix IDE workspace.

COMPILING
- Right click on a contract and select "Compile"
    Question: How to compile all contracts at once

RUNNING TESTS
Solidity Tests
- In the left menu, there is a double checkmark icon
- Click the run button

JavaScript Tests
- Right click on the .js file and select "Run"


DEPLOYING CONTRACTS (Test and Mainnet networks)



Remix IDE is a good tool for writing Smart Contracts, 
but for a better development experience, you might want
to use `hardhat` or `truffle` for local development, testing, 
and deployment of your contracts. These tools provide a 
local Ethereum network, which makes it easier to test 
and debug your contracts. They also provide additional 
functionalities like console.log in your contracts.
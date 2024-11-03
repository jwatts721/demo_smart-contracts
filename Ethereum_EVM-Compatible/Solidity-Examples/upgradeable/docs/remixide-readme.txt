References:
https://remix-ide.readthedocs.io/en/latest/run_proxy_contracts.html
https://wizard.openzeppelin.com/
Bing Chat GPT-4


To create an upgradeable smart contract in Remix IDE, you can follow the steps below:

1.  Open Remix IDE in your web browser.
2.  Create a new file and name it UpgradableContract.sol.
3.  Import the necessary contracts from the OpenZeppelin library:

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

    Define the upgradable contract by creating a new contract that inherits from UUPSUpgradeable and OwnableUpgradeable:

contract UpgradableContract is UUPSUpgradeable, OwnableUpgradeable {
    // ...
}

4. Implement the "_authorizeUpgrade" and "initialize" functions:

function _authorizeUpgrade(address) internal override onlyOwner {}

function initialize(address initialOwner) initializer public {
        __Ownable_init(initialOwner);
        __UUPSUpgradeable_init();
}

5.  In Remix IDE, select the "Deploy and Run Transactions tab".
6.  Select, "Deploy with Proxy".
    Be sure to enter an address in the "INITIALOWNER" address field.
    You will be prompted that two transactions will execute.

    After deployment you will see two contracts:
        1 - Your implementation contract
        2 - Your ERC1967 proxy contract

7. To interact with the contract, do not interact with your contract directly.
   (IMPORTANT) You need to interact with the ERC1967 proxy contract.  

    You'll notice this difference when you interact with the contract directly, 
    there is no owner value. However, when you interact with the proxy contract, 
    the owner value is set.

    (IMPORTANT) Avoid using a constructor because it does not get executed in the
    proxy contract. Instead, add your initializing business logic to the "initialize"
    method.

8. Modify your contract, then Deploy using the "Upgrade with Proxy" method.
   Enter the address of your proxy contract.

   After deployment, you will see two more contracts:
    1 - Your updated implementation contract
    2 - Your upgraded ERC1967 proxy contract. 

   (IMPORTANT) 
   - Deployments of your implementation contracts will always have different address,
     however, the proxy contract address should always remain the same.

    When you execute the proxy contract, your values should remain the same.
    
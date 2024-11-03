# Example JavaScript Listener

This project demonstrates the basics of a JavaScript process subscribing to a smart
contract and listening for emitted events.

## Start the Hardhat node

In a new shell, start the Hardhat node

```shell
npx hardhat node
```

## Deploy the smart contract to the Hardhat node

Using either a script or RemixIDE, deploy the smart contract to the Hardhat node

## Start the JavaScript script which should remain running when executing

```shell
node event-listener.js
```

## Call the emitting function

Either from a test script or RemixIDE, call the function that emits the event and watch the results in the JavaScript console.

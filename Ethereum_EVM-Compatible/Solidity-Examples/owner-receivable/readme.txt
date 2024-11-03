Contract explanation:

: PAYABLE FUNCTION
The preferred method for sending month to the contract is to use payToContract().
The contract can receive money using this method.


: RECEIVE FUNCTION
Alternatively, when you define the receive() function in the contract, 
you can send money directly to the contract address. 
For example, you can open Metamask and send funds directly to the contract address.
When the receive() method is defined, there is no need for a payable function to receive funds.

:FALLBACK FUNCTION
The fallback() function is ideal for receiving funds for older versions of Solidity.
Use receive() in place of fallback().

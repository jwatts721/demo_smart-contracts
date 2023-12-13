=====================================================
Running Tests in Remix IDE: 
=====================================================

NAMING CONVENTION:
    Solidity Files:
        SomeClass_test.sol

    JavaScript Files:
        someclass.test.js


SOLIDITY TESTS:
- In the IDE, the only tests that are available to run are the ones written in Solidity. 
Select the "Double Check" mark to bring up the Unit testing tab. 
Select all tests you want to execute, and click the "Run" button. 

The result of your tests will be displayed in the "Progress" section. 

- You can run tests at the command-line using "remix-tests" package. 
  Make sure you reference the Node packages differently since Remix IDE automatically injects them.
  The command line won't have the same access to the Node packages. 
    Dev Install:
        $ npm install --save-dev remix-tests
    Dev Execution:
        $ npx remix-tests ...

    Global Install: 
        $ sudo npm install -g remix-tests
    Global Execution:
        $ remix-tests ...
    

JAVASCRIPT TESTS: 
    - You can run tests using Chai & Mocka testing framework.


=====================================
Test Example
=====================================
$ truffle unbox metacoin 

This box has an example script for Solidity and JavaScript. 

* The JavaScript option has many more options. 
 - each it() block is a separate test case. 
 
 * Make sure your test development blockchain is running and that your truffle-config.js references the correct port. 
 * Execute the tests using Truffle
   $ truffle test 

* Using $ truffle test, you can test both Solidity and JavaScript tests. 
  Solidity tests will execute first. 

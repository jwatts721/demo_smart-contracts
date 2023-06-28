const SimpleContract = artifacts.require("SimpleContract");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("SimpleContract", function (/* accounts */) {
  it("should assert true", async function () {
    await SimpleContract.deployed();
    return assert.isTrue(true);
  });

  it("should update the message", async function () {
    const simpleContract = await SimpleContract.deployed();
    const newMessage = "Hello World";
    await simpleContract.setMessage(newMessage);
    const message = await simpleContract.getMessage();
    return assert.equal(message, newMessage);
  });
});

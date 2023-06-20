const Storage = artifacts.require("Storage");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("Storage", function (/* accounts */) {
  it("should assert true", async function () {
    await Storage.deployed();
    return assert.isTrue(true);
  });

  it("should store the value 89.", async function () {
    let instance = await Storage.deployed();
    await instance.store(89);
    let storedData = await instance.retrieve();
    assert.equal(storedData, 89, "The value 89 was not stored.");
  });
});

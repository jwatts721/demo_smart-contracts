const SimpleBank = artifacts.require("SimpleBank");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("SimpleBank", function (accounts) {
  it("should assert true", async function () {
    await SimpleBank.deployed();
    return assert.isTrue(true);
  });

  it("test deposit", async function () {
    const bank = await SimpleBank.new();
    const amount = 10;
    await bank.deposit(amount);
    const balance = await bank.balance();
    assert.equal(balance, 10010);
  });

  it("test withdraw", async function () {
    const bank = await SimpleBank.new();
    const amount = 250;
    await bank.withdraw(amount);
    const balance = await bank.balance();
    assert.equal(balance, 9750);
  });
});

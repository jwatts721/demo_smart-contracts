const Owner = artifacts.require("Owner");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("Owner", function (/* accounts */) {
  it("should assert true", async function () {
    await Owner.deployed();
    return assert.isTrue(true);
  });

  it("should return the owner", async function () {
    const owner = await Owner.deployed();
    const ownerAddress = await owner.getOwner();
    // This address value may change depending on the account used to deploy the contract
    return assert.equal(ownerAddress, "0x9202E0c42239aC70881e2b52289A14AFC34378A4");
  });

  it("should change the owner", async function () {
    const owner = await Owner.deployed();
    await owner.changeOwner("0xbffE55530cBC5da8a0569bc37b5B23eC966B17BE");

    const ownerAddress = await owner.getOwner();
    assert.equal(ownerAddress, "0xbffE55530cBC5da8a0569bc37b5B23eC966B17BE");
  });
});

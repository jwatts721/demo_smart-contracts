const User = artifacts.require("User");

contract("User", accounts => {
  let user;

  beforeEach(async () => {
    user = await User.new();
  });

  it("should be deployed", async () => {
    assert(user.address !== "");
    const result = await User.deployed();
    assert.isTrue(result !== undefined, "User was NOT deployed");
  });

  it("should allow a user to set their name", async () => {
    await user.setName("Alice", {from: accounts[0]});
    const name = await user.getName({from: accounts[0]});
    assert.equal(name, "Alice", "Name was not correctly set");
  });

  it("should allow anyone to retrieve a user's name", async () => {
    await user.setName("Alice", {from: accounts[0]});
    const name = await user.getName({from: accounts[1]});
    assert.equal(name, "Alice", "Name was not correctly retrieved");
  });
});

const UserVerification = artifacts.require("UserVerification");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("UserVerification", function (accounts) {
  let userVerification;

  before(async () => {
    userVerification = await UserVerification.deployed();
  });

  it("should assert true", async function () {
    await UserVerification.deployed();
    return assert.isTrue(true);
  });

  it("should assert adding users", async () => {
    const user = accounts[1];
    const hashedVerification = web3.utils.sha3('verificationCode');

    await userVerification.addUser(user, hashedVerification);

    const isUserVerified = await userVerification.isUserVerified(user);
    const storedVerificationCode = await userVerification.getUserVerificationCode(user);

    assert.isFalse(isUserVerified, "User should not be verified");
    assert.equal(storedVerificationCode, hashedVerification, "Verification code is not stored correctly");
  });

  it("should verify the user", async () => {
    const user = accounts[2];
    const hashedVerification = web3.utils.sha3('verificationCode');

    await userVerification.addUser(user, hashedVerification);
    await userVerification.verifyUser(user, hashedVerification);

    const isUserVerified = await userVerification.isUserVerified(user);
    const storedVerificationCode = await userVerification.getUserVerificationCode(user);

    assert.isTrue(isUserVerified, "User should be verified");
    assert.equal(storedVerificationCode, hashedVerification, "Verification code is not stored correctly");
  });

  it("should assert verification failures", async () => {
    let user = accounts[3];

    let hashedVerification = web3.utils.sha3('verificationCode');
    await userVerification.addUser(user, hashedVerification);
    // Verification fails due to incorrect verification code
    try {
      await userVerification.verifyUser(user, web3.utils.sha3('wrongVerificationCode'));
      assert.fail("Verification should fail due to incorrect verification code");
    } catch (error) {
      assert.include(error.message, "revert", "Verification should fail due to incorrect verification code");
    }

    // User should already be verified
    await userVerification.verifyUser(user, hashedVerification);
    try {
      await userVerification.verifyUser(user, hashedVerification);
      assert.fail("User should already be verified");
    } catch (error) {
      assert.include(error.message, "revert", "User should already be verified");
    }
  });
});

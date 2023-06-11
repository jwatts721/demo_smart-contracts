const Marketplace = artifacts.require("Marketplace");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("Marketplace", function (accounts) {
  it("should assert true", async function () {
    await Marketplace.deployed();
    return assert.isTrue(true);
  });

  it("should assert the item availability", async () => {
    let marketplace = await Marketplace.deployed();
    let result = await marketplace.isItemAvailable();
    assert.isFalse(result);

    await marketplace.makeItemAvailable();
    let result2 = await marketplace.isItemAvailable();
    assert.isTrue(result2);
  });

  it("should assert the offers on the item", async () => {
    let marketplace = await Marketplace.deployed();
    let result = await marketplace.getAmountOffered();  
    assert.equal(result, 0);

    // Test that the amount offered is 100
    await marketplace.makeOffer(100);
    result = await marketplace.getAmountOffered();
    assert.equal(result, 100);

    // Reject the offer, the item should be available
    await marketplace.rejectOffer();
    result = await marketplace.isItemAvailable();
    assert.isTrue(result);

    // Accept the offer, the item should be unavailable
    await marketplace.makeOffer(150);
    await marketplace.acceptOffer();
    result = await marketplace.isItemAvailable();
    assert.isFalse(result);

    // Make offer when item is unavailable
    try {
      await marketplace.makeOffer(200);
      assert.fail();
    } catch (err) {
      assert.ok(/revert/.test(err.message));
    }

    // Test the amount offered is 150
    result = await marketplace.getAmountOffered();
    assert.equal(result, 150);

    // Test that the offer has been accepted
    result = await marketplace.isOfferAccepted();
    assert.isTrue(result);
  });

  it("should assert the item availability after rejecting the offer", async () => {
    let marketplace = await Marketplace.new();
    await marketplace.makeItemAvailable();
    let result = await marketplace.isItemAvailable();
    assert.isTrue(result);

    // Make offer and reject it
    await marketplace.makeOffer(100);
    await marketplace.rejectOffer();

    // Test that the item is available
    result = await marketplace.isItemAvailable();
    assert.isTrue(result);
  });

  it("should assert the failure of item availability", async () => {
    let marketplace = await Marketplace.deployed();
    let result = await marketplace.isItemAvailable();
    assert.isFalse(result);

    await marketplace.makeItemAvailable();
    result = await marketplace.isItemAvailable();
    assert.isTrue(result);

    // Assert the condition when the item is already available
    try {
      await marketplace.makeItemAvailable();
      assert.fail();
    } catch (err) {
      assert.ok(/revert/.test(err.message));
    }
  });

  it("should assert the failure of offer", async () => {
    // Create a new marketplace instance for testing because getting the deployed instance
    // will have the offer already accepted due to previous tests.
    // Note: This test will never reach the there is no amount offered condition because the buyer has not placed an offer requirement is met first.
    let marketplace = await Marketplace.new();

    // Assert the condition when there has been no offer when trying to accept
    try {
      await marketplace.acceptOffer();
      assert.fail();
    } catch (err) {
      assert.ok(/revert/.test(err.message));
    }

    // Assert the condition when there has been no offer when trying to reject
    try {
      await marketplace.rejectOffer();
      assert.fail();
    } catch (err) {
      assert.ok(/revert/.test(err.message));
    }
  });
});

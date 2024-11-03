const Ballot = artifacts.require("Ballot");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("Ballot", function (accounts) {
  it("should assert true", async function () {
    await Ballot.deployed();
    return assert.isTrue(true);
  });

  it("should be able to give right to vote", async function () {
    const ballotInstance = await Ballot.deployed();
    const voterAccount = accounts[1];

    let voter = await ballotInstance.voters(voterAccount);

    // Assert the voter has no right to vote
    assert.equal(voter.weight, 0);

    // Give the voter the right to vote
    await ballotInstance.giveRightToVote(voterAccount);

    let voterPermitted = await ballotInstance.voters(voterAccount);

    // Assert the voter has the right to vote through the weight
    assert.equal(voterPermitted.weight, 1);
  });

  it('should allow a voter to cast a vote', async () => {
    const voter = accounts[2];
    const proposalIndex = 0;

    const ballotInstance = await Ballot.deployed();

    // Give the voter the right to vote
    await ballotInstance.giveRightToVote(voter);

    // Cast the vote
    await ballotInstance.vote(proposalIndex, { from: voter });

    // Check if the vote was recorded correctly
    const voted = await ballotInstance.voters(voter);
    assert.equal(voted.voted, true, 'Voter should be marked as voted');
    assert.equal(voted.vote, proposalIndex, 'Voter should have voted for the correct proposal');
  });

  it("should be able to delegate the vote", async function () {
    const voter1 = accounts[3];
    const voter2 = accounts[4];

    const ballotInstance = await Ballot.deployed();

    // Give voter1 the right to vote
    await ballotInstance.giveRightToVote(voter1);

    // Delegate voter1's vote to voter2
    await ballotInstance.delegate(voter2, { from: voter1 });

    // Check if the delegation was recorded correctly
    const voter1Data = await ballotInstance.voters(voter1);
    assert.equal(voter1Data.voted, true, 'Voter1 should be marked as voted');
    assert.equal(voter1Data.delegate, voter2, 'Voter1 should have delegated to Voter2');

    const voter2Data = await ballotInstance.voters(voter2);
    assert.equal(voter2Data.weight, 1, 'Voter2 weight should be increased by 1');
  });

  it("should be able to count the votes", async function () {
    const voter1 = accounts[5];
    const voter2 = accounts[6];
    const voter3 = accounts[7];

    const ballotInstance = await Ballot.deployed();

    // Give the right to vote to both voters
    await ballotInstance.giveRightToVote(voter1);
    await ballotInstance.giveRightToVote(voter2);
    await ballotInstance.giveRightToVote(voter3);

    // Voters cast their votes
    await ballotInstance.vote(0, { from: voter1 });
    await ballotInstance.vote(0, { from: voter2 });
    await ballotInstance.vote(1, { from: voter3 });

    // Check the winning proposal
    const winningProposalIndex = await ballotInstance.winningProposal();
    assert.equal(winningProposalIndex, 0, 'Incorrect winning proposal index');

    // Check the name of the winning proposal
    const winnerName = await ballotInstance.winnerName();
    assert.equal(winnerName, '0x4459279c2618db3ee91787e5ed295fb82cfecd74000000000000000000000000', 'Incorrect winner name');
  });

  it("should be able to return the winner name", async function () {
    const ballotInstance = await Ballot.deployed();
    const winnerName = await ballotInstance.winnerName();
    assert.equal(winnerName, '0x4459279c2618db3ee91787e5ed295fb82cfecd74000000000000000000000000', 'Incorrect winner name');
  });
});

const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Gas griefing test", function () {
  let deployer, attacker, user1, user2;

  beforeEach(async function () {
    [deployer, attacker, user1, user2] = await ethers.getSigners();

    const AuctionContract = await ethers.getContractFactory("Auction", deployer);
    this.auction = await AuctionContract.deploy();

    this.auction.bid({ value: 100 });
  });

  describe("Auction", function () {

    describe("Auction basic tests", function () {
      it("Should NOT accept bids lower than highest", async function () {
        await expect(this.auction.connect(user1).bid({ value: 50 })).to.be.revertedWith("Bid is less than highest bid");
      });
      it("Should update new highestBid", async function () {
        await this.auction.connect(user1).bid({ value: 150 });
        expect(await this.auction.highestBid()).to.eq(150);
      });
      it("Should set msg.sender as highestBidder", async function () {
        await this.auction.connect(user1).bid({ value: 150 });
        expect(await this.auction.highestBidder()).to.eq(user1.address);
      });
    });

    describe("perform attack", function () {
      it("Should perform the gas griefing attack", async function () {

        await this.auction.connect(user1).bid({ value: 150 });
        expect(await this.auction.highestBidder()).to.eq(user1.address);

        const AttackerContract = await ethers.getContractFactory("Attacker", attacker);
        let attackerContract = await AttackerContract.deploy();

        await attackerContract.connect(attacker).attack(this.auction.address, {value: 300});
        expect(await this.auction.highestBidder()).to.eq(attackerContract.address);

        await this.auction.connect(user2).bid({ value: 400 });
        expect(await this.auction.highestBidder()).to.eq(user2.address);
      });
    });
  });
});

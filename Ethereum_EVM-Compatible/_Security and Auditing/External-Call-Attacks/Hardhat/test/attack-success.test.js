const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Successful Reentrancy", function () {
  let deployer, user, attacker;

  beforeEach(async function () {
    [deployer, user, attacker] = await ethers.getSigners();

    const Wallet = await ethers.getContractFactory("Wallet", deployer);
    this.wallet = await Wallet.deploy();

    await this.wallet.deposit({ value: ethers.utils.parseEther("100") });
    await this.wallet.connect(user).deposit({ value: ethers.utils.parseEther("50") });

    const Attacker = await ethers.getContractFactory("Attacker", attacker);
    this.attacker = await Attacker.deploy(this.wallet.address);
  });

  describe("wallet tests", function () {
    it("Should be able to deposit ether", async function () {
      const deployerBalance = await this.wallet.balanceOf(deployer.address);
      expect(deployerBalance).to.eq(ethers.utils.parseEther("100"));

      const userBalance = await this.wallet.balanceOf(user.address);
      expect(userBalance).to.eq(ethers.utils.parseEther("50"));
    });

    it("Should be able to withdraw", async function () {
      await this.wallet.withdraw();

      const deployerBalance = await this.wallet.balanceOf(deployer.address);
      const userBalance = await this.wallet.balanceOf(user.address);

      expect(deployerBalance).to.eq(0);
      expect(userBalance).to.eq(ethers.utils.parseEther("50"));
    });

    it("Perform wallet Attack", async function () {
      console.log("");
      console.log("Before :");
      console.log(`wallet's balance: ${ethers.utils.formatEther(await ethers.provider.getBalance(this.wallet.address)).toString()}`);
      console.log(`Attacker's balance: ${ethers.utils.formatEther(await ethers.provider.getBalance(attacker.address)).toString()}`);

      await this.attacker.attack({ value: ethers.utils.parseEther("10") });

      console.log("");
      console.log("After: ");
      console.log(`wallet's balance: ${ethers.utils.formatEther(await ethers.provider.getBalance(this.wallet.address)).toString()}`);
      console.log(`Attacker's balance: ${ethers.utils.formatEther(await ethers.provider.getBalance(attacker.address)).toString()}`);
      console.log("");

      expect(await ethers.provider.getBalance(this.wallet.address)).to.eq(0);
    });
  });
});

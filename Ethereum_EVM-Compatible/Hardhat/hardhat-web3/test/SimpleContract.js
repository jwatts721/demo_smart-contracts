const { expect } = require("chai");

describe("SimpleContract contract", function () {
    it("Should update the message", async function () {
        const Token  = await ethers.getContractFactory("SimpleContract");
        const token = await Token.deploy("Hello, world!");
        await token.deployed();

        await token.updateMessage("This is a test...");
        let result = await token.getMessage();
        expect(result).to.equal("This is a test...");
    });
});
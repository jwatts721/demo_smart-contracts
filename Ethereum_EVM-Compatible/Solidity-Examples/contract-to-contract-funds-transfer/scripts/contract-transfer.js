const { ethers } = require("hardhat");

const SENDER_CONTRACT_ADDRESS = "0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8";
const RECEIVER_CONTRACT_ADDRESS = "0xd9145CCE52D386f254917e481eB44e9943F39138";

async function main() {
    const senderContract = await ethers.getContractAt("Sender", SENDER_CONTRACT_ADDRESS);
    let balance = await senderContract.getBalance();
    console.log("Sender Contract Balance: ", balance.toString());

    const receiverContract = await ethers.getContractAt("Receiver", RECEIVER_CONTRACT_ADDRESS);
    balance = await receiverContract.getBalance();
    console.log("Receiver Contract Balance: ", balance.toString());

    console.log('Transferring 2 ETH from Sender to Receiver');
    const result = await senderContract.sendContractEther(
        RECEIVER_CONTRACT_ADDRESS,
        2000000000000000000n
    );
    await result.wait();

    balance = await senderContract.getBalance();
    console.log("Sender Contract Updated Balance: ", balance.toString());

    balance = await receiverContract.getBalance();
    console.log("Receiver Contract Updated Balance: ", balance.toString());
};

main()
    .then(() => {
        process.exit(0);
    })
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
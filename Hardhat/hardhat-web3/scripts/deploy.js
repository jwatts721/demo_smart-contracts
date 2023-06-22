// { ethers } is in the global scope

async function main() {
  // Get the contract factory
  const SimpleContract = await ethers.getContractFactory("SimpleContract");

  // Deploy the contract
  const simpleContract = await SimpleContract.deploy("Initial message");
  await simpleContract.deployed();

  console.log("Contract deployed to address:", simpleContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

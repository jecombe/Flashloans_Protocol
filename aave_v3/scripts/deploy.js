// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const FlashLoan = await hre.ethers.getContractFactory("FlashLoan");
  // instant of our contract
  const flashLoan = await FlashLoan.deploy(
    "0x2f39d218133AFaB8F2B819B1066c7E434Ad94E9e" //Mainnet ethereum
  ); // here is we pass the provider address

  await flashLoan.deployed();
  console.log("Flash Loan contract deployed: ", flashLoan.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

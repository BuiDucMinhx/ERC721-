const hre = require("hardhat");

async function main(){
  const NFT = await hre.ethers.getContractFactory("NFT");
  const bot = await NFT.deploy("BOT","B");

  await bot.deployed();
  console.log("Success deployed smart contract to:", bot.address);

  // await bot.mint("https://ipfs.io/ipfs/QmZt2U2AyzepEXYZM4QykeQ1rzUeBsPcCdGPjVyr2fvubX");
  // console.log("deploy successfully minted");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
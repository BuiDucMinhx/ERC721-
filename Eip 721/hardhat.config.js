require("@nomiclabs/hardhat-ethers");
const privateKey = "4c4b343553304cfa563002cd3a832d63e7b5438c06911add64dc15c86c44a1a7";
module.exports = {
  defaultNetwork: "matic",
  networks: {
    hardhat: {
    },
    matic: {
      url: "https://rpc-mumbai.maticvigil.com",
      accounts: [privateKey]
    }
  },
  solidity: {
    version: "0.8.2",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
}
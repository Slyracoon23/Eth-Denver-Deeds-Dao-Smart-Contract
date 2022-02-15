require("@nomiclabs/hardhat-waffle");
require('dotenv').config()
require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-ganache");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  // defaultNetwork: "ganache",
  solidity: {
    version: "0.8.5",
    settings: {
      optimizer: {
        enabled: true,
        runs: 1000
      }
    }
  },
  networks: {
    ganache: {
      url: "http://127.0.0.1:8545",
      // accounts: [process.env.PRIVATE_KEY]
    }
  },
  //   goerli: {
  //     url: process.env.INFURA,
  //     accounts: [process.env.PRIVATE_KEY],
  //     gas: 2100000,
  //     gasPrice: 8000000000
  //   }
  // },
  // etherscan: {
  //   apiKey: process.env.ETHERSCAN_API_KEY
  // }
};


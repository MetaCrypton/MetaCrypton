require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

const PRIVATE_KEY = process.env.PRIVATE_KEY;

module.exports = {
  solidity: "0.8.4",
  settings: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  },
  networks: {
    goerli: {
      url: `https://goerli.infura.io/v3/31c3397beb4146e4acc9f4a072da5d23`,
      accounts: [`${PRIVATE_KEY}`],
      timeout: 100000
    },
    kovan: {
      url: `https://kovan.infura.io/v3/31c3397beb4146e4acc9f4a072da5d23`,
      accounts: [`${PRIVATE_KEY}`],
      timeout: 100000
    },
    ropsten: {
      url: `https://ropsten.infura.io/v3/31c3397beb4146e4acc9f4a072da5d23`,
      accounts: [`${PRIVATE_KEY}`],
      timeout: 100000
    },
    bsc_testnet: {
      url: `https://data-seed-prebsc-1-s1.binance.org:8545/`,
      accounts: [`${PRIVATE_KEY}`],
      timeout: 100000
    },
  },
  mocha: {
    timeout: 20000
  }
};

# Meta Crypton

## Setup

```bash
# Install Node.js & npm

# Install local node dependencies:
$ npm install

# Set private key:
$ echo -n "PRIVATE_KEY=0x7ff8c90cb78ec105f8987f450cf0df4a66dea8497df750f1fec1ecb1b789336a" > .env

# Run tests:
$ npm run test

# Deploy to $network (goerli/kovan/ropsten/bsc_testnet)
npx hardhat run scripts/deploy.js  --network $network
```


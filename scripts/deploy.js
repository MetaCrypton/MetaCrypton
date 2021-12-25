const hre = require("hardhat");

async function deploy(contractName, deployer, ...args) {
    const Factory = await hre.ethers.getContractFactory(contractName, deployer)
    const instance = await Factory.deploy(...args)
    return instance.deployed()
}

function getIndexedEventArgsRAW(coder, tx, eventSignature, eventNotIndexedParams) {
    const sig = hre.ethers.utils.keccak256(hre.ethers.utils.toUtf8Bytes(eventSignature));
    const log = getLogByFirstTopic(tx, sig);
    return coder.decode(
        eventNotIndexedParams,
        log.data
    );
}

function getIndexedEventArgs(tx, eventSignature, topic) {
    const sig = hre.ethers.utils.keccak256(hre.ethers.utils.toUtf8Bytes(eventSignature));
    const log = getLogByFirstTopic(tx, sig);
    return log.args[topic];
}

function getLogByFirstTopic(tx, firstTopic) {
    const logs = tx.events;

    for(let i = 0; i < logs.length; i++) {
        if(logs[i].topics[0] === firstTopic){
            return logs[i];
        }
    }
    return null;
}

async function main() {
    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    console.log("Account balance:", (await deployer.getBalance()).toString());

    const governance = await deploy("Governance", deployer);
    console.log("Governance: ", governance.address);
    const erc721 = await deploy("ERC721", deployer, "Loot", "LOOT");
    console.log("Test simple ERC721: ", erc721.address);

    const coder = hre.ethers.utils.defaultAbiCoder;

    const upgradesRegistryInit = await deploy("UpgradesRegistryInit", deployer);
    const upgradesRegistryProxy = await deploy("UpgradesRegistryProxy", deployer, upgradesRegistryInit.address);

    const upgradesRegistryInitializable = await hre.ethers.getContractAt("IInitializable", upgradesRegistryProxy.address);
    const upgradesRegistryUpgrade = await hre.ethers.getContractAt("IUpgrade", upgradesRegistryProxy.address);
    const upgradesRegistryUpgradable = await hre.ethers.getContractAt("IUpgradable", upgradesRegistryProxy.address);
    const upgradesRegistry = await hre.ethers.getContractAt("IUpgradesRegistry", upgradesRegistryProxy.address);
    console.log("Upgrades registry: ", upgradesRegistry.address);

    await upgradesRegistryInitializable.initialize(coder.encode(["address"], [governance.address]));
    console.log("Upgrades registry initialized");

    const inventoryInit = await deploy("InventoryInit", deployer);
    const inventoryEther = await deploy("InventoryEther", deployer);
    const inventoryLootbox = await deploy("InventoryLootbox", deployer);

    await upgradesRegistry.registerUpgrade(inventoryEther.address);
    await upgradesRegistry.registerUpgrade(inventoryLootbox.address);
    console.log("Inventory upgrades registered");

    const nftInit = await deploy("NFTInit", deployer);
    const nftLootbox = await deploy("NFTLootbox", deployer);
    await upgradesRegistry.registerUpgrade(nftLootbox.address);
    console.log("NFT upgrades registered");

    const nftFactoryInit = await deploy("NFTFactoryInit", deployer);
    const nftFactoryProxy = await deploy("NFTFactoryProxy", deployer, nftFactoryInit.address);

    const nftFactoryInitializable = await hre.ethers.getContractAt("IInitializable", nftFactoryProxy.address);
    const nftFactoryUpgrade = await hre.ethers.getContractAt("IUpgrade", nftFactoryProxy.address);
    const nftFactoryUpgradable = await hre.ethers.getContractAt("IUpgradable", nftFactoryProxy.address);
    const nftFactory = await hre.ethers.getContractAt("INFTFactory", nftFactoryProxy.address);
    console.log("NFT Factory: ", nftFactory.address);

    await nftFactoryInitializable.initialize(coder.encode(
        ["address", "address", "address", "address"],
        [deployer.address, upgradesRegistry.address, nftInit.address, inventoryInit.address]
    ));

    let tx = await nftFactory.deployToken(
        "Token name",
        "TKN",
        "uri",
        deployer.address,
        [0],
        [0, 1]
    );
    let result = await tx.wait();
    const eventArgs = getIndexedEventArgsRAW(
        coder,
        result,
        "TokenDeployed(string,string,string,address,address)",
        ["string", "string", "string", "address", "address"],
    );
    const nftAddress = eventArgs[4];
    const nft = await hre.ethers.getContractAt("INFT", nftAddress);
    console.log("NFT: ", nft.address);

    const nftLootboxInterface = await hre.ethers.getContractAt("INFTLootbox", nft.address);
    await nftLootboxInterface.setLootNFT(erc721.address);

    tx = await nft.mint(deployer.address);
    result = await tx.wait();
    const tokenId = getIndexedEventArgs(
        result,
        "Transfer(address,address,uint256)",
        2,
    );
    console.log("nft1 minted");

    const inventoryAddress = await nft.inventoryOf(tokenId.toHexString());

    const inventoryLootboxInterface = await hre.ethers.getContractAt("IInventoryLootbox", inventoryAddress);
    await inventoryLootboxInterface.reveal();

    const inventory = await hre.ethers.getContractAt("IInventory", inventoryAddress);
    console.log("Inventory of nft1: ", inventory.address);

    console.log("Account balance:", (await deployer.getBalance()).toString());
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });

const { expect, assert } = require("chai");
const { ethers, waffle } = require("hardhat");
const { keccak256 } = require('@ethersproject/solidity');

describe("Integration", function() {
    this.timeout(20000)

    let admin, alice, bob, charlie;
    let coder;

    let upgradesRegistry;
    let upgradesRegistryUpgrade;
    let upgradesRegistryUpgradable;

    let nftInterface;

    let inventoryInterface;
    let inventoryInit;

    let nftFactoryProxy;
    let nftFactoryUpgrade;
    let nftFactoryUpgradable;

    let governance;

    let nft;

    let erc721;

    async function deploy(contractName, ...args) {
        const Factory = await ethers.getContractFactory(contractName, admin)
        const instance = await Factory.deploy(...args)
        return instance.deployed()
    }

    function getIndexedEventArgsRAW(tx, eventSignature, eventNotIndexedParams) {
        const sig = ethers.utils.keccak256(ethers.utils.toUtf8Bytes(eventSignature));
        const log = getLogByFirstTopic(tx, sig);
        return coder.decode(
            eventNotIndexedParams,
            log.data
        );
    }

    function getIndexedEventArgs(tx, eventSignature, topic) {
        const sig = ethers.utils.keccak256(ethers.utils.toUtf8Bytes(eventSignature));
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

    it("Deploy Governance", async function() {
        governance = await deploy("Governance");
    });

    it("Deploy erc721", async function() {
        erc721 = await deploy("ERC721", "Loot", "LOOT");
    });

    it("Deploy Upgrades Registry", async function() {
        [admin, alice, bob, charlie] = await ethers.getSigners();
        coder = ethers.utils.defaultAbiCoder;

        const upgradesRegistryInterface = await deploy("Interface");
        const upgradesRegistryInit = await deploy("UpgradesRegistryInit");
        const upgradesRegistryProxy = await deploy("UpgradesRegistryProxy", upgradesRegistryInterface.address, upgradesRegistryInit.address, governance.address);

        const upgradesRegistryInitializable = await ethers.getContractAt("IInitializable", upgradesRegistryProxy.address);
        upgradesRegistryUpgrade = await ethers.getContractAt("IUpgrade", upgradesRegistryProxy.address);
        upgradesRegistryUpgradable = await ethers.getContractAt("IUpgradable", upgradesRegistryProxy.address);
        upgradesRegistry = await ethers.getContractAt("IUpgradesRegistry", upgradesRegistryProxy.address);

        await upgradesRegistryInitializable.initialize([]);
    });

    it("Deploy inventory upgrades and register in Upgrades registry", async function() {
        inventoryInit = await deploy("InventoryInit");
        inventoryInterface = await deploy("Interface");
        const inventoryEther = await deploy("InventoryEther");
        const inventoryLootbox = await deploy("InventoryLootbox");

        await upgradesRegistry.registerUpgrade(inventoryEther.address);
        await upgradesRegistry.registerUpgrade(inventoryLootbox.address);
    });

    it("Deploy nft setup and factory", async function() {
        nftInterface = await deploy("Interface");
        const nftInit = await deploy("NFTInit");
        const nftERC721 = await deploy("NFTERC721");
        const nftLootbox = await deploy("NFTLootbox");
        await upgradesRegistry.registerUpgrade(nftERC721.address);
        await upgradesRegistry.registerUpgrade(nftLootbox.address);

        const nftFactoryInterface = await deploy("Interface");
        const nftFactoryInit = await deploy("NFTFactoryInit");
        nftFactoryProxy = await deploy("NFTFactoryProxy", nftFactoryInterface.address, nftFactoryInit.address, admin.address);

        const nftFactoryInitializable = await ethers.getContractAt("IInitializable", nftFactoryProxy.address);
        nftFactoryUpgrade = await ethers.getContractAt("IUpgrade", nftFactoryProxy.address);
        nftFactoryUpgradable = await ethers.getContractAt("IUpgradable", nftFactoryProxy.address);
        nftFactory = await ethers.getContractAt("INFTFactory", nftFactoryProxy.address);

        await nftFactoryInitializable.initialize(coder.encode(
            ["address", "address", "address"],
            [upgradesRegistry.address, nftInit.address, inventoryInit.address]
        ));
    });

    it("Deploy nft contract", async function() {
        const tx = await nftFactory.deployToken(
            [
                "Token name",
                "TKN",
                "uri"
            ],
            nftInterface.address,
            admin.address,
            inventoryInterface.address,
            [0, 1],
            [0, 1]
        );
        const result = await tx.wait();
        const eventArgs = getIndexedEventArgsRAW(
            result,
            "TokenDeployed(string,string,string,address,address)",
            ["string", "string", "string", "address", "address"],
        );
        const nftAddress = eventArgs[4];
        nft = await ethers.getContractAt("INFT", nftAddress);
    });

    it("Set lootbox, mint nft, reveal lootbox", async function() {
        const nftLootbox = await ethers.getContractAt("INFTLootbox", nft.address);
        await nftLootbox.setLootNFT(erc721.address);

        const tx = await nft.mint(admin.address);
        const result = await tx.wait();
        const tokenId = getIndexedEventArgs(
            result,
            "Transfer(address,address,uint256)",
            2,
        );

        const inventoryAddress = await nft.inventoryOf(tokenId.toHexString());

        const inventoryLootbox = await ethers.getContractAt("IInventoryLootbox", inventoryAddress);
        await inventoryLootbox.reveal();

        const inventory = await ethers.getContractAt("IInventory", inventoryAddress);
        const tokens = await inventory.getERC721s(0, 3);
        assert.equal(tokens.length, 3);

        assert.equal(await erc721.ownerOf(tokens[0][1].toHexString()), inventory.address);
        assert.equal(await erc721.ownerOf(tokens[1][1].toHexString()), inventory.address);
        assert.equal(await erc721.ownerOf(tokens[2][1].toHexString()), inventory.address);
    });
});
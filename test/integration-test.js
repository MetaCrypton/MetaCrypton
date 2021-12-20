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

    let inventoryInit;
    let inventoryEther;

    let nftFactoryProxy;
    let nftFactoryUpgrade;
    let nftFactoryUpgradable;

    let governance;

    let nft;

    async function deploy(contractName, ...args) {
        const Factory = await ethers.getContractFactory(contractName, admin)
        const instance = await Factory.deploy(...args)
        return instance.deployed()
    }

    function getIndexedEventArgs(tx, eventSignature, eventNotIndexedParams) {
        const sig = ethers.utils.keccak256(ethers.utils.toUtf8Bytes(eventSignature));
        const log = getLogByFirstTopic(tx, sig);
        return coder.decode(
            eventNotIndexedParams,
            log.data
        );
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

    it("Deploy Upgrades Registry", async function() {
        [admin, alice, bob, charlie] = await ethers.getSigners();
        coder = ethers.utils.defaultAbiCoder;

        const upgradesRegistryInit = await deploy("UpgradesRegistryInit");
        const upgradesRegistryProxy = await deploy("UpgradesRegistryProxy", upgradesRegistryInit.address);

        const upgradesRegistryInitializable = await ethers.getContractAt("IInitializable", upgradesRegistryProxy.address);
        upgradesRegistryUpgrade = await ethers.getContractAt("IUpgrade", upgradesRegistryProxy.address);
        upgradesRegistryUpgradable = await ethers.getContractAt("IUpgradable", upgradesRegistryProxy.address);
        upgradesRegistry = await ethers.getContractAt("IUpgradesRegistry", upgradesRegistryProxy.address);

        await upgradesRegistryInitializable.initialize(coder.encode(["address"], [governance.address]));
    });

    it("Deploy inventory upgrades and register in Upgrades registry", async function() {
        inventoryInit = await deploy("InventoryInit");
        inventoryEther = await deploy("InventoryEther");

        await upgradesRegistry.registerUpgrade(inventoryEther.address);
    });

    it("Deploy nft setup and factory", async function() {
        const nftInit = await deploy("NFTInit");
        const nftFactoryInit = await deploy("NFTFactoryInit");
        nftFactoryProxy = await deploy("NFTFactoryProxy", nftFactoryInit.address);

        const nftFactoryInitializable = await ethers.getContractAt("IInitializable", nftFactoryProxy.address);
        nftFactoryUpgrade = await ethers.getContractAt("IUpgrade", nftFactoryProxy.address);
        nftFactoryUpgradable = await ethers.getContractAt("IUpgradable", nftFactoryProxy.address);
        nftFactory = await ethers.getContractAt("INFTFactory", nftFactoryProxy.address);

        await nftFactoryInitializable.initialize(coder.encode(
            ["address", "address", "address", "address"],
            [admin.address, upgradesRegistry.address, nftInit.address, inventoryInit.address]
        ));
    });

    it("Deploy nft contract", async function() {
        const tx = await nftFactory.deployToken(
            "Token name",
            "TKN",
            "uri",
            admin.address
        );
        const result = await tx.wait();
        const eventArgs = getIndexedEventArgs(
            result,
            "TokenDeployed(string,string,string,address,address)",
            ["string", "string", "string", "address", "address"],
        );
        const nftAddress = eventArgs[4];
        nft = await ethers.getContractAt("INFT", nftAddress);
    });

    it("Mint nft", async function() {
        await nft.mint(admin.address);
    });
});
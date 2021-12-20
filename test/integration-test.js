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

    let governance;

    async function deploy(contractName, ...args) {
        const Factory = await ethers.getContractFactory(contractName, admin)
        const instance = await Factory.deploy(...args)
        return instance.deployed()
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

    it("Deploy nft proxy and upgrades", async function() {
        const nftInit = await deploy("NFTInit");
        const nftProxy = await deploy("NFTProxy",
            "NFT",
            "NFT",
            "uri",
            nftInit.address
        );

        const nftInitializable = await ethers.getContractAt("IInitializable", nftProxy.address);
        nftUpgrade = await ethers.getContractAt("IUpgrade", nftProxy.address);
        nftUpgradable = await ethers.getContractAt("IUpgradable", nftProxy.address);
        nft = await ethers.getContractAt("INFT", nftProxy.address);

        await nftInitializable.initialize(coder.encode(
            ["address", "address", "address"],
            [admin.address, upgradesRegistry.address, inventoryInit.address]
        ));
    });

    it("Mint nft", async function() {
        await nft.mint(admin.address);
    });
});
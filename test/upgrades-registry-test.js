const { expect, assert } = require("chai");
const { ethers, waffle } = require("hardhat");
const { keccak256 } = require('@ethersproject/solidity');

describe("Upgrades registry", function() {
    this.timeout(20000)

    let admin, alice, bob, charlie;
    let coder;

    let upgradesRegistry;
    let upgradesRegistryUpgrade;
    let upgradesRegistryUpgradable;

    let test2;
    let test;
    let testUpgrade;
    let testUpgradable;

    async function deploy(contractName, ...args) {
        const Factory = await ethers.getContractFactory(contractName, admin)
        const instance = await Factory.deploy(...args)
        return instance.deployed()
    }

    it("Deploy Upgrades Registry", async function() {
        [admin, alice, bob, charlie] = await ethers.getSigners();
        coder = ethers.utils.defaultAbiCoder;

        const upgradesRegistryCoreInterface = await deploy("UpgradesRegistryCoreInterface");
        const upgradesRegistryInit = await deploy("UpgradesRegistryInit");
        const upgradesRegistryProxy = await deploy("UpgradesRegistryProxy", upgradesRegistryCoreInterface.address, upgradesRegistryInit.address, admin.address);

        const upgradesRegistryInitializable = await ethers.getContractAt("IInitializable", upgradesRegistryProxy.address);
        upgradesRegistryUpgrade = await ethers.getContractAt("IUpgrade", upgradesRegistryProxy.address);
        upgradesRegistryUpgradable = await ethers.getContractAt("IUpgradable", upgradesRegistryProxy.address);
        upgradesRegistry = await ethers.getContractAt("IUpgradesRegistry", upgradesRegistryProxy.address);

        await upgradesRegistryInitializable.initialize([]);
    });

    it("Deploy test proxy and upgrades", async function() {
        const testInterface = await deploy("Interface");
        const test1 = await deploy("Test1");
        test2 = await deploy("Test2");
        testProxy = await deploy("TestProxy", testInterface.address, test1.address, admin.address);

        const testInitializable = await ethers.getContractAt("IInitializable", testProxy.address);
        testUpgrade = await ethers.getContractAt("IUpgrade", testProxy.address);
        testUpgradable = await ethers.getContractAt("IUpgradable", testProxy.address);
        test = await ethers.getContractAt("ITest", testProxy.address);

        await testInitializable.initialize(coder.encode(["address"], [upgradesRegistry.address]));
    });

    it("Register test proxy in Upgrades Registry and upgrade it", async function() {
        await upgradesRegistry.registerProxy(test.address);

        assert.equal(await upgradesRegistry.isProxyRegistered(test.address), true);
        assert.equal(await upgradesRegistry.isProxyRegistered(test2.address), false);

        await upgradesRegistry.registerUpgrade(test2.address);

        assert.deepEqual(await upgradesRegistry.getProxyCurrentUpgrades(test.address), []);
        assert.equal(await upgradesRegistry.getProxyMaxPossibleUpgradeIndex(
            await testUpgrade.getProxyId()
        ), 0);

        await testUpgradable.upgrade(0);
        assert.deepEqual(await upgradesRegistry.getProxyCurrentUpgrades(test.address), [ethers.BigNumber.from(0)]);
    });
});
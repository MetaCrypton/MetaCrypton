// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IUpgradesRegistryEvents {
    event ProxyRegistered(bytes32 indexed proxyId, address indexed proxyAddress);

    event UpgradeRegistered(bytes32 indexed proxyId, address indexed upgradeAddress, uint256 indexed upgradeIndex);

    event ProxyUpgraded(address indexed proxyAddress, uint256 indexed upgradeIndex);
}

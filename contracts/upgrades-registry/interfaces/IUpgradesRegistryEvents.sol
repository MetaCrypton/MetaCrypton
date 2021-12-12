// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

interface IUpgradesRegistryEvents {
    event UpgradeRegistered(bytes32 indexed proxyId, address indexed upgradeAddress, uint256 indexed upgradeIndex);
    event ProxyRegistered(bytes32 indexed proxyId, address indexed proxyAddress);
    event ProxyUpgraded(address indexed proxyAddress, uint256 indexed upgradeIndex);
}

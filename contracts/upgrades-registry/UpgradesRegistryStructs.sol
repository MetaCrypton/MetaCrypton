// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

struct StoredProxy {
    bytes32 proxyId;
    uint256[] currentUpgradesList;
}

struct Upgrades {
    address[] upgradesAddresses;
    mapping(address => uint256) upgradesIndexes;
}

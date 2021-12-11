// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "./IUpgradesRegistryEvents.sol";

interface IUpgradesRegistryUpgrades is IUpgradesRegistryEvents {
    function registerUpgrade(address upgradeAddress) external;

    function upgradeProxy(uint256 upgradeIndex) external returns (address upgradeAddress);

    function getProxyCurrentUpgrades(address proxyAddress) external view returns (uint256[] memory upgradesIndexes);

    function getProxyMaxPossibleUpgradeIndex(bytes32 proxyId) external view returns (uint256 index);
}

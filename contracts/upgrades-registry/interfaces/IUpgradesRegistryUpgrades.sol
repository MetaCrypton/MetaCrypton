// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IUpgradesRegistryUpgrades {
    function registerUpgrade(address upgradeAddress) external;

    function upgradeProxy(uint256 upgradeIndex) external returns (address upgradeAddress);

    function getProxyCurrentUpgrades(address proxyAddress) external view returns (uint256[] memory upgradesIndexes);

    function getProxyMaxPossibleUpgradeIndex(bytes32 proxyId) external view returns (uint256 index);
}

// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../UpgradesRegistryStructs.sol";
import "../../common/upgradability/IUpgradableStaticMethods.sol";
import "../../common/upgradability/IUpgradeStaticMethods.sol";

interface IUpgradesRegistryProxiesStaticMethods {
    function getProxyId_(address proxyAddress) external view returns (bytes32);

    function isProxyRegistered_(address proxyAddress) external view returns (bool);
}

interface IUpgradesRegistryUpgradesStaticMethods {
    function getProxyCurrentUpgrades_(address proxyAddress) external view returns (uint256[] memory upgradesIndexes);

    function getProxyMaxPossibleUpgradeIndex_(bytes32 proxyId) external view returns (uint256 index);
}

interface IUpgradesRegistryStaticMethods is
    IUpgradesRegistryProxiesStaticMethods,
    IUpgradesRegistryUpgradesStaticMethods,
    IUpgradableStaticMethods,
    IUpgradeStaticMethods
{}

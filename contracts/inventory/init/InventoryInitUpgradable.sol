// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./InventoryInitOwnership.sol";
import "../../upgrades-registry/interfaces/IUpgradesRegistry.sol";
import "../../common/upgradability/IUpgrade.sol";
import "../../common/upgradability/IUpgradable.sol";


contract InventoryInitUpgradable is
    IUpgradable,
    InventoryInitOwnership
{
    function upgrade(uint256 upgradeIndex) external override isOwner {
        address upgradeAddress = IUpgradesRegistry(_upgradesRegistry).upgradeProxy(upgradeIndex);
        _methods[IUpgrade(address(0x00)).applyUpgrade.selector] = upgradeAddress;
        IUpgrade(address(this)).applyUpgrade();

        delete _methods[IUpgrade(address(0x00)).applyUpgrade.selector];
    }

    function getCurrentUpgrades() external view override returns (uint256[] memory) {
        return IUpgradesRegistry(_upgradesRegistry).getProxyCurrentUpgrades(address(this));
    }

    function getMaxPossibleUpgradeIndex() external view override returns (uint256) {
        return IUpgradesRegistry(_upgradesRegistry).getProxyMaxPossibleUpgradeIndex(PROXY_ID);
    }
}
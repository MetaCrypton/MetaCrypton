// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "../../../NFTFactoryStorage.sol";
import "../../../../upgrades-registry/interfaces/IUpgradesRegistry.sol";
import "../../../../common/governance/Governable.sol";
import "../../../../common/upgradability/IUpgrade.sol";
import "../../../../common/upgradability/IUpgradable.sol";
import "../../../../common/upgradability/IUpgradableStaticMethods.sol";

contract NFTFactoryInitUpgradable is IUpgradable, IUpgradableStaticMethods, Governable, NFTFactoryStorage {
    function upgrade(uint256 upgradeIndex) external override requestPermission {
        address upgradeAddress = IUpgradesRegistry(_upgradesRegistry).upgradeProxy(upgradeIndex);
        _methods[IUpgrade(address(0x00)).applyUpgrade.selector] = upgradeAddress;
        IUpgrade(address(this)).applyUpgrade();

        delete _methods[IUpgrade(address(0x00)).applyUpgrade.selector];
    }

    function getCurrentUpgrades_() external view override returns (uint256[] memory) {
        return getCurrentUpgrades();
    }

    function getMaxPossibleUpgradeIndex_() external view override returns (uint256) {
        return getMaxPossibleUpgradeIndex();
    }

    function getCurrentUpgrades() public view override returns (uint256[] memory) {
        return IUpgradesRegistry(_upgradesRegistry).getProxyCurrentUpgrades(address(this));
    }

    function getMaxPossibleUpgradeIndex() public view override returns (uint256) {
        return IUpgradesRegistry(_upgradesRegistry).getProxyMaxPossibleUpgradeIndex(PROXY_ID);
    }
}

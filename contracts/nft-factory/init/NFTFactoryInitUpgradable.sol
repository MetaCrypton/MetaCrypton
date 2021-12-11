// SPDX-License-Identifier: MIT
// Copyright Anton "BaldyAsh" Grigorev
pragma solidity ^0.8.0;

import "../NFTFactoryStorage.sol";
import "../../upgrades-registry/interfaces/IUpgradesRegistry.sol";
import "../../common/governance/Governable.sol";
import "../../common/upgradability/IUpgrade.sol";
import "../../common/upgradability/IUpgradable.sol";


contract NFTFactoryInitUpgradable is
    IUpgradable,
    Governable,
    NFTFactoryStorage
{
    function upgrade(uint256 upgradeIndex) external override isGovernance {
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
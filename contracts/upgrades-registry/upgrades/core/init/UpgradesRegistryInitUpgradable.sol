// SPDX-License-Identifier: Apache 2.0
// Copyright © 2021 Anton "BaldyAsh" Grigorev. All rights reserved.
pragma solidity ^0.8.0;

import "./UpgradesRegistryInitCommon.sol";
import "../../../../common/governance/Governable.sol";
import "../../../../common/upgradability/IUpgradable.sol";
import "../../../../common/upgradability/IUpgrade.sol";

contract UpgradesRegistryInitUpgradable is
    IUpgradable,
    Governable,
    UpgradesRegistryInitCommon
{
    function upgrade(uint256 upgradeIndex) external override requestPermission {
        address upgradeAddress = _upgradeProxy(address(this), upgradeIndex);
        bytes4 selector = IUpgrade(address(0x00)).applyUpgrade.selector;

        _methods[selector] = upgradeAddress;
        IUpgrade(address(this)).applyUpgrade();
        delete _methods[selector];
    }

    function getCurrentUpgrades() external view override returns (uint256[] memory) {
        return _getCurrentUpgrades(address(this));
    }

    function getMaxPossibleUpgradeIndex() external view override returns (uint256) {
        return _getProxyMaxPossibleUpgradeIndex(PROXY_ID);
    }
}

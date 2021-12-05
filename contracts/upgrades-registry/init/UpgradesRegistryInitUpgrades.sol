// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./UpgradesRegistryInitCommon.sol";
import "../interfaces/IUpgradesRegistryUpgrades.sol";
import "../../common/governance/Governable.sol";

contract UpgradesRegistryInitUpgrades is
    IUpgradesRegistryUpgrades,
    Governable,
    UpgradesRegistryInitCommon
{
    function registerUpgrade(address upgradeAddress) external override isGovernance {
        (bytes32 proxyId, uint256 upgradeIndex) = _registerUpgrade(upgradeAddress);

        emit UpgradeRegistered(proxyId, upgradeAddress, upgradeIndex);
    }

    function upgradeProxy(uint256 upgradeIndex) external override returns (address) {
        address upgradeAddress = _upgradeProxy(msg.sender, upgradeIndex);

        emit ProxyUpgraded(msg.sender, upgradeIndex);

        return upgradeAddress;
    }

    function getProxyCurrentUpgrades(address proxyAddress) external view override returns (uint256[] memory upgradesIndexes) {
        return _getCurrentUpgrades(proxyAddress);
    }

    function getProxyMaxPossibleUpgradeIndex(bytes32 proxyId) external view override returns (uint256 index) {
        return _getProxyMaxPossibleUpgradeIndex(proxyId);
    }
}
